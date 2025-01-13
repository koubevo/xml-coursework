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
        </fo:root>
    </xsl:template>
</xsl:stylesheet>
