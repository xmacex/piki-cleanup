(: An implementation of status code checking with XQuery. Iterates
through records, and reports on all records whose status
code is not in the list XML representation maintained by the National
Library of Finland :)

declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace mx="http://www.loc.gov/MARC21/slim";

declare variable $leaderDefinition := fn:doc('marc21-xml/000.xml');
declare variable $okStatusCodes := $leaderDefinition/fields/leader-directory/leader/positions/position[@pos = "05"]/values/value/@code/data();
declare variable $resources := collection();

<statusCodesOfLeader>{
for $res in $resources
  return
    <statusCodesPerResource resource="{fn:document-uri($res)}">{
      for $record in $res/records/record/srw:recordData/mx:record
        let $id := $record/mx:controlfield[@tag='001']
        let $leader := $record/mx:leader
        let $statusCode := substring($leader, 1+5, 1)
        return
          if (not($statusCode = $okStatusCodes)) then
            <illegalStatusCodeInLeader id="{$id}">{$statusCode}</illegalStatusCodeInLeader>
            else ()
    }</statusCodesPerResource>
}</statusCodesOfLeader>