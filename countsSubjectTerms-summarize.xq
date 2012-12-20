(: Summarizes the usage of authorized subject terms, and how much of it's various
parts really are controlled :)

declare variable $input := fn:doc('piki/countsSubjectTerms.xml');
declare variable $subfields := ('a', 'b', 'c', 'd', 'e', 'v', 'x', 'y', 'z');

<subfieldsOfSubjectTerms>{
  for $subfield in $subfields
    return <subfield
      code="{$subfield}">{
        <occurrences>{
          sum($input/termsInThesauri/subfield[@code = $subfield]/term/@count)
        }</occurrences>,
        <percentageControlled>{
          (sum($input/termsInThesauri/subfield[@code = $subfield]/term[@allowed="true"]/@count) div sum($input/termsInThesauri/subfield[@code = $subfield]/term/@count) * 100)
        }</percentageControlled>,
        <uniqueTerms>{
          count($input/termsInThesauri/subfield[@code = $subfield]/term)
        }</uniqueTerms>,
        <uniqueTermspercentageControlled>{
          count($input/termsInThesauri/subfield[@code = $subfield]/term[@allowed="true"]) div count($input/termsInThesauri/subfield[@code = $subfield]/term) * 100
        }</uniqueTermspercentageControlled>
    }</subfield>
}</subfieldsOfSubjectTerms>