(: finds all format codes in leader/06, and reports if they are legal or not. I'm using the XML representation of MARC21 compiled by National Library of Finland :)

declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace mx="http://www.loc.gov/MARC21/slim";

declare variable $leaderDefinition := fn:doc('marc21-xml/000.xml');
declare variable $okFormatCodes := $leaderDefinition/fields/leader-directory/leader/positions/position[@pos = "06"]/values/value/@code/data();
declare variable $resources := collection();

<formatCodes>{
for $res in $resources
  return
  <formatCodesPerResource resource="{fn:document-uri($res)}">{
  for $record in $res/records/record/srw:recordData/mx:record
    let $id := $record/mx:controlfield[@tag='001']
    let $leader := $record/mx:leader
    let $formatCode := substring($leader, 1+6, 1)
    return <formatCode
      id = "{$id}"
      isLegal="{
        if ($formatCode = $okFormatCodes)
          then "true"
          else "false"
    }">{$formatCode}</formatCode>
  }</formatCodesPerResource>
}</formatCodes>