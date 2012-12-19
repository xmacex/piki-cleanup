(: A tool to screenscape Soitinnimien ohjeluettelo -database :)
(: First, i built a BaseX database out of the (invalid) HTML
files i downloaded with bash and curl, and this XQuery builds
a simple and practical XML document out of the data :)

declare namespace xhtml="http://www.w3.org/1999/xhtml";

<soitinnimet>{
for $term in //xhtml:td
where $term/xhtml:div/xhtml:span[matches(@id, "labelFalseTerms")]
order by $term/xhtml:span[1]/data()
return
  <termmapping>
    {for $ft in tokenize($term/xhtml:div/xhtml:span[matches(@id, "labelFalseTerms")], " - ")
    return <falseterm>{$ft}</falseterm>}
  	<correctterm>
      {$term/xhtml:span[1]/data()}
    </correctterm>
  </termmapping>
}</soitinnimet>