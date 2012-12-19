(: In PIKI we the function codes are not in use. Instead less 
strictly defined function terms are used. Maybe the web-interface
Axiell Arena doesn't know how to handle the standard codes. Anyways
the list of allowed terms are listed in local cataloguing rules, and
below at $allowedFunctionTerms. Music data has it's own conventions.

See what values are defined, and count their distribution across
the data :)

declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace mx="http://www.loc.gov/MARC21/slim";

declare variable $functionTerms := ('A', 'äänitt.', 'anim.', 'B', 'Bar', 'dramat.', 'esitt.', 'graaf.', 'joht.', 'käänt.', 'kaivert.', 'käsik.', 'kert.', 'kok.', 'koreogr.', 'Kt', 'kuv.', 'kuvatait.', 'laulu', 'lausuja', 'lav.', 'leikk.', 'lukija', 'miks.', 'mus.', 'Mz', 'näytt.', 'ohj.', 'opett.', 'piirt.', 'poikasopraano', 'S', 'san.', 'säv.', 'sorm.', 'sov.', 'suunn.', 'T', 'tanssi', 'täyd.', 'toim.', 'transkr.', 'tuott.', 'valok.');
declare variable $musicalInstrumentTerms := fn:doc('soitinnimet.xml')/*:soitinnimet/*:termmapping/*:correctterm/string();
declare variable $allowedFunctionTerms := ($functionTerms, $musicalInstrumentTerms);

<functionTerms>{
  for $functionTerm in /records/record/srw:recordData/mx:record/mx:datafield[@tag="100" or @tag="110" or @tag = "700" or @tag="710"]/mx:subfield[@code="e"]
    let $c := count($functionTerm)
    group by $functionTerm
    order by count($c) descending
    return <functionTerm
      count="{count($c)}"
      allowed="{if ($functionTerm = $allowedFunctionTerms)
        then 'true'
        else 'false'}">{
          $functionTerm
    }</functionTerm>
}</functionTerms>