(: Some of the records in this data don't have a leader of 24 bytes as dictated by the MARC record. This finds them :)

declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace marc="http://www.loc.gov/MARC21/slim";

<recordsWithInvalidLeaderLength>{
for $record in /records/record/srw:recordData/marc:record
  where not(string-length($record/marc:leader) = 24)
  return <evilRecord
      id="{$record/marc:controlfield[@tag='001']}"
      length="{string-length($record/marc:leader)}">
      {
        $record/marc:leader/data()
      }</evilRecord>
}</recordsWithInvalidLeaderLength>