<?xml version="1.0" encoding="UTF-8"?>
<!--
 * SPDX-FileCopyrightText: Copyright (c) 2016-2025 Objectionary.com
 * SPDX-License-Identifier: MIT
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:eo="https://www.eolang.org" id="put-atoms" version="2.0">
  <!--
  Here we attach atoms to vertices using ATOM instruction.
  -->
  <xsl:import href="/org/eolang/maven/sodg/_macros.xsl"/>
  <xsl:import href="/org/eolang/parser/_funcs.xsl"/>
  <xsl:output encoding="UTF-8" method="xml"/>
  <xsl:template match="/object/sodg">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
      <xsl:apply-templates select="/object/o//o" mode="sodg"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="o[@name and eo:atom(.) and not(@base)]" mode="sodg" priority="1">
    <xsl:variable name="v">
      <xsl:value-of select="@loc"/>
      <xsl:text>.λ</xsl:text>
    </xsl:variable>
    <xsl:call-template name="i">
      <xsl:with-param name="name" select="'ADD'"/>
      <xsl:with-param name="args" as="item()*">
        <xsl:sequence>
          <xsl:value-of select="eo:var($v)"/>
        </xsl:sequence>
      </xsl:with-param>
      <xsl:with-param name="comment">
        <xsl:text>This is a lambda vertex for "</xsl:text>
        <xsl:value-of select="@loc"/>
        <xsl:text>"</xsl:text>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="i">
      <xsl:with-param name="name" select="'BIND'"/>
      <xsl:with-param name="args" as="item()*">
        <xsl:sequence>
          <xsl:value-of select="eo:var(@loc)"/>
        </xsl:sequence>
        <xsl:sequence>
          <xsl:value-of select="eo:var($v)"/>
        </xsl:sequence>
        <xsl:sequence>
          <xsl:text>λ</xsl:text>
        </xsl:sequence>
      </xsl:with-param>
      <xsl:with-param name="comment">
        <xsl:text>This is an edge for the lambda vertex</xsl:text>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="i">
      <xsl:with-param name="name" select="'PUT'"/>
      <xsl:with-param name="args" as="item()*">
        <xsl:sequence>
          <xsl:value-of select="eo:var($v)"/>
        </xsl:sequence>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="o" mode="sodg">
    <!-- ignore them -->
  </xsl:template>
  <xsl:template match="node()|@*" mode="#default">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*" mode="#current"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
