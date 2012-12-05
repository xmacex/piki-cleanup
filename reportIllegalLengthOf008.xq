declare namespace mx="http://www.loc.gov/MARC21/slim";
declare namespace srw="http://www.loc.gov/zing/srw/";

declare variable $resources := collection();

<fixedLengthField008isNotFixed>{
  for $res in $resources
    return <wrongLength008PerResource id="{document-uri($res)}">{
      for $field in $res/records/record/srw:recordData/mx:record/mx:controlfield[@tag="008"]
        where (not(string-length($field/data()) eq 40))
        return <wrongLength008
          id="{$field/../mx:controlfield[@tag="001"][1]}"
          length="{string-length($field)}">
          {$field/data()}
        </wrongLength008>
    }</wrongLength008PerResource>
}</fixedLengthField008isNotFixed>