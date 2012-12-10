(: Find all encoding levels from leader/17, and report how
many times each one is used in the data. This is a measure of how good
and useful the data claims to be... though i have to admit i assume in our
database this information is FUBAR, and same for other collections
of library metadata too. :)

declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace marc="http://www.loc.gov/MARC21/slim";

declare variable $leaderDefinition := fn:doc('marc21-xml/000.xml');
declare variable $levelCodes := $leaderDefinition/fields/leader-directory/leader/positions/position[@pos = "17"];

<encodingLevels>{
  for $level in distinct-values(/records/record/srw:recordData/marc:record/marc:leader/substring(., 1+17, 1))
  return
  	<level
      count="{count(/records/record/srw:recordData/marc:record/marc:leader[substring(., 1+17, 1) = $level])}"
      name="{$levelCodes/values/value[@code = $level]/name}"
      description="{$levelCodes/values/value[@code = $level]/description}">
      {$level}
    </level>
}</encodingLevels>