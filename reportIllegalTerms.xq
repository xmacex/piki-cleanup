(: This checks terms in MARC, and reports on the ones which claim to come from
the defined thesauri, but the thesauri don't really have that term. I have a BaseX
database, joined from the three thesauri in use in PIKI; YSA, Kaunokki and Musa :)

declare namespace skos="http://www.w3.org/2004/02/skos/core#";
declare namespace rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#";
declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace mx="http://www.loc.gov/MARC21/slim";

declare variable $resources := collection();
declare variable $testTerms := ("kissa", "koirat", "jänikset", "jänikset", "suihkulähteet");
declare variable $pikiSanastot := db:open('piki-sanastot');

<stinkyTerms>{
  for $res in $resources
    return
	    for $term in $res/records/record/srw:recordData/mx:record/mx:datafield[@tag="650"]/mx:subfield[@code="a" or @code = "b" or @code = "c" or @code = "d" or @code = "e" or @code = "v" or @code="x" or @code = "y" or @code = "z"]
        let $thesaurus := $term/../mx:subfield[@code="2"]
        let $recordId := $term/../../mx:controlfield[@tag="001"]
	      where (not($term = $pikiSanastot/rdf:RDF/rdf:Description/skos:prefLabel[@xml:lang="fi"]))
	    	return <stinkyTermOccurrence
          id = "{$recordId}"
          declaredThesaurus = "{$thesaurus/data()}">
            {$term/data()}
        </stinkyTermOccurrence>
}</stinkyTerms>