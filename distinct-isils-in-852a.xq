declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace mx="http://www.loc.gov/MARC21/slim";

for $all in /records
let $dv := distinct-values($all/record/srw:recordData/mx:record/mx:datafield[@tag="852"]/mx:subfield[@code="a"])
return $dv