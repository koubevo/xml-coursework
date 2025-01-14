<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:r="urn:x-koubevo:schemas:restaurace"
    exclude-result-prefixes="xs r"
    version="3.0">
    
    <xsl:output method="xml"/>
    
    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="a4" page-height="297mm" page-width="210mm" margin="15mm" line-height="1.15" font-family="Verdana" color="#001427">
                    <fo:region-body margin-top="10mm" margin-bottom="10mm"/>
                    <fo:region-before extent="10mm"/>
                    <fo:region-after extent="10mm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <fo:page-sequence master-reference="a4">               
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block text-align="center">
                        kouv13
                    </fo:block>
                </fo:static-content>
                
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block text-align="center" font-size="10pt">
                        Str. <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="26pt" font-weight="bold" text-align="center" space-after="20mm" space-before="50mm">
                        Recenze restaurací
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <fo:page-sequence master-reference="a4" font-family="Verdana" color="#001427">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block space-before="10mm" font-size="16pt" font-weight="bold">
                        Seznam restaurací
                    </fo:block>
                    <!-- MENU ABY FUNGOVALY PROKLIKY -->
                    <xsl:for-each select="/r:recenze/r:restaurace">
                        <fo:block font-size="14pt" space-before="10pt">
                            <xsl:value-of select="r:nazev"/>
                        </fo:block>
                    </xsl:for-each>
                </fo:flow>
            </fo:page-sequence>
            
            <fo:page-sequence master-reference="a4" font-family="Verdana" color="#001427" font-size="11pt">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block>
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    
    <xsl:template match="r:recenze">
        <xsl:for-each select="r:restaurace">
            <fo:block break-before="page"/>
            <fo:block>
                <xsl:call-template name="nazev"/>
                <xsl:call-template name="obrazek"></xsl:call-template>
                <xsl:call-template name="lokalita"/>
                <xsl:call-template name="tagy"/>
                <xsl:call-template name="popis"/>
                <xsl:call-template name="hodnoceni"/>
                <xsl:call-template name="nejlepsi_jidlo"/>
                <xsl:call-template name="oteviraci_doba"/>
                <xsl:call-template name="dalsi_informace"/>
            </fo:block>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="r:id"/>
    
    <xsl:template name="nazev">
        <fo:block font-size="20pt" color="#FFC914" font-weight="bold" space-after="4mm"><xsl:apply-templates select="r:nazev"/></fo:block>
    </xsl:template>
    
    <xsl:template name="obrazek">
        <fo:block space-after="2mm">
            <fo:external-graphic src="imgs/{r:top_jidlo/r:foto}" content-width="60mm"/>
        </fo:block>
    </xsl:template>
    
    <xsl:template name="lokalita">
        <fo:block space-after="2mm">
            <xsl:value-of select="r:mesto"/> | <xsl:value-of select="r:stat"/>
        </fo:block>
    </xsl:template>
        
    <xsl:template name="tagy">
        <fo:block space-after="2mm">
            <xsl:for-each select="r:kategorie">
                <fo:inline padding="2pt" space-end="1mm" background-color="#FFC914" font-weight="bold" font-size="80%">
                    <xsl:value-of select="."/>
                </fo:inline>
            </xsl:for-each>
        </fo:block>
    </xsl:template>
    
    <xsl:template name="popis">
        <fo:block font-weight="200" font-size="60%" color="#001427" space-after="2mm">
            <xsl:if test="string-length(normalize-space(r:majitel)) > 0">
                Majitel: <xsl:apply-templates select="r:majitel"/>
            </xsl:if>
        </fo:block>
        <fo:block space-after="2mm"><xsl:apply-templates select="r:popis"/></fo:block>
        <fo:block space-after="4mm">Menu si můžete prohlédnout: <fo:basic-link external-destination="{r:menu}" color="#FFC914" font-weight="bold">zde</fo:basic-link>.
        </fo:block>
    </xsl:template>
    
    <xsl:template name="hodnoceni">        
        <!-- HVEZDICKY!! -->
        <fo:block font-size="16pt" font-weight="bold" space-after="2mm">Naše hodnocení</fo:block>
        <fo:block space-after="1mm">
            <xsl:value-of select="r:hodnoceni/r:slovni"/>
        </fo:block>
        <fo:block>
            Místo: <xsl:value-of select="r:hodnoceni/r:hvezdicky/r:misto"/> ★
        </fo:block>
        <fo:block>
            Obsluha: <xsl:value-of select="r:hodnoceni/r:hvezdicky/r:obsluha"/> ★
        </fo:block>
        <fo:block>
            Jídlo: <xsl:value-of select="r:hodnoceni/r:hvezdicky/r:jidlo"/> ★
        </fo:block>
        <fo:block space-after="2mm">
            Finální hodnocení: <xsl:value-of select="r:hodnoceni/r:hvezdicky/r:finalni"/> ★
        </fo:block>
    </xsl:template>
    
    <xsl:template name="nejlepsi_jidlo">
        <fo:block font-size="12pt" font-weight="bold" space-after="1mm">Nejlepší jídlo</fo:block>
        <fo:block space-after="3mm">
            <xsl:value-of select="r:top_jidlo/r:nazev"/><xsl:text> </xsl:text><xsl:value-of select="r:top_jidlo/r:cena"/><xsl:text> </xsl:text><xsl:value-of select="r:top_jidlo/r:cena/@mena"/>
        </fo:block>
    </xsl:template>
    
    <xsl:template name="oteviraci_doba">
        <fo:block font-size="16pt" font-weight="bold" space-after="2mm">Otevírací doba</fo:block>
        <fo:block space-after="2mm">
            <xsl:for-each select="r:oteviraci_doba/*">
                <fo:block>
                    <xsl:choose>
                        <xsl:when test="local-name() = 'pondeli'">Pondělí</xsl:when>
                        <xsl:when test="local-name() = 'utery'">Úterý</xsl:when>
                        <xsl:when test="local-name() = 'streda'">Středa</xsl:when>
                        <xsl:when test="local-name() = 'ctvrtek'">Čtvrtek</xsl:when>
                        <xsl:when test="local-name() = 'patek'">Pátek</xsl:when>
                        <xsl:when test="local-name() = 'sobota'">Sobota</xsl:when>
                        <xsl:when test="local-name() = 'nedele'">Neděle</xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="local-name()"/>
                        </xsl:otherwise>
                    </xsl:choose>:  
                    <xsl:choose>
                        <xsl:when test="@zavreno='true'">Zavřeno</xsl:when>
                        <xsl:otherwise>
                            <!-- aby se to neoddelilo od sebe ty sekce -->
                            <xsl:value-of select="format-time(xs:time(r:od), '[H01]:[m01]')"/> - <xsl:value-of select="format-time(xs:time(r:do), '[H01]:[m01]')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:block>
            </xsl:for-each>
        </fo:block>
    </xsl:template>
    
    <xsl:template name="dalsi_informace">
        <fo:block font-size="16pt" font-weight="bold" space-after="2mm">Další informace</fo:block>
        <fo:block>~ Cena/osoba: <xsl:value-of select="r:cena_osoba"/><xsl:text> </xsl:text><xsl:value-of select="r:cena_osoba/@mena"/></fo:block>
        <fo:block>Platba kartou: <xsl:value-of select="r:platba_kartou"/></fo:block>
        <fo:block>Qerko: <xsl:value-of select="r:qerko"/></fo:block>
        <fo:block>Polední menu: <xsl:value-of select="r:poledni_menu"/></fo:block>
        <fo:block>Datum návštěvy: <xsl:value-of select="format-date(xs:date(r:datum_navstevy), '[D01].[M01].[Y2]')"/></fo:block>
    </xsl:template>
    
    
    
</xsl:stylesheet>
