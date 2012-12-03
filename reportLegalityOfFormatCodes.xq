(: finds all format codes in leader/06, and reports if they are legal or not. I'm using the XML representation of MARC21 compiled by National Library of Finland :)

declare variable $input := fn:doc('piki/leaderNot24bytes.xml');
declare variable $leaderDefinition := fn:doc('piki/marc21-xml/000.xml');
(: declare variable $okFormatCodes := ('a', 't', 'm', 'e', 'f', 'c', 'd', 'i', 'j', 'g', 'k', 'r', 'o', 'p'); :)
declare variable $okFormatCodes := $leaderDefinition/fields/leader-directory/leader/positions/position[@pos = "06"]/values/value/@code/data();

<formatCodes>{
for $leader in $input/recordsWithInvalidLeaderLength/evilLeader
  let $formatCode := substring($leader, 1+6, 1)
  return <formatCode isLegal="{
      if ($formatCode = $okFormatCodes)
        then "true"
        else "false"
  }">{$formatCode}</formatCode>
}</formatCodes>