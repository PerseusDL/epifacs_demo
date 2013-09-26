<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-tpl-apparatus.xsl 1497 2008-08-12 13:51:16Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="1.0">
  <!-- Apparatus creation: look in htm-tpl-apparatus.xsl for documentation -->
  <xsl:import href="epidoc/htm-tpl-apparatus.xsl"/>

  <!-- Override generate-app-link to generate linked <sup> -->
  <xsl:template name="generate-app-link">
    <xsl:param name="location"/>
    <xsl:param name="app-num"/>
    <xsl:choose>
       <xsl:when test="$location = 'text'">
          <sup>
            <a href="#app{$app-num}"><xsl:value-of select="$app-num"/></a>
          </sup>
       </xsl:when>
       <xsl:when test="$location = 'apparatus'">
          <sup>
            <a name="app{$app-num}"><xsl:value-of select="$app-num"/></a>
          </sup>
       </xsl:when>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>