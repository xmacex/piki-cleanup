(:lists all functions aka. "roles" from 7X0 fields. The $e subfield seems contain functions, but according to the MARC21 format, they are in $4 as codes. :)

declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace mx="http://www.loc.gov/MARC21/slim";

let $muusikot := ("ALTTOVIULU.", "KANTELE.", "säv.", "san.")
for $records in /records
let $functions := $records/record/srw:recordData/mx:record/mx:datafield[@tag="700" or @tag="710"]/mx:subfield[@code="e"]/data()
for $dv in distinct-values($functions)
order by $dv
return
  if ($dv = $muusikot) then
    <li>ping pong {$dv}</li>
    else <li>ripsis ripsis {$dv}</li>