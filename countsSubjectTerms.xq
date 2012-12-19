(: This checks all the subject terms mentioned in the MARC field of
authorized subject headings, and counts all the different terms it
finds. This also reports whether each of the subject terms exist in
the thesauri in use in PIKI; YSA, Kaunokki and Musa. In theory,
all should have a match. :)
(: This is not what i wanted to create, but a step in the right
direction :)

declare namespace skos="http://www.w3.org/2004/02/skos/core#";
declare namespace rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#";
declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace mx="http://www.loc.gov/MARC21/slim";

declare variable $resources := collection();
declare variable $testTerms := ("kissa", "koirat", "jänikset", "jänikset", "suihkulähteet");
declare variable $pikiSanastot := db:open('piki-sanastot');
declare variable $allowedTerms := $pikiSanastot/rdf:RDF/rdf:Description/skos:prefLabel[@xml:lang="fi"]/data();

<termsInThesauri>{
	for $term in /records/record/srw:recordData/mx:record/mx:datafield[@tag="650"]/mx:subfield[@code="a" or @code = "b" or @code = "c" or @code = "d" or @code = "e" or @code = "v" or @code="x" or @code = "y" or @code = "z"]
	  let $c := count($term)
	  group by $term
	  order by count($c) descending
	  return <term
	    count="{count($c)}"
	    allowed="{if ($term = $allowedTerms)
	      then 'true'
	      else 'false'}">{
	        $term
        }</term>
}</termsInThesauri>