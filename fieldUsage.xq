(: report which MARC fields are in use, and to what extend. This gives an overview of the metadata. By further developing this to subsets of the data (monographs vs. music vs. journals vs. fiction, insight can be gained :)

(: the hoomin-readable stuff is too dependant on file location, and some fields like 007 and 008 bring in too much information. Oh well :)

declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace mx="http://www.loc.gov/MARC21/slim";

<fieldUsage>{
let $forHoomins := fn:collection('/home/mace/Downloads/marc21-xml')
let $allFields := /records/record/srw:recordData/mx:record/*/@tag
for $f in distinct-values($allFields)
  order by $f
  return
    <field
    count="{count(/records/record/srw:recordData/mx:record/*[@tag = $f])}"
    description="{$forHoomins/fields/*/*[@tag = $f]/name}">
    {$f}
    </field>
}</fieldUsage>