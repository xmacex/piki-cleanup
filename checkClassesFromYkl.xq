(: Check all classification fields which claim to get their value from
YKL classification systems, see if they are really define there. Based
on my screenscraped YKL :)

declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace marc="http://www.loc.gov/MARC21/slim";

declare variable $yklres := fn:doc('ykl.xml');
declare variable $ykl := $yklres/ykl/class/@no/data();

<yklClasses>{
for $field in /records/record/srw:recordData/marc:record/marc:datafield[@tag="084"]
  let $classNo := $field/marc:subfield[@code="a"]/data()
  where $field[marc:subfield[@code="2"] = "ykl"]
  return <yklClass
    inYkl="{if ($classNo = $ykl) then 'true' else 'false'}">{
      $classNo
  }</yklClass>
}</yklClasses>