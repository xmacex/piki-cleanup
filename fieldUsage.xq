(: report which MARC fields are in use, and to what extend. This gives an overview of the metadata. By further developing this to subsets of the data (monographs vs. music vs. journals vs. fiction, insight can be gained :)

(: the hoomin-readable stuff is too dependant on file location, and some fields like 007 and 008 bring in too much information. Oh well :)

(: beware, according to my profiling this will run for 7 hours on an Amazon AWS EC2 m1.small instance, which BaseX 7.3 serving a database of 2.5 million records. Lol could benefit from some optimizations :)

declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace mx="http://www.loc.gov/MARC21/slim";

<fieldUsage>{
let $forHoomins := fn:collection('marc21-xml')
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
