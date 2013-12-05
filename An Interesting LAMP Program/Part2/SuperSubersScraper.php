@!/usr/bin/php
<?php
$con = mysql_connect('localhost', 'XXX', 'XXX');
mysql_select_db("COBLE", $con);
$result = mysql_query("SELECT SecondsForPHP FROM NumberToPutInJS WHERE ID=1");
shell_exec("gnome-terminal -x firefox"); # Starts firefox in a paralell thread
sleep(15);
shell_exec("php /var/www/SuberBeerSP.php"); # Outputs the Beer Table to a CSV file
sleep(10); 
shell_exec("php /var/www/SuberBeerCopier.php"); # moves the CSV file to datasources for IMacros
sleep(10); 
shell_exec("php /var/www/IDCounterSP.php"); # determines the sleep time needed after the main scraper below - to randomize to slip through bot detection
sleep(20); 
shell_exec("php /var/www/SuberScraper.php");
while($row = mysql_fetch_array($result))
{
sleep ($row['SecondsForPHP']);
}
mysql_close($con);

shell_exec("php /var/www/SuberAlaCourtOutputSP.php"); #Outputs the Scraper to an Excel file
sleep(10); 
shell_exec("php /var/www/SuberAlaCourtOutputCopier.php"); # Moves the Output Excel file to Scraper_Downloads
sleep(10);
shell_exec("php /var/www/PHPMailFinished.php"); #Send an e-mail when the scraper is finished
sleep(10);
shell_exec("killall php"); #kills all PHP processes

?>
