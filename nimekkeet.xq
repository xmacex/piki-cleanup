(: Example how to properly set the namespaces to XQuery the PIKI database XML dumps from Axill :)

declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace mx="http://www.loc.gov/MARC21/slim";

for $r in /records/record/srw:recordData/mx:record
let $y := substring($r/mx:controlfield[@tag="008"], 8, 4)
(:order by $r/mx:datafield[@tag="260"]/mx:subfield[@code="c"] :)
order by $y
return <li>{$r/mx:datafield[@tag="245"]/mx:subfield[@code="a"]/text()}, {$r/mx:datafield[@tag="260"]/mx:subfield[@code="c"]/text()}, kiinteämittaisesta noukittuna {$y}</li>