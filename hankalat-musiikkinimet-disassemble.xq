(: A tool to screenscape Hankalat musiikkinimet -database :)
(: reads the (invalid) HTML files, and builds a simple XML structure with invalid, and valid terms :)

declare namespace xhtml="http://www.w3.org/1999/xhtml";

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