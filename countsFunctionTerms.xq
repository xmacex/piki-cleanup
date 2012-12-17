(: In PIKI we the function codes are not in use. Instead less 
strictly defined function terms are used. Maybe the web-interface Axiell Arena doesn't know how to handle the standard codes. Anyways the list of
allowed terms are listed in local cataloguing rules, and below at $allowedFunctionTerms. Music data has it's own conventions.

See what values are defined, and count their distribution across the data :)

declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace mx="http://www.loc.gov/MARC21/slim";

declare variable $allowedFunctionTerms := ('anim.', 'dramat.', 'esitt.', 'graaf.', 'joht.', 'kaivert.', 'kert.', 'kok.', 'koreogr.', 'kuv.', 'kuvatait.', 'käsik.', 'lav.', 'leikk.', 'miks.', 'mus.', ',näytt.', 'ohj.', 'opett.', 'piirt.', 'san.', 'sov.', 'suunn.', 'säv.', 'tanssi', 'tuott.', 'valok.', 'äänitt.');

<functionTerms>{
  for $functionTerm in distinct-values(/records/record/srw:recordData/mx:record/mx:datafield[@tag="100" or @tag = "700" or @tag="710"]/mx:subfield[@code="e"])
    let $count := count(/records/record/srw:recordData/mx:record/mx:datafield[@tag="100" or @tag = "700"][mx:subfield[@code="e"] = $functionTerm])
    order by $count descending
    return <functionTerm
      count="{$count}"
      allowed="{if ($functionTerm = $allowedFunctionTerms)
        then 'true'
        else 'false'}">{
        $functionTerm
    }</functionTerm>
}</functionTerms>