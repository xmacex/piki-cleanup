(: find out which thesauri are referred to in the data, and count how many terms each (claimed) is providing to the data :)

declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace mx="http://www.loc.gov/MARC21/slim";

<saurusDistribution>{
(: let $thesauri := ('allars', 'kaunokki', 'musa', 'ysa') :)

(: artificially limit the input set, for testing purposes :)
(: let $input := for $doc in collection()
	where matches(document-uri($doc), 'dump_2100000_219999')
  return $doc :)

let $allterms := /records/record/srw:recordData/mx:record/mx:datafield[@tag="650"]

for $saurus in distinct-values($allterms/mx:subfield[@code="2"])
let $count := count($allterms[mx:subfield[@code="2"] = $saurus])
order by $count descending
return
  <thesaurus>
    <name>{$saurus}</name>
    <count>{$count}</count>
  </thesaurus>
}</saurusDistribution>