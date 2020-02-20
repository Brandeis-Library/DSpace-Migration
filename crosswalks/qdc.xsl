<?xml version="1.0" encoding="UTF-8" ?>
<!-- 


    The contents of this file are subject to the license and copyright
        detailed in the LICENSE and NOTICE files at the root of the source
            tree and available online at

    http://www.dspace.org/license/
    Developed by DSpace @ Lyncode <jmelo@lyncode.com>

> http://www.openarchives.org/OAI/2.0/oai_dc.xsd

Modified for DSpace -> ALMA-D
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
     xmlns:doc="http://www.lyncode.com/xoai" version="1.0">
     <xsl:output omit-xml-declaration="yes" method="xml" indent="yes"/>
     <xsl:template match="/">
          <qdc:qualifieddc xmlns:qdc="http://dspace.org/qualifieddc/" 
               xmlns:dc="http://purl.org/dc/elements/1.1/" 
               xmlns:dcterms="http://purl.org/dc/terms/" 
               xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://purl.org/dc/elements/1.1/ http://dublincore.org/schemas/xmls/qdc/2006/01/06/dc.xsd http://purl.org/dc/terms/ http://dublincore.org/schemas/xmls/qdc/2006/01/06/dcterms.xsd http://dspace.org/qualifieddc/ http://www.ukoln.ac.uk/metadata/dcmi/xmlschema/qualifieddc.xsd">
               <!-- 
               dc:title 
               -->
               <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='title']">
                    <xsl:for-each select="doc:element">
                         <xsl:choose>
                              <xsl:when test="@name='alternative'">
                                   <xsl:for-each select="doc:element/doc:field[@name='value']">
                                        <dcterms:alternative>
                                             <xsl:value-of select="."/>
                                        </dcterms:alternative>
                                   </xsl:for-each>
                              </xsl:when>
                              <xsl:otherwise>
                                   <dc:title>
                                        <xsl:value-of select="doc:field[@name='value']"/>
                                   </dc:title>
                              </xsl:otherwise>
                         </xsl:choose>
                    </xsl:for-each>
               </xsl:for-each>
               <!-- 
               dc.creator 
               -->
               <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='creator']/doc:element/doc:field[@name='value']">
                    <dc:creator>
                         <xsl:value-of select="."/>
                    </dc:creator>
               </xsl:for-each>
               <!--
               dc.creator
               -->
               <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='author']/doc:element/doc:field[@name='value']">
                    <dc:creator>
                         <xsl:value-of select="."/>
                    </dc:creator>
               </xsl:for-each>
               <!--
               dc.contributor
               -->
               <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name!='author']/doc:field[@name='value']">
                    <dc:contributor>
                         <xsl:value-of select="."/>
                    </dc:contributor>
               </xsl:for-each>
               <!-- 
               dc.subject.* 
               -->
               <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='subject']">
                    <xsl:for-each select="doc:element">
                         <xsl:choose>
                              <xsl:when test="@name='other'">
                                   <xsl:for-each select="doc:element/doc:field[@name='value']">
                                        <dc:subject>
                                             <xsl:value-of select="."/>
                                        </dc:subject>
                                   </xsl:for-each>
                              </xsl:when>
                              <xsl:when test="@name='none'">
                                   <xsl:for-each select="doc:field[@name='value']">
                                        <dc:subject>
                                             <xsl:value-of select="."/>
                                        </dc:subject>
                                   </xsl:for-each>
                              </xsl:when>
                              <xsl:when test="@name='lcsh'">
                                   <xsl:for-each select="doc:element/doc:field[@name='value']">
                                        <dc:subject xsi:type="dcterms:LCSH">
                                             <xsl:value-of select="."/>
                                        </dc:subject>
                                   </xsl:for-each>
                              </xsl:when>
                              <xsl:when test="@name='aat'">
                                   <xsl:for-each select="doc:element/doc:field[@name='value']">
                                        <dc:subject>
                                             <xsl:value-of select="."/>
                                        </dc:subject>
                                   </xsl:for-each>
                              </xsl:when>
                              <xsl:otherwise>
                              <!--
                              <xsl:variable name="varAuth">
                                   <xsl:value-of select="@name"/>
                              </xsl:variable>
                              <xsl:for-each select="doc:element/doc:field">
                                   <xsl:element name="dc:subject">
                                        <xsl:attribute name="xsi:type">
                                             <xsl:value-of select="concat('http://purl.org/dc/terms/',$varAuth)"/>
                                        </xsl:attribute>
                                        <xsl:value-of select="."/>
                                   </xsl:element>
                              </xsl:for-each>
                              -->
                              </xsl:otherwise>
                         </xsl:choose>
                    </xsl:for-each>
               </xsl:for-each>
               <!-- 
               dc.description
               -->
               <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element">
                    <xsl:choose>
                         <xsl:when test="@name='abstract'">
                              <xsl:for-each select="doc:field[@name='value']">
                                   <dcterms:abstract>
                                        <xsl:value-of select="."/>
                                   </dcterms:abstract>
                              </xsl:for-each>
                         </xsl:when>
                         <xsl:when test="@name='provenance'">
                              <xsl:for-each select="doc:field[@name='value']">
                                   <dcterms:provenance>
                                        <xsl:value-of select="."/>
                                   </dcterms:provenance>
                              </xsl:for-each>
                         </xsl:when>
                         <xsl:otherwise>
                              <dc:description>
                                   <xsl:value-of select="doc:field[@name='value']"/>
                              </dc:description>
                         </xsl:otherwise>
                    </xsl:choose>
               </xsl:for-each>
               <!-- 
               dc.date
               -->
               <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='available']/doc:element/doc:field[@name='value']">
                    <dcterms:dateAccepted>
                         <xsl:value-of select="."/>
                    </dcterms:dateAccepted>
               </xsl:for-each>
               <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='available']/doc:element/doc:field[@name='value']">
                    <dcterms:available>
                         <xsl:value-of select="."/>
                    </dcterms:available>
               </xsl:for-each>
               <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='available']/doc:element/doc:field[@name='value']">
                    <dcterms:created>
                         <xsl:value-of select="."/>
                    </dcterms:created>
               </xsl:for-each>
               <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='issued']/doc:element/doc:field[@name='value']">
                    <dcterms:issued>
                         <xsl:value-of select="."/>
                    </dcterms:issued>
               </xsl:for-each>
               <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='copyright']/doc:element/doc:field[@name='value']">
                    <dcterms:dateCopyrighted>
                         <xsl:value-of select="."/>
                    </dcterms:dateCopyrighted>
               </xsl:for-each>
               <!-- 
               dc.type
               -->
               <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']">
                    <dc:type>
                         <xsl:value-of select="."/>
                    </dc:type>
               </xsl:for-each>
               <!--
               dc:identifier
               -->
               <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element">
                    <xsl:choose>
                         <xsl:when test="@name='none'">
                              <xsl:for-each select="doc:element/doc:field[@name='value']">
                                   <dc:identifier>
                                        <xsl:value-of select="."/>
                                   </dc:identifier>
                              </xsl:for-each>
                         </xsl:when>
                    </xsl:choose>
               </xsl:for-each>
               <xsl:element name="dc:identifier">
                    <xsl:value-of select="concat('hdl:',/doc:metadata/doc:element[@name='others']/doc:field[@name='handle'])"/>
               </xsl:element>
               <xsl:element name="dc:identifier">
                    <xsl:attribute name="xsi:type">
                         <xsl:text>dcterms:URI</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="/doc:metadata/doc:element[@name='bundles']/doc:element[@name='bundle'][doc:field[text()='ORIGINAL']]/doc:element/doc:element[1]/doc:field[@name='url']"/>
               </xsl:element>
               <!-- 
               dc.language
               -->
               <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='language']/doc:element">
                    <xsl:choose>
                         <xsl:when test="@name='none'">
                              <xsl:for-each select="doc:field[@name='value']">
                                   <dc:language>
                                        <xsl:value-of select="."/>
                                   </dc:language>
                              </xsl:for-each>
                         </xsl:when>
                         <!--
                              <xsl:when test="@name='iso'">
                                   <dcterms:iso639-3><xsl:value-of select="doc:element/doc:field[@name='value']"/></dcterms:iso639-3>
                         </xsl:when>
                         -->
                    </xsl:choose>
               </xsl:for-each>
               <!-- 
               dc.relation
               -->
               <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element">
                    <xsl:choose>
                         <xsl:when test="@name='ispartof'">
                              <xsl:for-each select="doc:field[@name='value']">
                                   <dcterms:ispartof>
                                        <xsl:value-of select="."/>
                                   </dcterms:ispartof>
                              </xsl:for-each>
                         </xsl:when>
                         <xsl:when test="@name='ispartofseries'">
                              <xsl:for-each select="doc:field[@name='value']">
                                   <dcterms:ispartofseries>
                                        <xsl:value-of select="."/>
                                   </dcterms:ispartofseries>
                              </xsl:for-each>
                         </xsl:when>
                         <xsl:when test="@name='isreferencedby'">
                              <xsl:for-each select="doc:field[@name='value']">
                                   <dcterms:isreferencedby>
                                        <xsl:value-of select="."/>
                                   </dcterms:isreferencedby>
                              </xsl:for-each>
                         </xsl:when>
                    </xsl:choose>
               </xsl:for-each>
               <!-- 
               dc.rights
               -->
               <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='rights']">
                    <xsl:for-each select="doc:element">
                         <xsl:choose>
                              <xsl:when test="@name='none'">
                                   <xsl:for-each select="doc:field[@name='value']">
                                        <dc:rights>
                                             <xsl:value-of select="."/>
                                        </dc:rights>
                                   </xsl:for-each>
                              </xsl:when>
                              <xsl:when test="@name='license'">
                                   <dcterms:license>
                                        <xsl:value-of select="doc:element[@name='none']/doc:field[@name='value']"/>
                                   </dcterms:license>
                              </xsl:when>
                              <xsl:when test="@name='uri'">
                                   <!--
                                   <xsl:element name="dc:rights">
                                        <xsl:attribute name="xsi:type">
                                             <xsl:text>http://purl.org/dc/terms/uri</xsl:text>
                                        </xsl:attribute>
                                        <xsl:value-of select="doc:element/doc:field[@name='value']"/>
                                   </xsl:element> 
                                   -->
                                   <dcterms:license>
                                        <xsl:value-of select="doc:element/doc:field[@name='value']"/>
                                   </dcterms:license>
                              </xsl:when>
                         </xsl:choose>
                    </xsl:for-each>
               </xsl:for-each>
               <!-- 
               dc.coverge
               -->
               <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='coverage']">
                    <xsl:choose>
                         <xsl:when test="doc:element[@name='none']">
                              <dc:coverage>
                                   <xsl:value-of select="doc:element[@name='none']/doc:field[@name='value']"/>
                              </dc:coverage>
                         </xsl:when>
                         <xsl:when test="doc:element[@name='spatial']">
                              <dcterms:spatial>
                                   <xsl:value-of select="doc:element[@name='spatial']/doc:element[@name='none']/doc:field[@name='value']"/>
                              </dcterms:spatial>
                         </xsl:when>
                         <xsl:when test="doc:element[@name='temporal']">
                              <dcterms:temporal>
                                   <xsl:value-of select="doc:element[@name='temporal']/doc:element[@name='none']/doc:field[@name='value']"/>
                              </dcterms:temporal>
                         </xsl:when>
                    </xsl:choose>
               </xsl:for-each>
               <!-- 
               dc.format
               -->
               <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='format']/doc:element">
                    <xsl:choose>
                         <xsl:when test="@name='none'">
                              <dc:format>
                                   <xsl:value-of select="doc:field[@name='value']"/>
                              </dc:format>
                         </xsl:when>
                         <xsl:when test="@name='extent'">
                              <dcterms:extent>
                                   <xsl:value-of select="doc:element/doc:field[@name='value']"/>
                              </dcterms:extent>
                         </xsl:when>
                         <xsl:when test="doc:element[@name='medium']">
                              <dcterms:medium>
                                   <xsl:value-of select="doc:element/doc:field[@name='value']"/>
                              </dcterms:medium>
                         </xsl:when>
                    </xsl:choose>
               </xsl:for-each>
               <xsl:for-each select="doc:metadata/doc:element[@name='bundles']/doc:element[@name='bundle'][doc:field[text()='ORIGINAL']]/doc:element/doc:element[1]/doc:field[@name='format']">
                    <dc:format>
                         <xsl:value-of select="."/>
                    </dc:format>
               </xsl:for-each>
               <!-- 
               dc.source - placeholder for filename
               -->
               <dc:source>
                    <xsl:value-of select="doc:metadata/doc:element[@name='bundles']/doc:element[@name='bundle'][doc:field[text()='ORIGINAL']]/doc:element/doc:element/doc:field[@name='name']" />
               </dc:source>
               <!--
               dc.publisher
               -->
               <xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='publisher']/doc:element/doc:field[@name='value']">
                    <dc:publisher>
                         <xsl:value-of select="."/>
                    </dc:publisher>
               </xsl:for-each>
          </qdc:qualifieddc>
     </xsl:template>
</xsl:stylesheet>
