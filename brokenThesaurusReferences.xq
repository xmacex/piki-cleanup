(: find broken thesaurus references, where indicator 2 claims that subfield 2 should have the code of the thesaurus, but either isn't defined or is empty :)

declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace mx="http://www.loc.gov/MARC21/slim";

for $term in /records/record/srw:recordData/mx:record/mx:datafield[@tag="650"and @ind2 = "7"]
(:  where $term/mx:subfield[@code=""] :)
  where not($term/mx:subfield[@code="2"] or $term/mx:subfield[@code="2"] = "")
  return $term