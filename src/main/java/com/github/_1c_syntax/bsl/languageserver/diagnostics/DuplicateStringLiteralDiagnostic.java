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
package com.github._1c_syntax.bsl.languageserver.diagnostics;

import com.github._1c_syntax.bsl.languageserver.diagnostics.metadata.DiagnosticMetadata;
import com.github._1c_syntax.bsl.languageserver.diagnostics.metadata.DiagnosticParameter;
import com.github._1c_syntax.bsl.languageserver.diagnostics.metadata.DiagnosticSeverity;
import com.github._1c_syntax.bsl.languageserver.diagnostics.metadata.DiagnosticTag;
import com.github._1c_syntax.bsl.languageserver.diagnostics.metadata.DiagnosticType;
import com.github._1c_syntax.bsl.languageserver.utils.Ranges;
import com.github._1c_syntax.bsl.languageserver.utils.RelatedInformation;
import com.github._1c_syntax.bsl.parser.BSLParser;
import com.github._1c_syntax.bsl.parser.BSLParserRuleContext;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.Trees;
import org.eclipse.lsp4j.DiagnosticRelatedInformation;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

@DiagnosticMetadata(
  type = DiagnosticType.CODE_SMELL,
  severity = DiagnosticSeverity.MINOR,
  minutesToFix = 1,
  tags = {
    DiagnosticTag.BADPRACTICE
  }

)
public class DuplicateStringLiteralDiagnostic extends AbstractVisitorDiagnostic {

  /**
   * Разрешенное количество повторов по умолчанию
   */
  private static final int ALLOWED_NUMBER_COPIES = 3;

  /**
   * Анализировать весь файл целиком
   */
  private static final boolean ANALYZE_FILE = false;

  @DiagnosticParameter(
    type = Integer.class,
    defaultValue = "" + ALLOWED_NUMBER_COPIES
  )
  private int allowedNumberCopies = ALLOWED_NUMBER_COPIES;

  @DiagnosticParameter(
    type = Boolean.class,
    defaultValue = "" + ANALYZE_FILE
  )
  private boolean analyzeFile = ANALYZE_FILE;

  @Override
  public void configure(Map<String, Object> configuration) {
    super.configure(configuration);
    // ноль использовать нельзя
    if (allowedNumberCopies < 1) {
      allowedNumberCopies = ALLOWED_NUMBER_COPIES;
    }
  }

  @Override
  public ParseTree visitFile(BSLParser.FileContext ctx) {
    if (analyzeFile) {
      checkStringLiterals(ctx);
      return ctx;
    } else {
      return super.visitFile(ctx);
    }
  }

  @Override
  public ParseTree visitSub(BSLParser.SubContext ctx) {
    checkStringLiterals(ctx);
    return ctx;
  }

  @Override
  public ParseTree visitFileCodeBlock(BSLParser.FileCodeBlockContext ctx) {
    checkStringLiterals(ctx);
    return ctx;
  }

  /**
   * Анализирует литералы блока
   *
   * @param ctx Узел блока для анализа
   */
  private void checkStringLiterals(BSLParserRuleContext ctx) {
    Trees.findAllRuleNodes(ctx, BSLParser.RULE_string).stream()
      .map(BSLParserRuleContext.class::cast)
      .collect(Collectors.groupingBy(literal -> literal.getText().toLowerCase(Locale.ROOT)))
      .forEach((String name, List<BSLParserRuleContext> literals) -> {
        if (literals.size() > allowedNumberCopies) {
          List<DiagnosticRelatedInformation> relatedInformation = new ArrayList<>();
          literals.stream()
            .map(literal -> RelatedInformation.create(
              documentContext.getUri(),
              Ranges.create(literal),
              literal.getText()
            ))
            .collect(Collectors.toCollection(() -> relatedInformation));

          var firstLiteral = literals.get(0);
          diagnosticStorage.addDiagnostic(firstLiteral, info.getMessage(firstLiteral.getText()), relatedInformation);
        }
      });
  }
}
