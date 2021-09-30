/*
 * This file is a part of BSL Language Server.
 *
 * Copyright (c) 2018-2021
 * Alexey Sosnoviy <labotamy@gmail.com>, Nikita Gryzlov <nixel2007@gmail.com> and contributors
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 *
 * BSL Language Server is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3.0 of the License, or (at your option) any later version.
 *
 * BSL Language Server is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with BSL Language Server.
 */
package com.github._1c_syntax.bsl.languageserver.providers;

import com.github._1c_syntax.bsl.languageserver.ClientCapabilitiesHolder;
import com.github._1c_syntax.bsl.languageserver.LanguageClientHolder;
import com.github._1c_syntax.bsl.languageserver.codelenses.CodeLensData;
import com.github._1c_syntax.bsl.languageserver.configuration.LanguageServerConfiguration;
import com.github._1c_syntax.bsl.languageserver.configuration.events.LanguageServerConfigurationChangedEvent;
import com.github._1c_syntax.bsl.languageserver.context.DocumentContext;
import com.github._1c_syntax.bsl.languageserver.context.symbol.MethodSymbol;
import com.github._1c_syntax.bsl.languageserver.util.TestUtils;
import com.google.gson.Gson;
import org.eclipse.lsp4j.ClientCapabilities;
import org.eclipse.lsp4j.CodeLens;
import org.eclipse.lsp4j.CodeLensWorkspaceCapabilities;
import org.eclipse.lsp4j.TextDocumentClientCapabilities;
import org.eclipse.lsp4j.WorkspaceClientCapabilities;
import org.eclipse.lsp4j.services.LanguageClient;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.test.annotation.DirtiesContext;

import java.util.List;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;

@SpringBootTest
@DirtiesContext
class CodeLensProviderTest {

  @Autowired
  private CodeLensProvider codeLensProvider;
  @Autowired
  private LanguageServerConfiguration configuration;
  @Autowired
  private ApplicationEventPublisher applicationEventPublisher;
  @Autowired
  private ClientCapabilitiesHolder clientCapabilitiesHolder;
  @Autowired
  private LanguageClientHolder clientHolder;

  @Test
  void testGetCodeLens() {

    // given
    String filePath = "./src/test/resources/providers/codeLens.bsl";
    DocumentContext documentContext = TestUtils.getDocumentContextFromFile(filePath);

    // when
    List<CodeLens> codeLenses = codeLensProvider.getCodeLens(documentContext);
    codeLenses.forEach(codeLens ->
      codeLensProvider.resolveCodeLens(documentContext, codeLens, (CodeLensData) codeLens.getData())
    );

    // then
    Map<MethodSymbol, Integer> methodsCognitiveComplexity = documentContext.getCognitiveComplexityData().getMethodsComplexity();
    Map<MethodSymbol, Integer> methodsCyclomaticComplexity = documentContext.getCyclomaticComplexityData().getMethodsComplexity();

    MethodSymbol firstMethod = documentContext.getSymbolTree().getMethods().get(0);
    MethodSymbol secondMethod = documentContext.getSymbolTree().getMethods().get(1);
    int cognitiveComplexityFirstMethod = methodsCognitiveComplexity.get(firstMethod);
    int cognitiveComplexitySecondMethod = methodsCognitiveComplexity.get(secondMethod);
    int cyclomaticComplexityFirstMethod = methodsCyclomaticComplexity.get(firstMethod);
    int cyclomaticComplexitySecondMethod = methodsCyclomaticComplexity.get(secondMethod);

    assertThat(codeLenses)
      .hasSize(4)
      .anyMatch(codeLens -> codeLens.getRange().equals(firstMethod.getSubNameRange()))
      .anyMatch(codeLens -> codeLens.getCommand().getTitle().contains(String.valueOf(cognitiveComplexityFirstMethod)))
      .anyMatch(codeLens -> codeLens.getCommand().getTitle().contains(String.valueOf(cyclomaticComplexityFirstMethod)))
      .anyMatch(codeLens -> codeLens.getRange().equals(secondMethod.getSubNameRange()))
      .anyMatch(codeLens -> codeLens.getCommand().getTitle().contains(String.valueOf(cognitiveComplexitySecondMethod)))
      .anyMatch(codeLens -> codeLens.getCommand().getTitle().contains(String.valueOf(cyclomaticComplexitySecondMethod)))
    ;

  }

  @Test
  void testCodeLensRefreshesOnLanguageServerConfigurationChange() {
    // given
    var languageClient = mock(LanguageClient.class);
    clientHolder.connect(languageClient);

    prepareCodeLensRefreshSupport(true);

    // when
    applicationEventPublisher.publishEvent(new LanguageServerConfigurationChangedEvent(configuration));

    // then
    verify(languageClient).refreshCodeLenses();
  }

  @Test
  void testCodeLensDoesNotRefreshOnLanguageServerConfigurationChange_ifLanguageClientDoesNotSupportCodeLensRefresh() {
    // given
    var languageClient = mock(LanguageClient.class);
    clientHolder.connect(languageClient);

    prepareCodeLensRefreshSupport(false);

    // when
    applicationEventPublisher.publishEvent(new LanguageServerConfigurationChangedEvent(configuration));

    // then
    verify(languageClient, never()).refreshCodeLenses();
  }


  @Test
  void testCodeLensRefreshes_ifLanguageClientIsNotConnected() {
    // given
    // no connected language client

    // when
    applicationEventPublisher.publishEvent(new LanguageServerConfigurationChangedEvent(configuration));

    // then
    // no RuntimeException on client method calls
  }

  @Test
  void testExtractData() {

    // given
    String filePath = "./src/test/resources/providers/codeLens.bsl";
    DocumentContext documentContext = TestUtils.getDocumentContextFromFile(filePath);

    // when
    List<CodeLens> codeLenses = codeLensProvider.getCodeLens(documentContext);

    var gson = new Gson();

    for (CodeLens codeLens : codeLenses) {
      var oldData = codeLens.getData();
      var json = gson.toJsonTree(oldData);
      codeLens.setData(json);

      var newConvertedData = codeLensProvider.extractData(codeLens);

      assertThat(oldData).isEqualTo(newConvertedData);
    }
  }

  private void prepareCodeLensRefreshSupport(boolean refreshSupport) {
    var workspaceClientCapabilities = new WorkspaceClientCapabilities();
    workspaceClientCapabilities.setCodeLens(new CodeLensWorkspaceCapabilities(refreshSupport));
    var clientCapabilities = new ClientCapabilities(
      workspaceClientCapabilities,
      mock(TextDocumentClientCapabilities.class),
      mock(Object.class)
    );
    clientCapabilitiesHolder.setCapabilities(clientCapabilities);
  }

}