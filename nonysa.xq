(: dump all subject headings which are not from YSA :)

declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace mx="http://www.loc.gov/MARC21/slim";

for $nonysa in (/records/record/srw:recordData/mx:record/mx:datafield[@tag="650"][not(. /mx:subfield[@code="2"] = 'ysa')])
return <li>
<id>{$nonysa/../mx:controlfield[@tag="001"]/data()}</id>
<term>{$nonysa/mx:subfield[@code="a" or @code="x" or @code="y" or @code="z"]/data()}</term>
</li>