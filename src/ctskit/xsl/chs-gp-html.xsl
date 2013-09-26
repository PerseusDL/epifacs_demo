<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:cts="http://chs.harvard.edu/xmlns/cts3"
    xmlns:dc="http://purl.org/dc/elements/1.1" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output omit-xml-declaration="yes" method="html" encoding="UTF-8" />
    <!-- Framework for main body of document -->
    <xsl:template match="/">
        <!-- can some of the reply contents in xsl variables
			for convenient use in different parts of the output -->
        <xsl:variable name="urnString">
            <xsl:value-of select="//cts:request/cts:requestUrn" />
        </xsl:variable>
        <xsl:variable name="psg">
            <xsl:value-of select="//cts:request/cts:psg" />
        </xsl:variable>
        <xsl:variable name="workUrn">
            <xsl:value-of select="//cts:request/cts:workUrn" />
        </xsl:variable>
        <html>
            <head>
                <link href="normalize.css" rel="stylesheet" title="CSS for CTS" type="text/css" />
                <link href="app.css" rel="stylesheet" title="CSS for CTS" type="text/css" />
                <link href="chs_tei.css" rel="stylesheet" title="CSS for CTS" type="text/css" />
                <link href="local.css" rel="stylesheet" title="CSS for CTS" type="text/css" />
                <xsl:choose>
                    <xsl:when test="/cts:CTSError">
                        <title>Error</title>
                    </xsl:when>
                    <xsl:otherwise>
                        <title><xsl:value-of select="//cts:request/cts:groupname" />, <xsl:value-of
                            select="//cts:request/cts:title" /> : <xsl:value-of
                            select="//cts:request/cts:label" /> </title>
                    </xsl:otherwise>
                </xsl:choose>
            </head>
            <body>
                <script src="getPassage.js" type="text/javascript" />
               
                <article>
                    <xsl:choose>
                        <xsl:when test="/cts:CTSError">
                            <xsl:apply-templates select="cts:CTSError" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:choose>
                                <xsl:when test="//cts:request/cts:edition">
                                    <h1><xsl:value-of select="//cts:request/cts:groupname" />, <em>
                                        <xsl:value-of select="//cts:request/cts:title" /> </em>:
                                        <xsl:value-of select="//cts:request/cts:psg" /> </h1>
                                    <h2>
                                        <xsl:value-of select="//cts:request/cts:label" />
                                    </h2>
                                </xsl:when>
                                <xsl:when test="//cts:request/cts:translation">
                                    <h1> <xsl:value-of select="//cts:request/cts:groupname" />, <em>
                                        <xsl:value-of select="//cts:request/cts:title" /> </em>:
                                        <xsl:value-of select="//cts:request/cts:psg" /></h1>
                                    <h2>
                                        <xsl:value-of select="//cts:request/cts:label" />
                                    </h2>
                                </xsl:when>
                                <xsl:when test="//cts:request/cts:title">
                                    <h1> <xsl:value-of select="//cts:request/cts:groupname" />, <em>
                                        <xsl:value-of select="//cts:request/cts:title" />:</em>
                                        <xsl:value-of select="//cts:request/cts:psg" /> </h1>
                                    <h2>
                                        <xsl:value-of select="//cts:request/cts:label" />
                                    </h2>
                                </xsl:when>
                                <xsl:when test="//cts:request/cts:groupname">
                                    <h1>
                                        <xsl:value-of select="//cts:request/cts:groupname" />
                                    </h1>
                                    <h2>
                                        <xsl:value-of select="//cts:request/cts:label" />
                                    </h2>
                                </xsl:when>
                            </xsl:choose>
                            <p class="urn"> ( = <xsl:value-of select="$urnString" /> ) </p>
                            <xsl:apply-templates select="//cts:reply" />
                        </xsl:otherwise>
                    </xsl:choose>
                   
                </article>
                <footer>
                  
                </footer>
            </body>
        </html>
    </xsl:template>
    <!-- End Framework for main body document -->
    <!-- Match elements of the CTS reply -->
    <xsl:template match="cts:reply">
       
        <xsl:element name="div">
            <xsl:attribute name="lang">
                <xsl:value-of select="@xml:lang" />
            </xsl:attribute>
            <xsl:if test="(//cts:reply/@xml:lang = 'grc') or (//cts:reply/@xml:lang = 'lat')">
                <xsl:attribute name="class">cts-content alpheios-enabled-text</xsl:attribute>
            </xsl:if>
            <!-- This is where we will catch TEI markup -->
            <xsl:apply-templates />
            <!-- ====================================== -->
        </xsl:element>
    </xsl:template>
    <xsl:template match="cts:CTSError">
        <h1>CTS Error</h1>
        <p class="cts:error">
            <xsl:apply-templates select="cts:message" />
        </p>
        <p>Error code: <xsl:apply-templates select="cts:code" /></p>
        <p>Error code: <xsl:apply-templates select="cts:code" /></p>
        <p>CTS library version: <xsl:apply-templates select="cts:libraryVersion" /> </p>
        <p>CTS library date: <xsl:apply-templates select="cts:libraryDate" /> </p>
    </xsl:template>
    <xsl:template match="cts:contextinfo">
        <xsl:variable name="ctxt">
            <xsl:value-of select="cts:context" />
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$ctxt > 0">
                <div class="prevnext"> <span class="prv"> <xsl:choose> <xsl:when test="//cts:inv">
                    <xsl:variable name="inv"> <xsl:value-of select="//cts:inv" /> </xsl:variable>
                    <xsl:variable name="prvVar">./CTS?inv=<xsl:value-of select="$inv"
                     />&amp;request=GetPassagePlus&amp;withXSLT=chs-gp&amp;urn=<xsl:value-of
                    select="cts:contextback" />&amp;context=<xsl:value-of select="$ctxt"
                     /></xsl:variable> <xsl:element name="a"> <xsl:attribute name="href">
                    <xsl:value-of select="$prvVar" /> </xsl:attribute> back </xsl:element>
                    </xsl:when> <xsl:otherwise> <xsl:variable name="prvVar"
                    >./CTS?request=GetPassagePlus&amp;withXSLT=chs-gp&amp;urn=<xsl:value-of
                    select="cts:contextback" />&amp;context=<xsl:value-of select="$ctxt"
                     /></xsl:variable> <xsl:element name="a"> <xsl:attribute name="href">
                    <xsl:value-of select="$prvVar" /> </xsl:attribute> back </xsl:element>
                    </xsl:otherwise> </xsl:choose> </span>| <span class="nxt"> <xsl:choose>
                    <xsl:when test="//cts:inv"> <xsl:variable name="inv"> <xsl:value-of
                    select="//cts:inv" /> </xsl:variable> <xsl:variable name="nxtVar"
                    >./CTS?inv=<xsl:value-of select="$inv"
                     />&amp;request=GetPassagePlus&amp;withXSLT=chs-gp&amp;urn=<xsl:value-of
                    select="cts:contextforward" />&amp;context=<xsl:value-of select="$ctxt"
                     /></xsl:variable> <xsl:element name="a"> <xsl:attribute name="href">
                    <xsl:value-of select="$nxtVar" /> </xsl:attribute> forward </xsl:element>
                    </xsl:when> <xsl:otherwise> <xsl:variable name="nxtVar"
                    >./CTS?request=GetPassagePlus&amp;withXSLT=chs-gp&amp;urn=<xsl:value-of
                    select="cts:contextforward" />&amp;context=<xsl:value-of select="$ctxt"
                     /></xsl:variable> <xsl:element name="a"> <xsl:attribute name="href">
                    <xsl:value-of select="$nxtVar" /> </xsl:attribute> forward </xsl:element>
                    </xsl:otherwise> </xsl:choose> </span> </div>
            </xsl:when>
            <xsl:otherwise />
        </xsl:choose>
    </xsl:template>
    <xsl:template match="cts:prevnext">
    </xsl:template>
    <xsl:template match="tei:unclear">
        <span class="tei_unclear">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    <xsl:template match="tei:supplied">
        <xsl:element name="span">
            <xsl:choose>
                <xsl:when test="@reason='lost'">
                    <xsl:attribute name="class">tei_supplied reason_lost</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="class">tei_supplied unrecognized_reason</xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <!-- This stylesheet includes templates for handling all TEI elements used in CHS diplomatic editions. -->
    <xsl:template match="tei:add">
        <span class="tei_add">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    <xsl:template match="tei:bibl">
        <!-- Check for xml:lang -->
        <xsl:element name="span">
            <xsl:attribute name="class">tei_bibl</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:choice">
        <span class="tei_choice">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    <xsl:template match="tei:cit">
        <!-- Check for xml:lang -->
        <xsl:element name="blockquote">
            <xsl:attribute name="class">tei_cit</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:corr">
        <span class="tei_corr">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    <xsl:template match="tei:del">
        <span class="tei_del">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    <xsl:template match="tei:div">
        <!-- Check for xml:lang -->
        <xsl:choose>
            <xsl:when test="@type='book'">
                <div class="div_book">
                    <p class="citation_value">
                        <xsl:value-of select="@n" />
                    </p>
                    <xsl:apply-templates />
                </div>
            </xsl:when>
            <xsl:when test="@type='chapter'">
                <div class="div_book">
                    <p class="citation_value">
                        <xsl:value-of select="@n" />
                    </p>
                    <xsl:apply-templates />
                </div>
            </xsl:when>
            <xsl:when test="@type='section'">
                <div class="div_section">
                    <p class="citation_value">
                        <xsl:value-of select="@n" />
                    </p>
                    <xsl:apply-templates />
                </div>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="div">
                    <xsl:if test="@type">
                        <xsl:attribute name="class">tei_<xsl:value-of select="@type"
                             /></xsl:attribute>
                    </xsl:if>
                    <xsl:if test="@n">
                        <p class="tei_n">
                            <xsl:value-of select="@n" />
                        </p>
                    </xsl:if>
                    <xsl:apply-templates />
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:abbr">
        <span class="tei_abbr">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    <xsl:template match="tei:expan">
        <span class="tei_expan">
            <xsl:apply-templates />
        </span>
    </xsl:template>
    <xsl:template match="tei:foreign">
        <!-- xml:lang required -->
        <xsl:element name="span">
            <xsl:attribute name="class">tei_foreign</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:gap">
        <xsl:element name="span"> <xsl:choose> <xsl:when test="@unit = 'line'"> <xsl:attribute
            name="class">tei_gap unit_line</xsl:attribute> </xsl:when> <xsl:when
            test="@unit = 'character'"> <xsl:attribute name="class">tei_gap
            unit_char</xsl:attribute> </xsl:when> <xsl:otherwise> <xsl:attribute name="class"
            >tei_gap</xsl:attribute> </xsl:otherwise> </xsl:choose> &#160;<xsl:value-of
            select="@extent" />&#160; </xsl:element>
    </xsl:template>
    <xsl:template match="tei:head">
        <!-- Check for xml:lang -->
        <xsl:element name="div">
            <xsl:attribute name="class">tei_head</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:l">
        <p class="tei_l">
            <span class="citation_value">
                <!-- @n for citation required -->
                <xsl:value-of select="@n" />
            </span>
            <xsl:apply-templates />
        </p>
    </xsl:template>
    <xsl:template match="tei:list">
        <ul>
            <xsl:apply-templates />
        </ul>
    </xsl:template>
    <xsl:template match="tei:item">
        <li>
            <xsl:apply-templates />
        </li>
    </xsl:template>
    <xsl:template match="tei:lg">
        <div class="tei_lg">
            <span class="citation_value">
                <!-- @n for citation required -->
                <xsl:value-of select="@n" />
            </span>
            <xsl:apply-templates />
        </div>
    </xsl:template>
    <xsl:template match="tei:note">
        <!-- Check for xml:lang -->
        <xsl:element name="span">
            <xsl:attribute name="class">tei_note</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:num">
        <span class="tei_num">
            <xsl:apply-templates />
            <xsl:if test="@value">
                <span class="num_value">
                    <xsl:value-of select="@value" />
                </span>
            </xsl:if>
        </span>
    </xsl:template>
    <xsl:template match="tei:p">
        <p>
            <xsl:apply-templates />
        </p>
    </xsl:template>
    <xsl:template match="tei:q">
        <!-- Check for xml:lang -->
        <xsl:element name="span">
            <xsl:attribute name="class">tei_q</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:pb">
        <br />
        <span class="tei_pb">
            <xsl:value-of select="@n" />
        </span>
        <br />
    </xsl:template>
    <xsl:template match="tei:lb">
        <span class="tei_lb" />
    </xsl:template>
    <xsl:template match="tei:quote">
        <!-- Check for xml:lang -->
        <xsl:element name="span">
            <xsl:attribute name="class">tei_quote</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:seg">
        <xsl:element name="span">
            <xsl:choose>
                <xsl:when test="@type='word'">
                    <xsl:attribute name="class">chs_word</xsl:attribute>
                </xsl:when>
                <xsl:when test="@type='verse'">
                    <xsl:attribute name="class">chs_verse</xsl:attribute>
                    <span class="citation_value">
                        <!-- @n for citation required -->
                        <xsl:value-of select="@n" />
                    </span>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="class">unrecognized_seg</xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:sic">
        <xsl:element name="span">
            <xsl:attribute name="class">tei_sic</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <!-- Default: replicate unrecognized markup -->
    <xsl:template match="@*|node()" priority="-1">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
