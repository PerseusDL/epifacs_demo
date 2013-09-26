<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: start-edition.xsl 1510 2008-08-14 15:27:51Z zau $ -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:cts="http://chs.harvard.edu/xmlns/cts3">

  <xsl:include href="global-varsandparams.xsl"/>

  <!-- html related stylesheets, these may import tei{element} stylesheets if relevant eg. htm-teigap and teigap -->
  <xsl:include href="epidoc.xlst2/htm-teiab.xsl"/>
  <xsl:include href="epidoc.xlst2/htm-teiapp.xsl"/>
  <xsl:include href="epidoc.xlst2/htm-teidiv.xsl"/>
  <xsl:include href="epidoc.xlst2/htm-teidivedition.xsl"/>
  <xsl:include href="epidoc.xlst2/htm-teiforeign.xsl"/>
  <xsl:include href="epidoc.xlst2/htm-teifigure.xsl"/>
  <xsl:include href="epidoc.xlst2/htm-teig.xsl"/>
  <xsl:include href="epidoc.xlst2/htm-teigap.xsl"/>
  <xsl:include href="epidoc.xlst2/htm-teihead.xsl"/>
  <xsl:include href="epidoc.xlst2/htm-teihi.xsl"/>
  <xsl:include href="epidoc.xlst2/htm-teilb.xsl"/>
  <xsl:include href="epidoc.xlst2/htm-teilgandl.xsl"/>
  <xsl:include href="epidoc.xlst2/htm-teilistanditem.xsl"/>
  <xsl:include href="epidoc.xlst2/htm-teilistbiblandbibl.xsl"/>
  <xsl:include href="epidoc.xlst2/htm-teimilestone.xsl"/>
  <xsl:include href="epidoc.xlst2/htm-teinote.xsl"/>
  <xsl:include href="epidoc.xlst2/htm-teinum.xsl"/>
  <xsl:include href="epidoc.xlst2/htm-teip.xsl"/>
  <xsl:include href="epidoc.xlst2/htm-teiseg.xsl"/>
  <xsl:include href="epidoc.xlst2/htm-teispace.xsl"/>
  <xsl:include href="epidoc.xlst2/htm-teisupplied.xsl"/>
  <xsl:include href="epidoc.xlst2/htm-teiterm.xsl"/>
  <xsl:include href="epidoc.xlst2/htm-teiaddanddel.xsl"/>
  
  <xsl:include href="htm-teixref.xsl"/>

  <!-- tei stylesheets that are also used by start-txt -->
  <xsl:include href="epidoc.xlst2/teiabbrandexpan.xsl"/>
  <xsl:include href="epidoc.xlst2/teicertainty.xsl"/>
  <xsl:include href="epidoc.xlst2/teichoice.xsl"/>
  <xsl:include href="epidoc.xlst2/teihandshift.xsl"/>
  <xsl:include href="epidoc.xlst2/teiheader.xsl"/>
  <xsl:include href="epidoc.xlst2/teimilestone.xsl"/>
  <xsl:include href="epidoc.xlst2/teiorig.xsl"/>
  <xsl:include href="epidoc.xlst2/teiorigandreg.xsl"/>
  <xsl:include href="epidoc.xlst2/teiq.xsl"/>
  <xsl:include href="epidoc.xlst2/teisicandcorr.xsl"/>
  <xsl:include href="epidoc.xlst2/teispace.xsl"/>
  <xsl:include href="epidoc.xlst2/teisupplied.xsl"/>
  <xsl:include href="epidoc.xlst2/teisurplus.xsl"/>
  <xsl:include href="epidoc.xlst2/teiunclear.xsl"/>

  <!-- html related stylesheets for named templates -->
  <xsl:include href="epidoc.xlst2/htm-tpl-lang.xsl"/>
  <xsl:include href="epidoc.xlst2/htm-tpl-license.xsl"/>
  
  <xsl:include href="htm-tpl-scripts.xsl"/>
  <xsl:include href="htm-tpl-apparatus-portlet.xsl"/>
  <!-- xsl:include href="htm-tpl-metadata.xsl"/ -->
  <xsl:include href="htm-tpl-nav-pn.xsl"/>

  <!-- global named templates with no html, also used by start-txt -->
  <xsl:include href="epidoc.xlst2/tpl-reasonlost.xsl"/>
  <xsl:include href="epidoc.xlst2/tpl-certlow.xsl"/>
  <xsl:include href="epidoc.xlst2/tpl-text.xsl"/>



  <!-- HTML FILE -->
  <xsl:template match="/">
    <!-- <xsl:param name='leiden-style'>ddbdp</xsl:param> -->
        <!-- Found in htm-tpl-cssandscripts.xsl -->
        <xsl:call-template name="css-script"/>

        <!-- Found in htm-tpl-nav.xsl -->
        <!-- xsl:call-template name="topNavigation"/-->

        <!-- Found in htm-tpl-metadata.xsl -->
        <!-- Would need to change once combined -->
        <xsl:if test="starts-with(//TEI/@id, 'hgv')">
          <xsl:call-template name="metadata"/>
        </xsl:if>
        
        
        <!-- Main text output -->  
      <!--
      <xsl:apply-templates select="//cts:reply//tei:TEI//tei:div[@type='translation']"/>
      <xsl:apply-templates select="//cts:reply//tei:TEI//tei:div[@type='commentary']"/>
      <xsl:apply-templates select="//cts:reply//tei:TEI//tei:div[@type='edition']"/>
      -->
      <xsl:apply-templates select="//cts:reply//tei:TEI"/>
  </xsl:template>
  <xsl:template name="metadata"></xsl:template>

  <!--xsl:template match="tei:w[@rend]">
      <span class="{@rend}" urn="urn:cts:epigraphy.perseus.org:igvii.2543-2545.perseus-grc1:2543.1:Σκῆνος[1]"><xsl:value-of select="."/></span>
  </xsl:template-->

</xsl:stylesheet>
