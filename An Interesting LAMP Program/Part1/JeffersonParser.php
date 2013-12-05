<?php
include("LIB_parse.php");
include("LIB_http.php");
include("LIB_mysql.php");

# Get web-page - already downloaded by IOpus

$web_page = http_get($target="http://127.0.0.1/SuberHotsheet_files/frmlogin_data/frmHotSheetList.html", $referer="");

# Parse the District Court Case Numbers

$dv = parse_array($web_page['FILE'], "DV-2013-", "\.", AFTER, INCL);

# Remove the markers from the output

$dv = str_replace("DV-2013-", "", $dv);
$dv = str_replace(".", "", $dv);

# Get the District Court Code and remove markers from output

$ctcode = parse_array($web_page['FILE'], "DV-2013", "\-", AFTER, INCL);
$ctcode = str_replace("\-......\.", "", $ctcode);
$ctcode = str_replace("DV-2013-", "DV", $ctcode);

# Loop until all District Court Case Numbers are parsed and trimmed

for($xx=0; $xx<count($dv); $xx++)
{
echo $dv[$xx]."\n";
echo $ctcode[$xx]."\n";
echo '01',"\n";

# Put Parsed and Trimmed Output into MySql
$data_array['CaseNo2'] = $dv[$xx];
$data_array['CourtCode'] = $ctcode[$xx];
$data_array['CountyCode'] = '01';
insert(DATABASE, $table="SuberBeer", $data_array); 
}

# Parse the Circuit Court Case Numbers

$cv = parse_array($web_page['FILE'], "CV-2013-", "\.", AFTER, INCL);

# Remove the markers from the output

$cv = str_replace("CV-2013-", "", $cv);
$cv = str_replace(".", "", $cv);

# Get the Circuit Court Code and remove markers from output

$ctcode2 = parse_array($web_page['FILE'], "CV-2013", "\-", AFTER, INCL);
$ctcode2 = str_replace("\-......\.", "", $ctcode2);
$ctcode2 = str_replace("CV-2013-", "CV", $ctcode2);

# Loop until all Circuit Court Case Numbers are parsed and trimmed

for($yy=0; $yy<count($ctcode2); $yy++)
{
echo $cv[$yy]."\n";
echo $ctcode2[$yy]."\n";
echo '01',"\n";
# Put Parsed and Trimmed Output into MySql
$data_array2['CaseNo2'] = $cv[$yy];
$data_array2['CourtCode'] = $ctcode2[$yy];
$data_array2['CountyCode'] = '01';
insert(DATABASE, $table="SuberBeer", $data_array2); 
}

# Parse the Small Claims Court Case Numbers

$sm = parse_array($web_page['FILE'], "SM-2013-", "\.", AFTER, INCL);

# Remove the markers from the output

$sm = str_replace("SM-2013-", "", $sm);
$sm = str_replace(".", "", $sm);

# Get the Circuit Court Code and remove markers from output

$ctcode3 = parse_array($web_page['FILE'], "SM-2013", "\-", AFTER, INCL);
$ctcode3 = str_replace("\-......\.", "", $ctcode3);
$ctcode3 = str_replace("SM-2013-", "SM", $ctcode3);

# Loop until all Small Claims Court Case Numbers are parsed and trimmed

for($zz=0; $zz<count($ctcode3); $zz++)
{
echo $sm[$zz]."\n";
echo $ctcode3[$zz]."\n";
echo '01',"\n";
# Put Parsed and Trimmed Output into MySql
$data_array3['CaseNo2'] = $sm[$zz];
$data_array3['CourtCode'] = $ctcode3[$zz];
$data_array3['CountyCode'] = '01';
insert(DATABASE, $table="SuberBeer", $data_array3); 
}


?>

