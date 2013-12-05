@!/usr/bin/php
<?php
shell_exec("gnome-terminal -x firefox"); # Starts firefox in a paralell thread
sleep(15);
shell_exec("php /var/www/SuberDateDeleter.php"); # Deletes the Dater.CSV from the mysql folder
sleep(10);
shell_exec("php /var/www/SuberDaterSP.php"); # Outputs the Dates from the Date table into a CSV file
sleep(10);
shell_exec("php /var/www/SuberCopier.php"); # Copies Dater.CSV to IMacros datasources folder
sleep(10);
shell_exec("php /var/www/SuberHotsheets.php"); # Runs the Hotsheet Scraper
sleep(420); // was set at 1500
shell_exec("killall php"); #kills all PHP processes

?>
