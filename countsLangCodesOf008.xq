declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace marc="http://www.loc.gov/MARC21/slim";

<languageCodes008>{
for $lang in distinct-values(/records/record/srw:recordData/marc:record/marc:controlfield[@tag="008"]/substring(., 1+35, 3))
return
	<lang count="{count(/records/record/srw:recordData/marc:record/marc:controlfield[@tag="008"][substring(., 1+35,3) = $lang])}">{$lang}</lang>
}</languageCodes008>