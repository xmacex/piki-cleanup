(: An implementation of language code checking with XQuery. Iterates through records, and reports on all records whose 008 language code is not in the list screenscraped from National Library Of Finland's website, using scrapeLangCodes.xq :)

(: argh where are all these namespaces coming from? Must... not... fight... them... with... *: -assignments... . Problems of screenscraping. :)

declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace mx="http://www.loc.gov/MARC21/slim";

declare variable $okLangCodes := fn:doc('scrapeLangCodes.xml')/*:marc21LangCodes/*:lang/*:code/data();
declare variable $input := fn:doc('existingLangCodes-test.xml');
declare variable $resources := collection();

<langCodesOf008>{
for $res in $resources
  return
    <langCodesPerResource resource="{fn:document-uri($res)}">{
      for $record in $res/records/record/srw:recordData/mx:record
        let $id := $record/mx:controlfield[@tag='001']
        let $field008 := $record/mx:controlfield[@tag="008"]
        let $langCode := substring($field008, 1+35, 3)
          (: /*:languageCodes008/*:lang :)
        return
          if (not($langCode = $okLangCodes)) then
            <illegalLangCodeIn008 id="{$id}">{$langCode}</illegalLangCodeIn008>
            else ()
    }</langCodesPerResource>
}</langCodesOf008>