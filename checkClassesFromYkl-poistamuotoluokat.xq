(: Ok, so our classification system YKL allows these things called "muotoluokat".
They are subclasses of their parent classes, and indicated as suffixes. F.ex. 09 is
'history of...', 065 is 'meetings about...', 038 is 'dictionaries of...' and so on.
Thus, say 02.323 is 'cataloguing', then 02.32309 is history of cataloguing,
02.323038 is dictionaries of catalouing etc.

I'm not particularly a friend of them, but oh well. I heard Ranganathan made
them up.

Anyway, the muotoluokat of YKL are described at
http://ykl.kirjastot.fi/fi-FI/muotoluokat/. This tool tries to survive them,
and still produce useful reports of illegal classes. The fact that only some of
the muotoluokat are defined within real classes is totally neglected here, so
corners are indeed cut.

This tool eats the data produced by checkClassesFromYkl.xq, and relies on
a copy to YKL screenscraped with scrapeYkl.xq. :)

declare variable $input := fn:doc('checkClassesFromYkl.xml');
declare variable $ykl := fn:doc('ykl.xml')/ykl/class/@no;
declare variable $muotoLuokatReplace := '(01|02|03|038|04|05|051|052|053|054|06|062|063|064|065|07|08|081|09)$';

<invalidYklClasses>{
  for $class in $input/yklClasses/yklClass[@inYkl = 'false']
    let $classMuotoluokatta := fn:replace(fn:replace($class, $muotoLuokatReplace, ''), '\.$', '')
(:    let $classMuotoluokatta := fn:replace($classMuotoluokatta, '\.$', '') :)
    where not($classMuotoluokatta = $ykl)
    order by $classMuotoluokatta
    return <notYkl>{
      $classMuotoluokatta
    }</notYkl>
}</invalidYklClasses>