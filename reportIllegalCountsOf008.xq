(: Repeating, or missing 008 is a bad idea. And illegal. Report on
violating records :)

declare namespace mx="http://www.loc.gov/MARC21/slim";
declare namespace srw="http://www.loc.gov/zing/srw/";

declare variable $resources := collection();

<badCountsOf008>{
  for $res in $resources
    return <wrongCount008PerResource id="{document-uri($res)}">{
      for $r in $res/records/record/srw:recordData/mx:record
        where (not(count($r/mx:controlfield[@tag="008"]) eq 1))
        return <badCountOf008
          id="{$r/mx:controlfield[@tag="001"]/data()}"
          count="{count($r/mx:controlfield[@tag="008"])}">
            {$r/mx:controlfield[@tag="008"]/data()}
        </badCountOf008>
    }</wrongCount008PerResource>
}</badCountsOf008>