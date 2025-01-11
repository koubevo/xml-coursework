<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    
    <sch:ns uri="urn:x-koubevo:schemas:restaurace" prefix="r"/>
    
    <sch:pattern>
        <sch:title>Kontrola datumu návštěvy</sch:title>
        <sch:rule context="r:restaurace/r:datum_navstevy">
            <sch:assert test="xs:date(.) le current-date()">
                Datum návštěvy nesmí být v budoucnosti! (Datum: <sch:value-of select="."/>)
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:title>Kontrola hodnocení</sch:title>
        <sch:rule context="r:restaurace/r:hodnoceni/r:hvezdicky/r:finalni">
            <sch:assert test="number(.) ge 0 and number(.) le 5">
                Hodnocení musí být v rozmezí 0 až 5! (Hodnota: <sch:value-of select="."/>)
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
</sch:schema>
