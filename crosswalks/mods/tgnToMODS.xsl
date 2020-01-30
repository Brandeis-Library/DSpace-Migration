<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:vp="http://localhost/WebServiceVocabs/Schemas/Export"
    exclude-result-prefixes="xs"
    version="1.0">
    <xsl:variable name="tgnLookup" select="document('tgnLookup.xml')"/>
    <xsl:output method="text" indent="no"/>
    <xsl:template match="/vp:Vocabulary">
        <xsl:apply-templates select="vp:Subject"/>
    </xsl:template>
    <xsl:template match="vp:Subject">
        <xsl:variable name="varId">
            <xsl:value-of select="@Subject_ID"/>  
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$tgnLookup/tgnLookUp/tgn_subject[@Subject_ID=$varId]/@match='Y'">
                <xsl:value-of select="@Subject_ID"/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select="vp:Terms/vp:Preferred_Term/vp:Term_Text"/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select="vp:Parent_Relationships/vp:Preferred_Parent/vp:Parent_String"/>
                <xsl:text>,</xsl:text>
                <xsl:apply-templates select="vp:Coordinates/vp:Standard/vp:Latitude"/>
                <xsl:text>,</xsl:text>
                <xsl:apply-templates select="vp:Coordinates/vp:Standard/vp:Longitude"/>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="vp:Latitude">
        <xsl:text>LAT:</xsl:text>
        <xsl:value-of select="vp:Degrees"/>
        <xsl:value-of select="concat('||',vp:Minutes)"/>
        <xsl:value-of select="concat('||',vp:Seconds)"/>
        <xsl:value-of select="concat('||',vp:Direction)"/>
        <xsl:value-of select="concat('||',vp:Decimal)"/>
    </xsl:template>
    <xsl:template match="vp:Longitude">
    <xsl:text>LONG:</xsl:text>
    <xsl:value-of select="vp:Degrees"/>
    <xsl:value-of select="concat('||',vp:Minutes)"/>
    <xsl:value-of select="concat('||',vp:Seconds)"/>
    <xsl:value-of select="concat('||',vp:Direction)"/>
    <xsl:value-of select="concat('||',vp:Decimal)"/>
</xsl:template>
</xsl:stylesheet>