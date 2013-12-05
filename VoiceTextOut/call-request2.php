<?php
	// Include the Twilio PHP library
	require 'twilio-php-master/Services/Twilio.php';

	// Twilio REST API version
	$version = "2010-04-01";

	// Set our Account SID and AuthToken
	$sid = 'XXX';
	$token = 'XXX';
	
	// A phone number you have previously validated with Twilio
	$phonenumber = '2056831005';
	
	// Instantiate a new Twilio Rest Client
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
	
	$tsql = "SELECT Number FROM VoiceOut WHERE ID = 1";
	
	$stmt = sqlsrv_query( $conn, $tsql);
	
	IF( $result = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_NUMERIC))    
	{    
        			
	try {
		// Initiate a new outbound call
		$call = $client->account->calls->create(
			$phonenumber, // The number of the phone initiating the call
			$result[0], // The number of the phone receiving call
			'http://voiceout.XXX.com/TestCall2.php' // The URL Twilio will request when the call is answered
		);
		echo 'Started call: ' . $call->sid;
	} catch (Exception $e) {
		echo 'Error: ' . $e->getMessage();
		}
	}
		
?>