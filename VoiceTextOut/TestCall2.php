<?php
    header("content-type: text/xml");
    echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
	$serverName = "XXX";   
	$uid = "DB_9ABA01_voicetext_admin";     
	$pwd = "XXX";    
	$databaseName = "DB_9ABA01_voicetext";   
   
	$connectionInfo = array( "UID"=>$uid,                              
                         "PWD"=>$pwd,                              
                         "Database"=>$databaseName);   
    
	/* Connect using SQL Server Authentication. */    
	$conn = sqlsrv_connect( $serverName, $connectionInfo);
	
	$tsql = "SELECT Message FROM VoiceOut WHERE ID = 1";
	
	$stmt = sqlsrv_query( $conn, $tsql);

	echo '<Response>';
    
	IF( $result = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_NUMERIC))  
	{    
      
	  
		
			echo '<Say voice="alice" language="en-GB">Hello, '.$result[0].'.
			
			</Say>'; 
	}   

	echo '</Response>';
		
		sqlsrv_free_stmt( $stmt);    
         sqlsrv_close( $conn);
	
?>