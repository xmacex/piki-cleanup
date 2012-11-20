(: find out which thesauri are referred to in the data, and count how many terms each (claimed) is providing to the data :)

declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace mx="http://www.loc.gov/MARC21/slim";

<saurusDistribution>{
(: let $thesauri := ('allars', 'kaunokki', 'musa', 'ysa') :)

(: artificially iterate through each of the documents in the collection, for testing and performance purposes :)

let $input := for $doc in collection()
(:  where matches(fn:document-uri($doc), '1000000|2000000') :)
  return fn:document-uri($doc)

for $d in $input
let $allterms := fn:doc($d)/records/record/srw:recordData/mx:record/mx:datafield[@tag="650"]

for $saurus in distinct-values($allterms/mx:subfield[@code="2"])
let $count := count($allterms[mx:subfield[@code="2"] = $saurus])
order by $count descending
return
  <thesaurus id="{$d}">
    <name id="{$d}">{$saurus}</name>
    <count id="{$d}">{$count}</count>
  </thesaurus>
}</saurusDistribution>