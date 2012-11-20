declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace mx="http://www.loc.gov/MARC21/slim";

for $r in /records/record/srw:recordData/mx:record
return $r/mx:datafield[@tag="852"]
