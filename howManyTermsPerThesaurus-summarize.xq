(: this reads a database, which is made of howManyTermserThesaurus-split.xq -output. Not very elegant, i admit :)

<saurusSummary>{
(: let $pikithesauri := ('ysa', 'musa', 'kaunokki') :)
for $dv in distinct-values(/saurusDistribution/thesaurus/name)
  let $sum := sum(/saurusDistribution/thesaurus[name = $dv]/count)
  where not($dv = $pikithesauri)
  order by $sum descending
  return
    <thesaurus name="{$dv}">{$sum}
    </thesaurus>
}</saurusSummary>