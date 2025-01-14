<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xpath-default-namespace="urn:x-koubevo:schemas:restaurace">
    
    <xsl:output method="html" version="5" name="html5"/>
    
    <xsl:template match="/">
        <xsl:result-document href="index.html" method="html" version="5">
            <html lang="cs">
                <head>
                    <title>Recenze restaurací</title>
                    <link rel="stylesheet" type="text/css" href="sem_html.css"/>
                </head>
                <body>
                    <h1 class="mb">Recenze restaurací</h1>
                    <table>
                        <thead>
                            <tr>
                                <th>Název</th>
                                <th>Město</th>
                                <th>Hodnocení</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:for-each select="recenze/restaurace">
                                <xsl:sort select="hodnoceni/hvezdicky/finalni" data-type="number" order="descending"/>
                                <tr>
                                    <td><a href="{id}.html"><xsl:value-of select="nazev"/></a></td>
                                    <td><xsl:value-of select="mesto"/></td>
                                    <td>
                                        <xsl:apply-templates select="hodnoceni/hvezdicky/finalni" mode="menu"/>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </tbody>
                    </table>
                </body>
            </html>
        </xsl:result-document>
        
        
        <xsl:for-each select="recenze/restaurace">
            <xsl:variable name="file" select="concat(id, '.html')"/>
            <xsl:result-document href="{$file}" method="html" version="5">
                <html lang="cs">
                    <head>
                        <title><xsl:value-of select="nazev"/></title>
                        <link rel="stylesheet" type="text/css" href="sem_html.css"/>
                    </head>
                    <body>
                        <a href="index.html" class="back">← Všechny recenze</a>
                        <div>
                            <h1 class="mb-2"><xsl:value-of select="nazev"/></h1>
                            <xsl:apply-templates select="top_jidlo/foto"/>
                        </div>
                        <div class="mb">
                            <p>
                                <xsl:value-of select="mesto"/>
                                <xsl:text> | </xsl:text>
                                <xsl:value-of select="stat"/>
                            </p>
                        </div>
                        <div class="mb">
                            <xsl:apply-templates select="kategorie"/>
                        </div>
                        <div class="mb-2">
                            <xsl:apply-templates select="majitel"/>
                            <xsl:apply-templates select="popis"/>
                            <xsl:apply-templates select="menu"/>
                        </div>
                        <div class="mb-2">
                            <xsl:apply-templates select="hodnoceni"/>
                            <xsl:apply-templates select="top_jidlo"/>
                        </div>
                        <div class="mb-2">
                            <xsl:apply-templates select="oteviraci_doba"/>
                        </div>
                        <div class="mb-2">
                            <h2>Další informace</h2>
                            <xsl:apply-templates select="cena_osoba"/>
                            <xsl:apply-templates select="platba_kartou"/>
                            <xsl:apply-templates select="qerko"/>
                            <xsl:apply-templates select="poledni_menu"/>
                            <xsl:apply-templates select="datum_navstevy"/>
                        </div>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="top_jidlo/foto">
        <img src="./imgs/{text()}" alt="{../../nazev} - obrázek jídla" class="mb"/>
    </xsl:template>
    
    <xsl:template match="majitel">
        <span class="owner">
            <xsl:if test="string-length(normalize-space(.)) > 0">
                Majitel: <xsl:value-of select="."/>
            </xsl:if>
        </span>
    </xsl:template>
    
    <xsl:template match="kategorie">
        <span class="tag"><xsl:value-of select="."/></span>
    </xsl:template>
    
    <xsl:template match="oteviraci_doba">
        <h2 class="mb">Otevírací doba</h2>
        <table>
            <thead>
                <tr>
                    <th>Den</th>
                    <th>Otevřeno od</th>
                    <th>Otevřeno do</th>
                </tr>
            </thead>
            <tbody>
                <xsl:for-each select="*">
                    <tr>
                        <td>
                            <xsl:choose>
                                <xsl:when test="local-name() = 'pondeli'">Po</xsl:when>
                                <xsl:when test="local-name() = 'utery'">Út</xsl:when>
                                <xsl:when test="local-name() = 'streda'">St</xsl:when>
                                <xsl:when test="local-name() = 'ctvrtek'">Čt</xsl:when>
                                <xsl:when test="local-name() = 'patek'">Pá</xsl:when>
                                <xsl:when test="local-name() = 'sobota'">So</xsl:when>
                                <xsl:when test="local-name() = 'nedele'">Ne</xsl:when>
                            </xsl:choose>
                        </td>
                        
                        <xsl:choose>
                            <xsl:when test="@zavreno = 'true'">
                                <td colspan="2">Zavřeno</td>
                            </xsl:when>
                            <xsl:otherwise>
                                <td><xsl:value-of select="od"/></td>
                                <td><xsl:value-of select="do"/></td>
                            </xsl:otherwise>
                        </xsl:choose>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template match="popis">
        <p class="mb"><xsl:value-of select="text()"/></p>
    </xsl:template>
    
    <xsl:template match="menu">
        <p>Menu si můžete prohlédnout <a class="here" href="{text()}" target="_blank">zde</a>.</p>
    </xsl:template>
    
    <xsl:template match="hodnoceni">
        <h2 class="mb">Naše hodnocení</h2>
        <p class="mb"><xsl:value-of select="slovni"/></p>
        <ul class="mb-2">
            <!-- diakritika -->
            <xsl:for-each select="hvezdicky/*">
                <li>
                    <xsl:value-of select="local-name()"/>: 
                    <xsl:value-of select="."/>
                    <xsl:choose>
                        <xsl:when test="number(.) &lt; 4"> ☆</xsl:when>
                        <xsl:otherwise> ★</xsl:otherwise>
                    </xsl:choose>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>   
    
    <xsl:template match="top_jidlo">
        <h3 class="mb">Nejlepší jídlo</h3>
        <p><xsl:value-of select="nazev"/><xsl:text> </xsl:text><xsl:value-of select="cena"/><xsl:text> </xsl:text><xsl:value-of select="cena/@mena"/></p>
    </xsl:template>
    
    <xsl:template match="cena_osoba">
        <p>~ Cena/osoba: <xsl:value-of select="text()"/><xsl:text> </xsl:text><xsl:value-of select="@mena"/></p>
    </xsl:template>
    
    <xsl:template match="platba_kartou">
        <p>Platba kartou: <xsl:value-of select="text()"/></p>
    </xsl:template>
    
    <xsl:template match="qerko">
        <p>Qerko: <xsl:value-of select="text()"/></p>
    </xsl:template>
    
    <xsl:template match="poledni_menu">
        <p>Polední menu: <xsl:value-of select="text()"/></p>
    </xsl:template>
    
    <xsl:template match="datum_navstevy">
        <p>
            Datum návštěvy: 
            <xsl:value-of select="format-date(xs:date(.), '[D01].[M01].[Y2]')"/>
        </p>
    </xsl:template>
    
    <xsl:template match="hodnoceni/hvezdicky/finalni" mode="menu">
        <xsl:variable name="rating" select="number(.)"/>
        <xsl:choose>
            <xsl:when test="$rating &gt;= 4">
                <xsl:value-of select="text()"/><xsl:text> </xsl:text>★
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="text()"/><xsl:text> </xsl:text>☆
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
</xsl:stylesheet>