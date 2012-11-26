(: An implementation of language code checking with XQuery, by iterating through the existing list of language codes (read to $existingLangCodes) against the list of legal codes (read to $okLangCodes) :)
(: argh where are all these namespaces coming from? Must... not... fight... them... with... *: -assignments... . Problems of screenscraping. :)

let $okLangCodes := fn:doc('scrapeLangCodes.xml')/*:marc21LangCodes/*:lang/*:code/data()
let $existingLangCodes := fn:doc('existingLangCodes-test.xml')

for $l in $existingLangCodes/*:languageCodes008/*:lang
return
  <pikiLangCode
    isLegal="{if ($l = $okLangCodes)
      then "true"
      else "false"
      }">
    {$l/data()}
  </pikiLangCode>