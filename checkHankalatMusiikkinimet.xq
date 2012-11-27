(: Find author data in records, and report if it has been marked in the Hankalat musiikkinimet -database. It countains a few thousand "replaces" -and "replaced by" -relations, which i've screenscraped and prepared with hankalat-musiikkinimet-disassemble.xq. :)

(: This will take a a long time to run, since the Hankalat musiikkinimet database contains a few thousand names both ways. With minimal string-fiddling, my netbook checks 100 000 records in about 181095.82ms. You have been warned :)

declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace marc="http://www.loc.gov/MARC21/slim";

let $hankalatMusiikkinimet := fn:doc('piki/hankalat_musiikkinimet/hankalat_musiikkinimet-corrections.xml')
let $badAuthors := $hankalatMusiikkinimet/hankalatMusiikkinimet/termmapping/falseterm
let $goodAuthors := $hankalatMusiikkinimet/hankalatMusiikkinimet/termmapping/correctterm
let $records := /records/record/srw:recordData/marc:record

for $author in $records/marc:datafield[@tag="100"]/marc:subfield[@code="a"]
let $normalizedAuthor := replace($author, '[,\.]$', '')
return
	<hankalaMusiikkinimi 
    authorized="{if ($normalizedAuthor = $badAuthors)
      then "replaced-by-smth"
      else if ($normalizedAuthor = $goodAuthors)
        then "replaces-smth"
      else ()
      }">
    {$normalizedAuthor}
  </hankalaMusiikkinimi>