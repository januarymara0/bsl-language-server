/*
 * This file is a part of BSL Language Server.
 *
 * Copyright (c) 2018-2022
 * Alexey Sosnoviy <labotamy@gmail.com>, Nikita Fedkin <nixel2007@gmail.com> and contributors
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
package com.github._1c_syntax.bsl.languageserver.diagnostics;

import com.github._1c_syntax.bsl.languageserver.context.DocumentContext;
import com.github._1c_syntax.bsl.languageserver.diagnostics.metadata.DiagnosticInfo;
import com.github._1c_syntax.bsl.languageserver.diagnostics.metadata.DiagnosticMetadata;
import com.github._1c_syntax.bsl.languageserver.diagnostics.metadata.DiagnosticScope;
import com.github._1c_syntax.bsl.languageserver.diagnostics.metadata.DiagnosticSeverity;
import com.github._1c_syntax.bsl.languageserver.diagnostics.metadata.DiagnosticTag;
import com.github._1c_syntax.bsl.languageserver.diagnostics.metadata.DiagnosticType;
import com.github._1c_syntax.bsl.languageserver.utils.Trees;
import com.github._1c_syntax.bsl.parser.SDBLParser;
import com.github._1c_syntax.bsl.parser.SDBLParserBaseVisitor;
import com.github._1c_syntax.bsl.parser.Tokenizer;
import lombok.Getter;
import lombok.Setter;
import org.antlr.v4.runtime.tree.ParseTree;
import org.eclipse.lsp4j.Diagnostic;

import java.util.List;

@DiagnosticMetadata(
  type = DiagnosticType.CODE_SMELL,
  severity = DiagnosticSeverity.MAJOR,
  minutesToFix = 5,
  tags = {
    DiagnosticTag.STANDARD,
    DiagnosticTag.SQL,
    DiagnosticTag.BADPRACTICE
  },
  scope = DiagnosticScope.BSL
)
public class QueryParseErrorDiagnostic extends SDBLParserBaseVisitor<ParseTree> implements BSLDiagnostic {

  @Getter
  @Setter
  protected DiagnosticInfo info;
  protected final DiagnosticStorage diagnosticStorage = new DiagnosticStorage(this);
  protected DocumentContext documentContext;

  @Override
  public List<Diagnostic> getDiagnostics(DocumentContext documentContext) {
    this.documentContext = documentContext;
    diagnosticStorage.clearDiagnostics();
    var queries = documentContext.getQueries();
    if (!queries.isEmpty()) {
      queries.stream()
        .map(Tokenizer::getAst)
        .forEach(this::visitQueryPackage);
    }

    return diagnosticStorage.getDiagnostics();
  }

  @Override
  // анализируем каждый запрос пакета
  public ParseTree visitQueries(SDBLParser.QueriesContext ctx) {
    if (Trees.treeContainsErrors(ctx)) {
      diagnosticStorage.addDiagnostic(ctx);
    }
    return ctx;
  }
}
