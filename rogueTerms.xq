(: dump all subject headings which don't tell they are from one of the allowed vocabularies, stored in $thesauri :)

(: 2do: second indicator's value "4" tells that the thesaurus isn't indicated anywhere. it should still come from /come/ thesaurus, uncontrolled terms have their own field 653 :)

(: 2do whould i check that pointing to a un-defined subfield 2 with ind2=7 seems like a bad idea? :)

declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace mx="http://www.loc.gov/MARC21/slim";

let $thesauri := ('allars', 'kaunokki', 'musa', 'ysa')

for $rogueterm in (/records/record/srw:recordData/mx:record/mx:datafield[@tag="650"][not(. /mx:subfield[@code="2"] = $thesauri)])
return $rogueterm