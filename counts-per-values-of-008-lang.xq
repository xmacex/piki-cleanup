declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace marc="http://www.loc.gov/MARC21/slim";

<languagecodes008>{
let $langCodes := /records/record/srw:recordData/marc:record/marc:controlfield[@tag="008"]/substring(., 1+35, 3)

for $lang in distinct-values($langCodes)
return
	<lang count="{count(/records/record/srw:recordData/marc:record/marc:controlfield[@tag="008"][substring(., 1+35,3) = $lang])}">{$lang}</lang>
}</languagecodes008>