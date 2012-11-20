declare namespace rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#";
declare namespace skos="http://www.w3.org/2004/02/skos/core#";

<replacedYsaTerms>{
for $l in /rdf:RDF/rdf:Description/skos:altLabel
order by $l
return <li prefLabel="{$l/../skos:prefLabel}">{$l/data()}</li>
}</replacedYsaTerms>