(: This checks terms from the legal thesauruses (YSA, Kaunokki and Musa in PIKI, build
into my piki-sanastot -database). Outputs stuff :)

declare namespace skos="http://www.w3.org/2004/02/skos/core#";
declare namespace rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#";

let $testTerms := ("kissa", "koirat", "jänikset", "jänikset", "suihkulähteet")
let $pikiSanastot := db:open('piki-sanastot')

for $term in $testTerms
  where $term = $pikiSanastot/rdf:RDF/rdf:Description/skos:prefLabel[@xml:lang="fi"]
	return $pikiSanastot/rdf:RDF/rdf:Description[skos:prefLabel[@xml:lang="fi"] = $term]