(: rips the MARC21 language codes from this page http://www.kansalliskirjasto.fi/extra/marc21/kielet_koodit.htm of MARC21 language codes, maintained by the National Library of Finland :)

declare namespace xhtml="http://www.w3.org/1999/xhtml";

<marc21LangCodes>{
let $webpage := fn:doc('http://www.kansalliskirjasto.fi/extra/marc21/kielet_koodit.htm')
for $l in $webpage/xhtml:html/xhtml:body/xhtml:table/xhtml:tr
order by $l/xhtml/td[1]
return
  <lang>
    <code>{$l/xhtml:td[1]/string()}</code>
    <name lang="fi">{$l/xhtml:td[2]/string()}</name>
    <name lang="en">{$l/xhtml:td[3]/string()}</name>
    <note>{$l/xhtml:td[4]/string()}</note>
  </lang>
}</marc21LangCodes>