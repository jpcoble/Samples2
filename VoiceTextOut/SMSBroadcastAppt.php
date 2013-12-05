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
	
	$tsql = "SELECT Message, Cell, Name FROM Text_ApptReminder";
	
	$stmt = sqlsrv_query( $conn, $tsql);
	   
	WHILE( $result = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_NUMERIC))  
	{
	
	
	$message = $result[0];
	$number = $result[1];
	$name = $result[2];	
		
	$people = array("'.$result[1].'" => "'.$result[2].'");		
		foreach ($people as $number => $name) {
			
				
				$sms = $client->account->messages->sendMessage(
	
					"+1205XXXXXXX",
					$number,
					$message
					);
				
			
			
			echo "Sent message to $name   ";
		}
	
	//}
	};
	sqlsrv_free_stmt( $stmt);    
    sqlsrv_close( $conn);
	
	
?>