<?php
    require 'twilio-php-master/Services/Twilio.php';
 
    $AccountSid = "XXX";
    $AuthToken = "XXX";
 
    
    $client = new Services_Twilio($AccountSid, $AuthToken);
	
	header("content-type: text/xml");
    echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
	$serverName = "XXX";   
	$uid = "DB_9ABA01_coblelaw3_admin";     
	$pwd = "XXX";    
	$databaseName = "DB_9ABA01_coblelaw3";   
   
	$connectionInfo = array( "UID"=>$uid,                              
                         "PWD"=>$pwd,                              
                         "Database"=>$databaseName);   
    
	/* Connect using SQL Server Authentication. */    
	$conn = sqlsrv_connect( $serverName, $connectionInfo);
	
	$tsql = "SELECT Message, Number FROM VoiceOut WHERE ID = 1";
	
	$stmt = sqlsrv_query( $conn, $tsql);

	    
	IF( $result = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_NUMERIC)) 
	{
	
	$sms = $client->account->messages->sendMessage(
	
	"+1205XXXXXXX",
	"'.$result[1].'",
	"'.$result[0].'"
	);
		
	}
	
	
?>