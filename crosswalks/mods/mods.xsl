<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:doc="http://www.lyncode.com/xoai" version="1.0"
	xmlns="http://www.loc.gov/mods/v3" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="doc" 
	xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-7.xsd">
	<xsl:variable name="tgnLookup" select="document('tgnSubjects.xml')"/>
	<xsl:output omit-xml-declaration="yes" method="xml" indent="yes"/>
	<xsl:strip-space elements="*"/>
	<xsl:template match="/">
		<mods>
			<!-- 
				titleInfo
			-->
			<xsl:apply-templates select="doc:metadata/doc:element[@name='dc']/doc:element[@name='title']">
				<xsl:with-param name="paraNonSort">
					<xsl:value-of select="doc:metadata/doc:element[@name='mods']/doc:element[@name='title']/doc:element[@name='nonsort']/doc:element/doc:field[@name='value']"/>
				</xsl:with-param>
			</xsl:apply-templates>
			<!-- 
				name
			-->
			<xsl:apply-templates select="doc:metadata/doc:element[@name='mods']/doc:element[@name='name']/doc:element[@name='artist']"/>
			<xsl:apply-templates select="doc:metadata/doc:element[@name='mods']/doc:element[@name='name']/doc:element[@name='collector']"/>
			<xsl:apply-templates select="doc:metadata/doc:element[@name='mods']/doc:element[@name='name']/doc:element[@name='donor']"/>
			<xsl:apply-templates select="doc:metadata/doc:element[@name='mods']/doc:element[@name='name']/doc:element[@name='lithographer']"/>
			<xsl:apply-templates select="doc:metadata/doc:element[@name='mods']/doc:element[@name='name']/doc:element[@name='photo']"/>
			<xsl:apply-templates select="doc:metadata/doc:element[@name='mods']/doc:element[@name='name']/doc:element[@name='sponsor']"/>
			<xsl:apply-templates select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']"/>	
			
			<!-- 
				typeOfResource
			-->
				<xsl:apply-templates select="doc:metadata/doc:element[@name='dc']/doc:element[@name='type']"/>
			<!-- 
				genre
			-->
			<xsl:apply-templates select="doc:metadata/doc:element[@name='mods']/doc:element[@name='genre']"/>
			<!-- 
				originInfo TO DO
			-->
			<xsl:call-template name="createOrigin"/>
			<!--
				language
			-->
			<xsl:apply-templates select="doc:metadata/doc:element[@name='mods']/doc:element[@name='language']"/>
			<!-- 
				physicalDescription
			-->
			<xsl:call-template name="physicalDescription"/>
			<!-- 
				abstract
			-->
			<xsl:apply-templates select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element[@name='abstract']"/>
			<!-- 
				tableOfContents - not currently used
			-->
			<!-- 
				targetAudience - not currently used
			-->
			<!-- 
				mod:note
			-->
			<xsl:apply-templates select="doc:metadata/doc:element[@name='mods']/doc:element[@name='note']"/>
			<!-- 
				subject
			-->
			<xsl:apply-templates select="doc:metadata/doc:element[@name='dc']/doc:element[@name='subject']"/>
			<!-- 
				geographic  
			-->
			<xsl:apply-templates select="doc:metadata/doc:element[@name='mods']/doc:element[@name='subject']/doc:element[@name='geographic']"/>
			<!-- 
				hierarchicalGeographic
			-->
			<xsl:apply-templates select="doc:metadata/doc:element[@name='dc']/doc:element[@name='coverage']"/>
			<!-- 
				geographic  
			-->
			<xsl:apply-templates select="doc:metadata/doc:element[@name='mods']/doc:element[@name='subject']/doc:element[@name='geographic']"/>
			<!-- 
				classification - not currently used
			-->
			<!-- 
				relatedItem
			-->
			<xsl:apply-templates select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='ispartofseries']"/>
			<xsl:apply-templates select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element[@name='isreferencedby']"/>
			<!-- 
				identifier
			-->
			<xsl:apply-templates select="doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']"/>
			<!--
				location 
			-->
			<xsl:call-template name="createLocation"/>
			<!-- 
				accessCondition
			-->
			<xsl:apply-templates select="doc:metadata/doc:element[@name='dc']/doc:element[@name='rights']"/>
			<xsl:apply-templates select="doc:metadata/doc:element[@name='dc']/doc:element/doc:element[@name='license']"/>
			<!-- 
				part - not currently used
			-->
			<!-- 
				extension
			-->
			<xsl:call-template name="createExtension"/>
			<!-- 
				recordInfo
			-->	   
			<xsl:element name="recordInfo">
				<xsl:element name="recordContentSource">
					<xsl:text>Brandeis University Library</xsl:text>
				</xsl:element>
			</xsl:element>
		</mods>
	</xsl:template>
	<!-- 
	titleInfo
	-->
	<xsl:template match="doc:element[@name='title']">
		<xsl:param name="paraNonSort"/>
		<xsl:element name="titleInfo">
			<xsl:attribute name="usage">primary</xsl:attribute>
			<xsl:choose>
				<xsl:when test="$paraNonSort !=''">
					<xsl:element name="nonSort">
						<xsl:value-of select="$paraNonSort"/>
					</xsl:element>
					<xsl:element name="title">
						<xsl:value-of select="normalize-space(substring(doc:element/doc:field,string-length($paraNonSort)+2))"/>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					<xsl:element name="title">
						<xsl:value-of select="normalize-space(doc:element/doc:field)"/>
					</xsl:element>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<!-- 
		name
	-->
	<xsl:template match="doc:element[@name='artist']">
		<xsl:element name="name">
			<xsl:attribute name="type">personal</xsl:attribute>
			<xsl:for-each select="doc:element/doc:field">
				<xsl:element name="namePart">
					<xsl:value-of select="."/>
				</xsl:element>
			</xsl:for-each>
			<xsl:element name="role">
				<xsl:element name="roleTerm">
					<xsl:attribute name="authority">marcrelator</xsl:attribute>
					<xsl:attribute name="authorityURI">http://id.loc.gov/vocabulary/relators</xsl:attribute>
					<xsl:attribute name="type">text</xsl:attribute>
					<xsl:attribute name="valueURI">http://id.loc.gov/vocabulary/relators/art</xsl:attribute>
					<xsl:text>Artist</xsl:text>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="doc:element[@name='collector']">
		<xsl:element name="name">
			<xsl:attribute name="type">personal</xsl:attribute>
			<xsl:for-each select="doc:element/doc:field">
				<xsl:element name="namePart">
					<xsl:value-of select="."/>
				</xsl:element>
			</xsl:for-each>
			<xsl:element name="role">
				<xsl:element name="roleTerm">
					<xsl:attribute name="authority">marcrelator</xsl:attribute>
					<xsl:attribute name="authorityURI">http://id.loc.gov/vocabulary/relators</xsl:attribute>
					<xsl:attribute name="type">text</xsl:attribute>
					<xsl:attribute name="valueURI">http://id.loc.gov/vocabulary/relators/col</xsl:attribute>
					<xsl:text>Collector</xsl:text>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="doc:element[@name='donor']">
		<xsl:element name="name">
			<xsl:attribute name="type">personal</xsl:attribute>
			<xsl:for-each select="doc:element/doc:field">
				<xsl:element name="namePart">
					<xsl:value-of select="."/>
				</xsl:element>
			</xsl:for-each>
			<xsl:element name="role">
				<xsl:element name="roleTerm">
					<xsl:attribute name="authority">marcrelator</xsl:attribute>
					<xsl:attribute name="authorityURI">http://id.loc.gov/vocabulary/relators</xsl:attribute>
					<xsl:attribute name="type">text</xsl:attribute>
					<xsl:attribute name="valueURI">http://id.loc.gov/vocabulary/relators/dnr</xsl:attribute>
					<xsl:text>Donor</xsl:text>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="doc:element[@name='lithographer']">
		<xsl:element name="name">
			<xsl:attribute name="type">personal</xsl:attribute>
			<xsl:element name="namePart">
				<xsl:value-of select="doc:element/doc:field"/>
			</xsl:element>
			<xsl:if test="../doc:element[@name='datepart']">
				<xsl:element name="namePart">
					<xsl:attribute name="type">date</xsl:attribute>
					<xsl:value-of select="../doc:element[@name='datepart']"/>
				</xsl:element>
			</xsl:if>
			<xsl:element name="role">
				<xsl:element name="roleTerm">
					<xsl:attribute name="authority">marcrelator</xsl:attribute>
						<xsl:attribute name="authorityURI">http://id.loc.gov/vocabulary/relators</xsl:attribute>
					<xsl:attribute name="type">text</xsl:attribute>
					<xsl:attribute name="valueURI">http://id.loc.gov/vocabulary/relators/ltg</xsl:attribute>
					<xsl:text>Lithographer</xsl:text>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="doc:element[@name='photo']">
		<xsl:element name="name">
			<xsl:attribute name="type">personal</xsl:attribute>
			<xsl:element name="namePart">
				<xsl:value-of select="doc:element/doc:field"/>
			</xsl:element>
			<xsl:if test="../doc:element[@name='datepart']">
				<xsl:element name="namePart">
					<xsl:attribute name="type">date</xsl:attribute>
					<xsl:value-of select="../doc:element[@name='datepart']"/>
				</xsl:element>
			</xsl:if>
			<xsl:element name="role">
				<xsl:element name="roleTerm">
					<xsl:attribute name="authority">marcrelator</xsl:attribute>
					<xsl:attribute name="authorityURI">http://id.loc.gov/vocabulary/relators</xsl:attribute>
					<xsl:attribute name="type">text</xsl:attribute>
					<xsl:attribute name="valueURI">http://id.loc.gov/vocabulary/relators/pht</xsl:attribute>
					<xsl:text>Photographer</xsl:text>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="doc:element[@name='sponsor']">
		<xsl:element name="name">
			<xsl:attribute name="type">corporate</xsl:attribute>
			<xsl:element name="namePart">
				<xsl:value-of select="doc:element/doc:field"/>
			</xsl:element>
			<xsl:if test="../doc:element[@name='datepart']">
				<xsl:element name="namePart">
					<xsl:attribute name="type">date</xsl:attribute>
					<xsl:value-of select="../doc:element[@name='datepart']"/>
				</xsl:element>
			</xsl:if>
			<xsl:element name="role">
				<xsl:element name="roleTerm">
					<xsl:attribute name="authority">marcrelator</xsl:attribute>
					<xsl:attribute name="authorityURI">http://id.loc.gov/vocabulary/relators</xsl:attribute>
					<xsl:attribute name="type">text</xsl:attribute>
					<xsl:attribute name="valueURI">http://id.loc.gov/vocabulary/relators/spn</xsl:attribute>
					<xsl:text>Sponsor</xsl:text>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="doc:element[@name='contributor']">
		<xsl:for-each select="doc:element">
			<xsl:choose>
				<xsl:when test="@name='interviewee'">
					<xsl:element name="name">
						<xsl:attribute name="type">personal</xsl:attribute>
						<xsl:element name="role">
							<xsl:element name="roleTerm">
								<xsl:attribute name="authority">marcrelator</xsl:attribute>
								<xsl:attribute name="authorityURI">http://id.loc.gov/vocabulary/relators</xsl:attribute>
								<xsl:attribute name="type">text</xsl:attribute>
								<xsl:attribute name="valueURI">http://id.loc.gov/vocabulary/relators/ive</xsl:attribute>
								<xsl:text>Interviewee</xsl:text>
							</xsl:element>
						</xsl:element>
						<xsl:for-each select="doc:element/doc:field">
							<xsl:element name="namePart">
								<xsl:value-of select="."/>
							</xsl:element>
						</xsl:for-each>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@name='interviewer'">
					<xsl:element name="name">
						<xsl:attribute name="type">personal</xsl:attribute>
						<xsl:element name="role">
							<xsl:element name="roleTerm">
								<xsl:attribute name="authority">marcrelator</xsl:attribute>
								<xsl:attribute name="authorityURI">http://id.loc.gov/vocabulary/relators</xsl:attribute>
								<xsl:attribute name="type">text</xsl:attribute>
								<xsl:attribute name="valueURI">http://id.loc.gov/vocabulary/relators/ivr</xsl:attribute>
								<xsl:text>Interviewer</xsl:text>
							</xsl:element>
						</xsl:element>
						<xsl:for-each select="doc:element/doc:field">
							<xsl:element name="namePart">
								<xsl:value-of select="."/>
							</xsl:element>
						</xsl:for-each>						
					</xsl:element>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<!-- 
		typeOfResource
	-->
	<xsl:template match="doc:element[@name='type']">
		<xsl:element name="typeOfResource">
			<xsl:value-of select="doc:element/doc:field"/>
		</xsl:element>
	</xsl:template>
	<!-- 
		genre
	-->
	<xsl:template match="doc:element[@name='genre']">
		<xsl:element name="genre">
			<xsl:variable name="varAuth"/>
			<xsl:variable name="varURI"/>
			<xsl:choose>
				<!--xsl:when test="doc:element/doc:field[@name='value'] = 'Advertising cards'">
					<xsl:attribute name="authority">gmgpc</xsl:attribute>
					<xsl:attribute name="authorityURI">http://id.loc.gov/vocabulary/graphicMaterials</xsl:attribute>
					<xsl:attribute name="valueURI">http://id.loc.gov/vocabulary/graphicMaterials/tgm000101</xsl:attribute>
					<xsl:attribute name="displayLabel">general</xsl:attribute>
					<xsl:value-of select="doc:element/doc:field[@name='value']"/>
				</xsl:when>
				<xsl:when test="doc:element/doc:field[@name='value'] = 'Correspondence'">
					<xsl:attribute name="authority">lctgm</xsl:attribute>
					<xsl:attribute name="authorityURI">http://id.loc.gov/vocabulary/graphicMaterials</xsl:attribute>
					<xsl:attribute name="valueURI">http://id.loc.gov/vocabulary/graphicMaterials/tgm002590</xsl:attribute>
					<xsl:attribute name="displayLabel">general</xsl:attribute>
					<xsl:value-of select="doc:element/doc:field[@name='value']"/>	
				</xsl:when>
				<xsl:when test="doc:element/doc:field[@name='value'] = 'Manuscripts'">
					<xsl:attribute name="authority">gmgpc</xsl:attribute>
					<xsl:attribute name="authorityURI">http://id.loc.gov/vocabulary/graphicMaterials</xsl:attribute>
					<xsl:attribute name="valueURI">http://id.loc.gov/vocabulary/graphicMaterials/tgm012286</xsl:attribute>
					<xsl:attribute name="displayLabel">general</xsl:attribute>
					<xsl:value-of select="doc:element/doc:field[@name='value']"/>
				</xsl:when>
				<xsl:when test="doc:element/doc:field[@name='value'] = 'Pamphlets'">
					<xsl:attribute name="authority">gmgpc</xsl:attribute>
					<xsl:attribute name="authorityURI">http://id.loc.gov/vocabulary/graphicMaterials</xsl:attribute>
					<xsl:attribute name="valueURI">http://id.loc.gov/vocabulary/graphicMaterials/tgm007415</xsl:attribute>
					<xsl:attribute name="displayLabel">general</xsl:attribute>
					<xsl:value-of select="doc:element/doc:field[@name='value']"/>
				</xsl:when>
				<xsl:when test="doc:element/doc:field[@name='value'] = 'Photographs'">
					<xsl:attribute name="authority">gmgpc</xsl:attribute>
					<xsl:attribute name="authorityURI">http://id.loc.gov/vocabulary/graphicMaterials</xsl:attribute>
					<xsl:attribute name="valueURI">http://id.loc.gov/vocabulary/graphicMaterials/tgm007721</xsl:attribute>
					<xsl:attribute name="displayLabel">general</xsl:attribute>
					<xsl:value-of select="doc:element/doc:field[@name='value']"/>
				</xsl:when>
				<xsl:when test="doc:element/doc:field[@name='value'] = 'Political posters'">
					<xsl:attribute name="authority">gmgpc</xsl:attribute>
					<xsl:attribute name="authorityURI">http://id.loc.gov/vocabulary/graphicMaterials</xsl:attribute>
					<xsl:attribute name="valueURI">http://id.loc.gov/vocabulary/graphicMaterials/tgm008006</xsl:attribute>
					<xsl:attribute name="displayLabel">general</xsl:attribute>
					<xsl:value-of select="doc:element/doc:field[@name='value']"/>
				</xsl:when>
				<xsl:when test="doc:element/doc:field[@name='value'] = 'Prints'">
						<xsl:attribute name="authority">gmgpc</xsl:attribute>
						<xsl:attribute name="authorityURI">http://id.loc.gov/vocabulary/graphicMaterials</xsl:attribute>
						<xsl:attribute name="valueURI">http://id.loc.gov/vocabulary/graphicMaterials/tgm008237</xsl:attribute>
						<xsl:attribute name="displayLabel">general</xsl:attribute>
						<xsl:value-of select="doc:element/doc:field[@name='value']"/>					
				</xsl:when>
				<xsl:when test="doc:element/doc:field[@name='value'] = 'Sound recordings'">
					<xsl:attribute name="authority">lctgm</xsl:attribute>
					<xsl:attribute name="authorityURI">http://id.loc.gov/vocabulary/graphicMaterials</xsl:attribute>
					<xsl:attribute name="valueURI">http://id.loc.gov/vocabulary/graphicMaterials/tgm009874</xsl:attribute>
					<xsl:attribute name="displayLabel">general</xsl:attribute>
					<xsl:value-of select="doc:element/doc:field[@name='value']"/>	
				</xsl:when>
			</xsl:choose-->
				<xsl:when test="doc:element/doc:field[@name='value'] = 'Advertising cards'">
					<xsl:call-template name="createGenre">
						<xsl:with-param name="Authority">gmgpc</xsl:with-param>
						<xsl:with-param name="URI">tgm000101</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="doc:element/doc:field[@name='value'] = 'Correspondence'">
					<xsl:call-template name="createGenre">
						<xsl:with-param name="Authority">lctgm</xsl:with-param>
						<xsl:with-param name="URI">tgm002590</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="doc:element/doc:field[@name='value'] = 'Manuscripts'">
					<xsl:call-template name="createGenre">
						<xsl:with-param name="Authority">gmgpc</xsl:with-param>
						<xsl:with-param name="URI">tgm012286</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="doc:element/doc:field[@name='value'] = 'Pamphlets'">
					<xsl:call-template name="createGenre">
						<xsl:with-param name="Authority">gmgpc</xsl:with-param>
						<xsl:with-param name="URI">tgm007415</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="doc:element/doc:field[@name='value'] = 'Photographs'">
					<xsl:call-template name="createGenre">
						<xsl:with-param name="Authority">gmgpc</xsl:with-param>
						<xsl:with-param name="URI">tgm007721</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="doc:element/doc:field[@name='value'] = 'Political posters'">
					<xsl:call-template name="createGenre">
						<xsl:with-param name="Authority">gmgpc</xsl:with-param>
						<xsl:with-param name="URI">tgm008006</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="doc:element/doc:field[@name='value'] = 'Prints'">
					<xsl:call-template name="createGenre">
						<xsl:with-param name="Authority">gmgpc</xsl:with-param>
						<xsl:with-param name="URI">tgm008237</xsl:with-param>
					</xsl:call-template>					
				</xsl:when>
				<xsl:when test="doc:element/doc:field[@name='value'] = 'Sound recordings'">
					<xsl:call-template name="createGenre">
						<xsl:with-param name="Authority">lctgm</xsl:with-param>
						<xsl:with-param name="URI">tgm009874</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="createGenre">
		<xsl:param name="Authority"/>
		<xsl:param name="URI"/>
		<xsl:attribute name="authority"><xsl:value-of select="$Authority"/></xsl:attribute>
		<xsl:attribute name="authorityURI">http://id.loc.gov/vocabulary/graphicMaterials</xsl:attribute>
		<xsl:attribute name="valueURI"><xsl:value-of select="concat('http://id.loc.gov/vocabulary/graphicMaterials/',$URI)"/></xsl:attribute>
		<xsl:attribute name="displayLabel">general</xsl:attribute>
		<xsl:value-of select="doc:element/doc:field[@name='value']"/>
	</xsl:template>
	<!-- 
		originInfo 
	-->
	<xsl:template name="createOrigin">
		<xsl:element name="originInfo">
			<xsl:apply-templates select="/doc:metadata/doc:element[@name='mods']/doc:element[@name='publisher']"/>
	                <xsl:apply-templates select="/doc:metadata/doc:element[@name='mods']/doc:element[@name='date']/doc:element[@name='keydate']"/>
	                <xsl:apply-templates select="/doc:metadata/doc:element[@name='mods']/doc:element[@name='date']/doc:element[@name='nonkey']"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="doc:element[@name='publisher']">
		<xsl:if test="doc:element[@name='place']">
			<xsl:element name="place">
				<xsl:element name="placeTerm">
					<xsl:attribute name="type">
						<xsl:text>text</xsl:text>
					</xsl:attribute>
					<xsl:value-of select="doc:element[@name='place']/doc:element/doc:field"/>
				</xsl:element>
			</xsl:element>
		</xsl:if>
		<xsl:if test="doc:element[@name='name']">
			<xsl:element name="publisher">
				<xsl:value-of select="doc:element[@name='name']/doc:element/doc:field"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="doc:element[@name = 'keydate']">
		<xsl:variable name="varRaw" select="."/>
		<xsl:variable name="varTest" select="translate($varRaw, '0123456789', '##########')"/>
		<xsl:choose>
			<xsl:when test="($varTest = '####-##-##' or $varTest = '####-##' or $varTest = '####')">
				<xsl:element name="dateIssued">
					<xsl:attribute name="encoding">w3cdtf</xsl:attribute>
					<xsl:attribute name="keyDate">yes</xsl:attribute>
					<xsl:value-of select="$varRaw"/>
				</xsl:element>
			</xsl:when>
			<xsl:when test="$varTest = '####-####'">
				<xsl:element name="dateIssued">
					<xsl:attribute name="encoding">w3cdtf</xsl:attribute>
					<xsl:attribute name="keyDate">yes</xsl:attribute>
					<xsl:attribute name="point">start</xsl:attribute>
					<xsl:value-of select="substring-before($varRaw, '-')"/>
				</xsl:element>
				<xsl:element name="dateIssued">
					<xsl:attribute name="encoding">w3cdtf</xsl:attribute>
					<xsl:attribute name="point">end</xsl:attribute>
					<xsl:value-of select="substring-after($varRaw, '-')"/>
				</xsl:element>
			</xsl:when>
			<xsl:when test="$varTest = '####-####?'">
				<xsl:element name="dateIssued">
					<xsl:attribute name="encoding">w3cdtf</xsl:attribute>
					<xsl:attribute name="keyDate">yes</xsl:attribute>
					<xsl:attribute name="point">start</xsl:attribute>
					<xsl:value-of select="substring-before($varRaw, '-')"/>
				</xsl:element>
				<xsl:element name="dateIssued">
					<xsl:attribute name="encoding">w3cdtf</xsl:attribute>
					<xsl:attribute name="point">end</xsl:attribute>
					<xsl:attribute name="qualifier">questionable</xsl:attribute>
					<xsl:value-of select="translate(substring-after($varRaw, '-'), '?', '')"/>
				</xsl:element>
			</xsl:when>
			<xsl:when
				test="($varTest = '####-##-##?' or $varTest = '####-##?' or $varTest = '####?')">
				<xsl:element name="dateIssued">
					<xsl:attribute name="encoding">w3cdtf</xsl:attribute>
					<xsl:attribute name="keyDate">yes</xsl:attribute>
					<xsl:attribute name="qualifier">questionable</xsl:attribute>
					<xsl:value-of select="translate($varRaw, '?', '')"/>
				</xsl:element>
			</xsl:when>
			<xsl:when test="$varTest = '[####]'">
				<xsl:element name="dateIssued">
					<xsl:attribute name="encoding">w3cdtf</xsl:attribute>
					<xsl:attribute name="keyDate">yes</xsl:attribute>
					<xsl:attribute name="qualifier">inferred</xsl:attribute>
					<xsl:value-of select="translate($varRaw, '[]', '')"/>
				</xsl:element>
			</xsl:when>
			<xsl:when test="$varTest = '[####-####]'">
				<xsl:element name="dateIssued">
					<xsl:attribute name="encoding">w3cdtf</xsl:attribute>
					<xsl:attribute name="keyDate">yes</xsl:attribute>
					<xsl:attribute name="point">start</xsl:attribute>
					<xsl:attribute name="qualifier">inferred</xsl:attribute>
					<xsl:value-of select="translate(substring-before($varRaw, '-'), '[', '')"/>
				</xsl:element>
				<xsl:element name="dateIssued">
					<xsl:attribute name="encoding">w3cdtf</xsl:attribute>
					<xsl:attribute name="point">end</xsl:attribute>
					<xsl:attribute name="qualifier">inferred</xsl:attribute>
					<xsl:value-of select="translate(substring-after($varRaw, '-'), ']', '')"/>
				</xsl:element>
			</xsl:when>
			<xsl:when test="$varTest = 'circa ####'">
				<xsl:element name="dateIssued">
					<xsl:attribute name="encoding">w3cdtf</xsl:attribute>
					<xsl:attribute name="keyDate">yes</xsl:attribute>
					<xsl:attribute name="qualifier">approximate</xsl:attribute>
					<xsl:value-of select="translate($varRaw, 'circa ', '')"/>
				</xsl:element>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="doc:element[@name = 'nonkey']">
		<xsl:variable name="varRaw" select="."/>
		<xsl:variable name="varTest" select="translate($varRaw, '0123456789', '##########')"/>
		<xsl:choose>
			<xsl:when test="($varTest = '####-##-##' or $varTest = '####-##' or $varTest = '####')">
				<xsl:element name="dateIssued">
					<xsl:attribute name="encoding">w3cdtf</xsl:attribute>
					<xsl:value-of select="$varRaw"/>
				</xsl:element>
			</xsl:when>
			<xsl:when test="$varTest = '####-####'">
				<xsl:element name="dateIssued">
					<xsl:attribute name="encoding">w3cdtf</xsl:attribute>
					<xsl:attribute name="point">start</xsl:attribute>
					<xsl:value-of select="substring-before($varRaw, '-')"/>
				</xsl:element>
				<xsl:element name="dateIssued">
					<xsl:attribute name="encoding">w3cdtf</xsl:attribute>
					<xsl:attribute name="point">end</xsl:attribute>
					<xsl:value-of select="substring-after($varRaw, '-')"/>
				</xsl:element>
			</xsl:when>
			<xsl:when test="$varTest = '####-##-##?'">
				<xsl:element name="dateIssued">
					<xsl:attribute name="encoding">w3cdtf</xsl:attribute>
					<xsl:attribute name="qualifier">questionable</xsl:attribute>
					<xsl:value-of select="translate($varRaw, '?', '')"/>
				</xsl:element>
			</xsl:when>
		</xsl:choose>
	</xsl:template>	
	<!-- 
		language
	-->
	<xsl:template match="doc:element[@name='language']">
		<xsl:element name="language">
			<xsl:element name="languageTerm">
				<xsl:attribute name="authority">iso639-2b</xsl:attribute>
				<xsl:attribute name="authorityURI">http://id.loc.gov/vocabulary/iso639-2</xsl:attribute>
				<xsl:attribute name="type">text</xsl:attribute>
				<xsl:value-of select="normalize-space(substring-before(.,'|'))"/>
			</xsl:element>
			<xsl:element name="languageTerm">
				<xsl:attribute name="authority">iso639-2b</xsl:attribute>
				<xsl:attribute name="authorityURI">http://id.loc.gov/vocabulary/iso639-2</xsl:attribute>
				<xsl:attribute name="type">code</xsl:attribute>
				<xsl:value-of select="normalize-space(substring-after(.,'|'))"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!-- 
		physicalDescription
	-->
	<xsl:template name="physicalDescription">
		<xsl:element name="physicalDescription">
			<xsl:element name="digitalOrigin">reformatted digital</xsl:element>
			<xsl:element name="internetMediaType">
				<xsl:value-of select="doc:metadata/doc:element[@name='bundles']/doc:element[@name='bundle'][doc:field[text()='ORIGINAL']]/doc:element/doc:element[1]/doc:field[@name='format']"/>
			</xsl:element>
			<xsl:element name="extent">
				<xsl:value-of select="doc:metadata/doc:element[@name='mods']/doc:element[@name='extent']/doc:element/doc:field"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
	<!-- 
		abstract
	-->
	<xsl:template match="doc:element[@name='abstract']">
		<xsl:element name="abstract">
			<xsl:value-of select="doc:element/doc:field"/>
		</xsl:element>
	</xsl:template>
	<!-- 
		note
	-->
	<xsl:template match="doc:element[@name='note']">
		<xsl:for-each select="doc:element">
			<xsl:element name="note">
				<xsl:attribute name="type">
					<xsl:value-of select="@name"/>
				</xsl:attribute>
				<xsl:value-of select="doc:element/doc:field[@name='value']"/>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
	<!-- 
    	mods.subject.* 
    -->
	<xsl:template match="doc:element[@name='subject']">
		<xsl:for-each select="doc:element">
			<xsl:choose>
				<xsl:when test="@name='other'">
					<xsl:for-each select="doc:element/doc:field[@name='value']">
						<subject>
							<xsl:element name="topic">
								<xsl:value-of select="."/>
							</xsl:element>
						</subject>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="@name='none'">
					<xsl:for-each select="doc:field[@name='value']">
						<subject>
							<xsl:element name="topic">
								<xsl:value-of select="."/>
							</xsl:element>
						</subject>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="@name='lcsh'">
					<xsl:for-each select="doc:element/doc:field[@name='value']">
						<xsl:element name="subject">
							<xsl:attribute name="authority">lcsh</xsl:attribute>
							<xsl:attribute name="authorityURI">http://id.loc.gov/authorities/subjects</xsl:attribute>
							<xsl:element name="topic">
								<xsl:value-of select="."/>
							</xsl:element>
						</xsl:element>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="@name='lcnaf'">
					<xsl:for-each select="doc:element/doc:field[@name='value']">
						<xsl:element name="subject">
							<xsl:attribute name="authority">lcnaf</xsl:attribute>
							<xsl:attribute name="authorityURI">http://id.loc.gov/authorities/names</xsl:attribute>
							<xsl:element name="topic">
								<xsl:value-of select="."/>
							</xsl:element>
						</xsl:element>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="@name='aat'">
					<xsl:for-each select="doc:element/doc:field[@name='value']">
						<xsl:element name="subject">
							<xsl:attribute name="authority">aat</xsl:attribute>
							<xsl:attribute name="authorityURI">http://vocab.getty.edu/page/aat/300198841</xsl:attribute>
							<xsl:element name="topic">
								<xsl:value-of select="."/>
							</xsl:element>
						</xsl:element>
					</xsl:for-each>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<!-- 
		hierarchicalGeographic
	-->
	<xsl:template match="doc:element[@name='coverage']">
		<xsl:variable name="varId">
			<xsl:value-of select="doc:element/doc:field"/>
		</xsl:variable>
		<xsl:copy-of select="$tgnLookup/records/record[@Subject_ID=$varId]/subject"/>
	</xsl:template>
	<!-- 
		geographic
	-->
	<xsl:template match="doc:element[@name='geographic']">
		<xsl:element name="subject">
			<xsl:element name="geographic">
				<xsl:value-of select="doc:element/doc:field"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!-- 
		relatedItem[s]
	-->
	<xsl:template match="doc:element[@name='ispartof']">
		<xsl:element name="relatedItem">
			<xsl:attribute name="type">host</xsl:attribute>
			<xsl:element name="titleInfo">
				<xsl:element name="title">
					<xsl:value-of select="doc:element/doc:field"/>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="doc:element[@name='ispartofseries']">
		<xsl:element name="relatedItem">
			<xsl:attribute name="type">host</xsl:attribute>
			<xsl:element name="titleInfo">
				<xsl:element name="title">
					<xsl:value-of select="doc:element/doc:field"/>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="doc:element[@name='isreferencedby']">
		<xsl:element name="relatedItem">
			<xsl:attribute name="type">isReferencedBy</xsl:attribute>
			<xsl:element name="titleInfo">
				<xsl:element name="title">
					<xsl:value-of select="doc:element/doc:field"/>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!-- 
		identifier
	-->
	<xsl:template match="doc:element[@name='identifier']">
		<xsl:for-each select="doc:element">
			<xsl:choose>
				<xsl:when test="@name='other'">
					<xsl:element name="identifier">
						<xsl:attribute name="type">
							<xsl:text>other</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="doc:element/doc:field"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@name='uri'">
					<xsl:element name="identifier">
						<xsl:attribute name="type">
							<xsl:text>hdl</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="doc:element/doc:field"/>
					</xsl:element>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<!--
		location
	-->
	<xsl:template name="createLocation">
		<xsl:element name="location">
			<xsl:element name="physicalLocation">
				<xsl:text>Brandeis University Library</xsl:text>
			</xsl:element>
		</xsl:element>
		<xsl:element name="location">
			<xsl:element name="url">
				<xsl:attribute name="access">
					<xsl:text>object in context</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="usage">
					<xsl:text>primary</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="concat('https://hdl.handle.net/',/doc:metadata/doc:element[@name='others']/doc:field[@name='handle'])"/>
			</xsl:element>
		</xsl:element>
		<xsl:element name="location">
	        	<xsl:element name="url">
	       			<xsl:attribute name="displayLabel">
					<xsl:value-of select="/doc:metadata/doc:element[@name='dc']/doc:element[@name='title']/doc:element/doc:field"/>
	        		</xsl:attribute>
					<xsl:value-of select="/doc:metadata/doc:element[@name='bundles']/doc:element[@name='bundle'][doc:field[text()='ORIGINAL']]/doc:element/doc:element[1]/doc:field[@name='name']"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!-- 
		accessCondition
	-->
	<xsl:template match="doc:element[@name='rights']">
		<xsl:element name="accessCondition">
			<xsl:attribute name="displayLabel">rights</xsl:attribute>
			<xsl:attribute name="type">use and reproduction</xsl:attribute>
			<xsl:for-each select="doc:element/doc:field">
				<xsl:value-of select="."/>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	<xsl:template match="doc:element[@name='license']">
		<xsl:element name="accessCondition">
			<xsl:attribute name="displayLabel">license</xsl:attribute>
			<xsl:attribute name="type">use and reproduction</xsl:attribute>
			<xsl:value-of select="normalize-space(doc:element/doc:field)"/>
		</xsl:element>
	</xsl:template>
	<!-- 
		extension
	-->
	<xsl:template name="createExtension">
		<xsl:element name="extension">
			<metadata xmlns="http://www.lyncode.com/xoai">
				<xsl:element name="events">
					<xsl:for-each select="/doc:metadata/doc:element[@name='dc']/doc:element/doc:element[@name='provenance']/doc:element/doc:field">
						<xsl:element name="event">
							<xsl:value-of select="."/>
						</xsl:element>
					</xsl:for-each>
				</xsl:element>
				<xsl:element name="bundles">
					<xsl:for-each select="/doc:metadata/doc:element[@name='bundles']/doc:element[@name='bundle']">
						<xsl:choose>
							<xsl:when test="doc:field[text()='ORIGINAL']">
								<xsl:copy-of select="."/>
							</xsl:when>
							<xsl:when test="doc:field[text()='PRESERVATION']">
								<xsl:copy-of select="."/>
							</xsl:when>
							<xsl:otherwise/>
						</xsl:choose>
					</xsl:for-each>
				</xsl:element>
			</metadata>
		</xsl:element>
	</xsl:template>
	<!-- 
		recordInfo - static
	-->
	<xsl:template match="text()"/>
</xsl:stylesheet>
