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
                <fo:simple-page-master master-name="a4" page-height="297mm" page-width="210mm" margin="15mm">
                    <fo:region-body margin-top="20mm" margin-bottom="20mm"/>
                    <fo:region-before extent="15mm"/>
                    <fo:region-after extent="15mm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <fo:page-sequence master-reference="a4" font-size="12pt" line-height="1.15">               
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block text-align="center" font-weight="bold">
                        kouv13
                    </fo:block>
                </fo:static-content>
                
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block text-align="center" font-size="10pt">
                        Str. <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="26pt" font-weight="bold" text-align="center" space-after="20mm">
                        Recenze restaurací
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <fo:page-sequence master-reference="a4">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block space-before="10mm" font-size="18pt" font-weight="bold">
                        Seznam restaurací
                    </fo:block>
                    
                    <xsl:for-each select="/r:recenze/r:restaurace">
                        <fo:block font-size="16pt" space-before="10pt">
                            Název: <xsl:value-of select="r:nazev"/>
                        </fo:block>
                    </xsl:for-each>
                </fo:flow>
            </fo:page-sequence>
            
            <fo:page-sequence master-reference="a4">
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
            <fo:block>
                <xsl:call-template name="nazev"/>
                <!-- obrazek -->
                <xsl:call-template name="lokalita"/>
                <xsl:call-template name="kategorie"/>
                <xsl:call-template name="popis"/>
                <xsl:call-template name="hodnoceni"/>
                <xsl:call-template name="nejlepsi_jidlo"/>
                <xsl:call-template name="oteviraci_doba"/>
                <xsl:call-template name="dalsi_informace"/>
            </fo:block>
        </xsl:for-each>
    </xsl:template>
    
    <!-- zatim prazdny, dava smysl vypisovat? -->
    <xsl:template match="r:id"/>
    
    <xsl:template match="r:nazev">
        <fo:block><xsl:apply-templates/></fo:block>
    </xsl:template>
    
    <xsl:template match="r:popis">
        <fo:block>Majitel: <xsl:apply-templates/></fo:block>
    </xsl:template>
    
    <xsl:template match="r:majitel">
        <fo:block>Majitel: <xsl:apply-templates/></fo:block>
    </xsl:template>
    
    <xsl:template name="lokalita">
        <fo:block>
            <xsl:value-of select="r:mesto"/> | <xsl:value-of select="r:stat"/>
        </fo:block>
    </xsl:template>
    
    <xsl:template name="oteviraci_doba">
        <fo:block>Otevírací doba</fo:block>
        <xsl:for-each select="r:oteviraci_doba/*">
            <fo:block>
                <xsl:value-of select="local-name()"/>: 
                <xsl:choose>
                    <xsl:when test="@zavreno='true'">Zavřeno</xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="r:od"/> - <xsl:value-of select="r:do"/>
                    </xsl:otherwise>
                </xsl:choose>
            </fo:block>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="r:menu">
        <fo:block>Menu si můžete prohlédnout : 
            <fo:basic-link external-destination="{text()}">
                zde
            </fo:basic-link>.
        </fo:block>
    </xsl:template>
    
    <xsl:template name="tagy">
        <fo:block>
            <xsl:for-each select="r:kategorie">
                <fo:inline font-style="italic">
                    <xsl:value-of select="."/>
                </fo:inline>
                <fo:inline> | </fo:inline>
            </xsl:for-each>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="r:hodnoceni">
        <fo:block>Naše hodnocení</fo:block>
        <fo:block>
            <xsl:value-of select="rslovni"/>
        </fo:block>
        <fo:block>
            Místo: <xsl:value-of select="r:hvezdicky/misto"/> ★
        </fo:block>
        <fo:block>
            Obsluha: <xsl:value-of select="r:hvezdicky/obsluha"/> ★
        </fo:block>
        <fo:block>
            Jídlo: <xsl:value-of select="r:hvezdicky/jidlo"/> ★
        </fo:block>
        <fo:block>
            Finální hodnocení: <xsl:value-of select="r:hvezdicky/finalni"/> ★
        </fo:block>
    </xsl:template>
    
    <xsl:template match="r:top_jidlo">
        <fo:block>Nejlepší jídlo</fo:block>
        <fo:block>
            <xsl:value-of select="r:nazev"/> - <xsl:value-of select="r:cena"/> <xsl:value-of select="r:cena/@mena"/>
        </fo:block>
    </xsl:template>
    
    <xsl:template name="dalsi_informace">
        <fo:block>Další informace</fo:block>
        <fo:block>~ Cena/osoba: <xsl:value-of select="r:cena_osoba"/> <xsl:value-of select="r:cena_osoba/@mena"/></fo:block>
        <fo:block>Platba kartou: <xsl:value-of select="r:platba_kartou"/></fo:block>
        <fo:block>Qerko: <xsl:value-of select="r:qerko"/></fo:block>
        <fo:block>Polední menu: <xsl:value-of select="r:poledni_menu"/></fo:block>
        <fo:block>Datum návštěvy: <xsl:value-of select="r:datum_navstevy"/></fo:block>
    </xsl:template>
    
    
    
</xsl:stylesheet>
