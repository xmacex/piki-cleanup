(: A tool to see if any of the used subject heading terms have
been marked as replaced in the thesauri/ontologies, and if so, by
which term. :)
(: Eats the output of countsSubjectTerms.xq as input. Corners are
cut, since the process loses information about the origin of each term.
This is unnecessary, really, and should be redesigned. :)

declare namespace skos="http://www.w3.org/2004/02/skos/core#";
declare namespace rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#";

declare variable $realTerms := fn:doc('piki/countsSubjectTerms.xml')/termsInThesauri/subfield/term;
declare variable $altLabels := db:open('piki-sanastot')/rdf:RDF/rdf:Description/skos:altLabel;

<replacedTerms>{
  for $realTerm in $realTerms
    let $count as xs:integer := $realTerm/@count
    where $realTerm = $altLabels
    order by $count descending
    return
    <replacedTerm
      replacedBy="{$altLabels[. = $realTerm]/../skos:prefLabel[@xml:lang='fi']}"
      count="{$count}">{
        $realTerm/data()
    }</replacedTerm>
}</replacedTerms>