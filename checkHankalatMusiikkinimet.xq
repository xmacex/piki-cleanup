(: Find author data in records, and report if it has been marked in the Hankalat musiikkinimet -database. It countains a few thousand "replaces" -and "replaced by" -relations, which i've screenscraped and prepared with hankalat-musiikkinimet-disassemble.xq. This will take a a long time to check, since the database contains a few thousand names both ways. Be prepared. :)

declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace marc="http://www.loc.gov/MARC21/slim";

let $hankalatMusiikkinimet := fn:doc('piki/hankalat_musiikkinimet/hankalat_musiikkinimet-corrections.xml')
let $badAuthors := $hankalatMusiikkinimet/hankalatMusiikkinimet/termmapping/falseterm
let $goodAuthors := $hankalatMusiikkinimet/hankalatMusiikkinimet/termmapping/correctterm
let $records := /records/record/srw:recordData/marc:record

for $author in $records/marc:datafield[@tag="100"]/marc:subfield[@code="a"]
let $normalizedAuthor := replace($author, '[,\.]$', '')
return
	<authorName
    isReplaced="{if ($normalizedAuthor = $badAuthors)
      then "true"
      else if ($normalizedAuthor = $goodAuthors)
        then "false"
      else ""
      }">
    {$normalizedAuthor}
  </authorName>