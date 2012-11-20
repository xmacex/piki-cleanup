(: all of the assigned ISILs which are not in use in any records :)
(: this is a non-practical question to ask, i'm just practicing the set opetations of XQuery :)

declare namespace srw="http://www.loc.gov/zing/srw/";
declare namespace mx="http://www.loc.gov/MARC21/slim";

let $pikiIsils := ("Fi-Akaa",
  "Fi-Hamkun",
  "Fi-Ikaal",
  "Fi-Juupa",
  "Fi-Kang",
  "FI-Kihni",
  "Fi-Kuhma",
  "Fi-Kylm",
  "Fi-Lemp",
  "Fi-Mavi",
  "Fi-Nokka",
  "Fi-Orive",
  "Fi-Palka",
  "FI-Parka",
  "Fi-Pirkka",
  "Fi-Punka",
  "FI-Ruove",
  "Fi-Sasta",
  "Fi-Takvi",
  "Fi-Tam",
  "Fi-Urja",
  "Fi-Valkka",
  "Fi-Vesil",
  "FI-Virta",
  "Fi-Ylo")

for $all in /records
let $allIsils := $all/record/srw:recordData/mx:record/mx:datafield[@tag="852"]/mx:subfield[@code="a"]/data()
(: nämä eivät ole käytössä :)
return distinct-values($pikiIsils[not(.=$allIsils)])