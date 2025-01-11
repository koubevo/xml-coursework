<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <sch:rule context="datum_navstevy">
            <sch:assert test=". &lt;= current-date()">Datum návštěvy nesmí být v budoucnosti.</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>