(: Eats the Yleinen suomalainen asiasanasto (YSA, Generic Finnish Thesaurus) in skosified RDF format, which is available from the Onki -service (http://www.onki.fi). This finds all the terms which have been replaced, and lists both the replaced and replacing terms (well, technically speaking their labels since we're nowehere near semantic web, linked data, RDF or anything like that) :)

declare namespace rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#";
declare namespace skos="http://www.w3.org/2004/02/skos/core#";

<replacedYsaTerms>{
for $l in /rdf:RDF/rdf:Description/skos:altLabel
order by $l
return <li prefLabel="{$l/../skos:prefLabel}">{$l/data()}</li>
}</replacedYsaTerms>
