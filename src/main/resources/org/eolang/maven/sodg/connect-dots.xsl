<?xml version="1.0" encoding="UTF-8"?>
<!--
 * SPDX-FileCopyrightText: Copyright (c) 2016-2025 Objectionary.com
 * SPDX-License-Identifier: MIT
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:eo="https://www.eolang.org" id="connect-dots" version="2.0">
  <!--
  Here we find objects with "dot notation" in the @base
  attribute and attach a proper ATOM to their vertices.
  -->
  <xsl:import href="/org/eolang/maven/sodg/_macros.xsl"/>
  <xsl:output encoding="UTF-8" method="xml"/>
  <xsl:template match="/object/sodg">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
      <xsl:apply-templates select="/object/o//o" mode="sodg"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="o[@base and not(@level) and starts-with(@base, '.')]" mode="sodg" priority="1">
    <xsl:variable name="v1">
      <xsl:value-of select="@loc"/>
      <xsl:text>.β1</xsl:text>
    </xsl:variable>
    <xsl:variable name="v2">
      <xsl:value-of select="@loc"/>
      <xsl:text>.β2</xsl:text>
    </xsl:variable>
    <xsl:for-each select="$v1, $v2">
      <xsl:call-template name="i">
        <xsl:with-param name="name" select="'ADD'"/>
        <xsl:with-param name="args" as="item()*">
          <xsl:sequence>
            <xsl:value-of select="eo:var(.)"/>
          </xsl:sequence>
        </xsl:with-param>
        <xsl:with-param name="comment">
          <xsl:text>Linking point</xsl:text>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:for-each>
    <xsl:call-template name="i">
      <xsl:with-param name="name" select="'BIND'"/>
      <xsl:with-param name="args" as="item()*">
        <xsl:sequence>
          <xsl:value-of select="eo:var($v2)"/>
        </xsl:sequence>
        <xsl:sequence>
          <xsl:value-of select="eo:var($v1)"/>
        </xsl:sequence>
        <xsl:sequence>
          <xsl:text>β</xsl:text>
        </xsl:sequence>
      </xsl:with-param>
      <xsl:with-param name="comment">
        <xsl:text>This is a dot-notation</xsl:text>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="i">
      <xsl:with-param name="name" select="'BIND'"/>
      <xsl:with-param name="args" as="item()*">
        <xsl:sequence>
          <xsl:value-of select="eo:var($v1)"/>
        </xsl:sequence>
        <xsl:sequence>
          <xsl:value-of select="eo:var(o[1]/@loc)"/>
        </xsl:sequence>
        <xsl:sequence>
          <xsl:variable name="attr">
            <xsl:value-of select="substring(@base, 2)"/>
          </xsl:variable>
          <xsl:choose>
            <xsl:when test="$attr='^'">
              <xsl:text>ρ</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$attr"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:sequence>
      </xsl:with-param>
      <xsl:with-param name="comment">
        <xsl:text>This is a dot-notation</xsl:text>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="i">
      <xsl:with-param name="name" select="'BIND'"/>
      <xsl:with-param name="args" as="item()*">
        <xsl:sequence>
          <xsl:value-of select="eo:var(@loc)"/>
        </xsl:sequence>
        <xsl:sequence>
          <xsl:value-of select="eo:var($v2)"/>
        </xsl:sequence>
        <xsl:sequence>
          <xsl:choose>
            <xsl:when test="count(o) &gt; 1">
              <xsl:text>π</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>ε</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:sequence>
      </xsl:with-param>
      <xsl:with-param name="comment">
        <xsl:text>This is a dot-notation</xsl:text>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="i">
      <xsl:with-param name="name" select="'BIND'"/>
      <xsl:with-param name="args" as="item()*">
        <xsl:sequence>
          <xsl:value-of select="eo:var($v2)"/>
        </xsl:sequence>
        <xsl:sequence>
          <xsl:value-of select="eo:var(o[1]/@loc)"/>
        </xsl:sequence>
        <xsl:sequence>
          <xsl:text>ρ</xsl:text>
        </xsl:sequence>
      </xsl:with-param>
      <xsl:with-param name="comment">
        <xsl:text>This is a dot-notation</xsl:text>
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
