(: Finds all values of the language codes in 008 35-37, and simply prints all of them :)

declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace marc="http://www.loc.gov/MARC21/slim";

<languageCodes008>{
for $field in /records/record/srw:recordData/marc:record/marc:controlfield[@tag="008"]
return
	<lang>{substring($field, 1 + 35, 3)}</lang>
}</languageCodes008>