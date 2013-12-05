<?php
include("LIB_parse.php");
include("LIB_http.php");
include("LIB_mysql.php");


#Get web-page - already downloaded by IOpus

$web_page = http_get($target="http://127.0.0.1/SuberBeer_files/frmlogin.html", $referer="");

#set up to get the right attorney info

$section = parse_array($web_page['FILE'], 'D001-Defendant', "mailto:", AFTER, EXCL);

function parse_page($string, $Page)
    {
    $Page = '/([Pp][Rr][Oo]\s[Ss][Ee])/';
    preg_match('/([Pp][Rr][Oo]\s[Ss][Ee])/', $string, $matching_data);
    return $matching_data[0];
    }

#Parse the 1st line of the Defendant, Address, Address2, City, State, Zip, CaseCaption, CaseNumber, DateOfLawsuit, Plaintiff, Amount, County from the downloaded page

$def = return_between($web_page['FILE'], "D001 - ", '</a>', EXCL);
$add1 = return_between($web_page['FILE'], '<td colspan="3" align="left"><span id="lblAddress1" class="ucLabelBold">', "</span>", EXCL);
$add2 = return_between($web_page['FILE'], '<td colspan="3" align="left"><span id="lblAddress2" class="ucLabelBold">', "</span>", EXCL);
$city = return_between($web_page['FILE'], '<td align="left"><span id="lblCity" class="ucLabel">', "</span>", EXCL);
$state = return_between($web_page['FILE'], '<span id="lblState" class="ucLabelBold">', "</span>", EXCL);
$zip = return_between($web_page['FILE'], '<span id="lblZip" class="ucLabelBold">', "</span>", EXCL);
$caption = return_between($web_page['FILE'], '<span id="ContentPlaceHolder1_CaseDetailTabs_TabAllCase_ctl01_lblStyle" class="ucLabelBoldHL">', "</span>", EXCL);
$date_ls = return_between($web_page['FILE'], '<span id="ContentPlaceHolder1_CaseDetailTabs_TabAllCase_ctl01_lblFilingDate" class="ucLabelBold">', "</span>", EXCL);
$amt = return_between($web_page['FILE'], '<span id="ContentPlaceHolder1_CaseDetailTabs_TabAllCase_ctl01_lblDamageAmount" class="ucLabelBold">', "</span>", EXCL);
$county = return_between($web_page['FILE'], '<span id="ContentPlaceHolder1_lblCounty" class="ucLabelBold" style="color:Brown;font-size:7pt;">', "</span>", EXCL);
$case_no = return_between($web_page['FILE'], '<span id="ContentPlaceHolder1_CaseDetailTabs_TabCase_ctl01_lblCaseNumber" class="ucLabelBold" style="color:Brown;background-color:White;">',  '</span>', EXCL);
#$plaintiff = return_between($web_page['FILE'], '"ctl00_ContentPlaceHolder1_lblStyle" class="ucLabelBoldHL" style="font-size:7pt;">', "V.", EXCL);
$case_type = return_between($web_page['FILE'], '<span id="ContentPlaceHolder1_CaseDetailTabs_TabCase_ctl01_lblCaseType" class="ucLabelBold" style="color:Brown;">', "</span>", EXCL);
$real_time = return_between($web_page['FILE'], '<img id="ctl00_ContentPlaceHolder1_lblNotice" title="', '" src="frmlogin_data/Delayed.gif" style="border-width: 0px;">', EXCL);
# Delayed.gif in place of realTime.jpg
$def_A = return_between($web_page['FILE'], '<span id="ContentPlaceHolder1_CaseDetailTabs_TabAllCase_ctl03_lblIndex" class="ucLabelBold">', "</span>", EXCL);




echo "$def\n";
echo "$add1\n";
echo "$add2\n";
echo "$city\n";
echo "$state\n";
echo "$zip\n";
echo "$caption\n";
echo "$date_ls\n";
echo "$amt\n";
echo "$county\n";
echo "$case_no\n";
#echo "$plaintiff\n"; should remain commented
echo "$case_type\n";
echo "$real_time\n";
#echo "$def_A\n"; - should remain commented
#echo "$attorney\n";
for($yy=0; $yy<count($section); $yy++)
     {

$attorney = parse_page($section[$yy], '/([Pp][Rr][Oo]\s[Ss][Ee])/');



echo $attorney, "\n";
}

if(strlen($def_A) > 120)
{
include("phpmail3.php");
}


if($real_time != "OFF LINE" and (strlen($def_A)) < 120)

{
# Insert into MySql
$data_array['Defendant'] = $def;
$data_array['Address'] = $add1;
$data_array['Address2'] = $add2;
$data_array['City'] = $city;
$data_array['State'] = $state;
$data_array['Zip'] = $zip;
$data_array['CaseCaption'] = $caption;
$data_array['LawsuitDate'] = $date_ls;
$data_array['Amount'] = $amt;
$data_array['County'] = $county;
$data_array['CaseNumber'] = $case_no;
#$data_array['Plaintiff'] = $plaintiff; xxxxxx this one should remain commented
$data_array['CaseType'] = $case_type;
$data_array['Attorney'] = $attorney;



insert(DATABASE, $table="AlaCourtSuberMulti", $data_array); 
}

?>
