<?php
	
	require 'twilio-php-master/Services/Twilio.php';

	
	$version = "2010-04-01";

	
	$sid = 'XXX';
	$token = 'XXX';
	
		
	$client = new Services_Twilio($sid, $token, $version);

	$phonenumber = '205XXXXXXX';
	
	$serverName = "XXX";   
	$uid = "DB_9ABA01_voicetext_admin";     
	$pwd = "XXX";    
	$databaseName = "DB_9ABA01_voicetext";   
   
	$connectionInfo = array( "UID"=>$uid,                              
                         "PWD"=>$pwd,                              
                         "Database"=>$databaseName);   
    
	/* Connect using SQL Server Authentication. */    
	$conn = sqlsrv_connect( $serverName, $connectionInfo);
	
	$tsql = "SELECT ID, Number FROM Voice_CourtReminder";
	
	$stmt = sqlsrv_query( $conn, $tsql);
	
	WHILE( $result = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_NUMERIC))    
	{    
        			
	try {
		
		$call = $client->account->calls->create(
			$phonenumber, 
			$result[1], 
			$url = "http://voiceout.XXX.com/VoiceBroadcast.php?ID=".urlencode($result[0]) 
		);
		echo 'Started call: ' . $call->sid;
	} catch (Exception $e) {
		echo 'Error: ' . $e->getMessage();
		}
	}
		
?>