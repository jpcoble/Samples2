#!/usr/bin/php
<?php
$con = mysql_connect('localhost', 'XXX', 'XXX');
mysql_select_db("COBLE");

return mysql_query("CALL SuberDaterSP()");
mysql_close($con);

?>
