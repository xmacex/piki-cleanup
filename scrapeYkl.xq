(: Generate useful XML out of screenscraped YKL classification system at
http://ykl.kirjastot.fi. Well, the actua screenscraping from the website
is to be done outside this XQuery. I just manually saved a all the 17 files
with my browser. :)

declare namespace xhtml = "http://www.w3.org/1999/xhtml";

  for $class in //xhtml:table[@class="classList tableEvents"]/xhtml:tr[not(@class="Normal-Header-0")]/xhtml:td[@class="number"]
    let $name := $class/../xhtml:td[@class="name"]/xhtml:a/data()
    let $no := $class/../xhtml:td[@class="number"]/xhtml:a/data()
    order by $no
    return <class
      no="{$no}">
        {$name}
      </class>