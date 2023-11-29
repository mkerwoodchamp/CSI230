$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://192.168.3.127/ToBeScraped.html

# $scraped_page.Links.Count

# $scraped_page.Links

# $scraped_page.Links | select outerText, href

# $h2s=$scraped_page.ParsedHtml.body.getElementsByTagName("h2") | select outerText
# $h2s

# $h2s=$scraped_page.ParsedHtml.body.getElementsByTagName("h2")

# for($i=0; $i -lt $h2s.length; $i++){
# $h2s[$i].getElementsByTagName("a") | select `
# @{Name="h2 element"; Expression={$i}}, outerText, href
# }

# $divs1=$scraped_page.ParsedHtml.body.getElementsByTagName("div") | where { `
# $_.getAttributeNode("class").Value -ilike "*div-1*"} | select innerText

# $divs1

$trs=$scraped_page.ParsedHtml.body.getElementsByTagName("tr")

$multirow = @()
for($i=1; $i -lt $trs.length; $i++){
$tds=$trs[$i].getElementsByTagName("td")

$singlerow = @(
@{Row=$i; Employee=$tds[0].outerText; Department=$tds[1].outerText; `
Salary=$tds[2].outerText}
)
$multirow += $singlerow
}
# $multirow

$sum=0
for($j=0; $j -lt $multirow.Length; $j++){
$sum += $multirow[$j].Salary
}
$avg=$sum/$multirow.Length
# $avg

$divs=$scraped_page.ParsedHtml.body.getElementsByTagName("div") | select id
$divs