(: Summarize the results of reportIllegalLangCodesOf008.xq :)

declare variable $input := fn:doc('piki/reportIllegalLangCodesOf008.xml');

<illegalLangCodes totalCount = "{count($input/langCodesOf008/langCodesPerResource/illegalLangCodeIn008)}">{
	for $l in distinct-values($input/langCodesOf008/langCodesPerResource/illegalLangCodeIn008)
		let $count := count($input/langCodesOf008/langCodesPerResource/illegalLangCodeIn008[. = $l])
	  order by $count descending
	  return
	    <illegalLang
	      count ="{$count}">
	      {$l}
	    </illegalLang>
}</illegalLangCodes>