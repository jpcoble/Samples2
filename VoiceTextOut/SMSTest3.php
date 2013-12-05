<?php
    require 'twilio-php-master/Services/Twilio.php';
 
    $AccountSid = "XXX";
    $AuthToken = "XXX";
 
    
    $client = new Services_Twilio($AccountSid, $AuthToken);
	
	
	$serverName = "XXX";   
	$uid = "DB_9ABA01_voicetext_admin";     
	$pwd = "XXX";    
	$databaseName = "DB_9ABA01_voicetext";   
   
	$connectionInfo = array( "UID"=>$uid,                              
                         "PWD"=>$pwd,                              
                         "Database"=>$databaseName);   
    
	/* Connect using SQL Server Authentication. */    
	$conn = sqlsrv_connect( $serverName, $connectionInfo);
	
	$tsql = "SELECT Message, Number, Name FROM TextOut WHERE ID = 1";
	
	$stmt = sqlsrv_query( $conn, $tsql);

	    
	IF( $result = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_NUMERIC)) 
	{
	$people = array("'.$result[1].'" => "'.$result[2].'");
		foreach ($people as $number => $name) {
			$sms = $client->account->messages->sendMessage(
	
				"+1205XXXXXXX",
				$number,
				"'.$result[0].'"
			);
			
			echo "Sent message to $name";
		};
	}
	sqlsrv_free_stmt( $stmt);    
    sqlsrv_close( $conn);
	
	
?>