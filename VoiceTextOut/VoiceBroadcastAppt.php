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
	$ID = $_GET['ID'];
	$tsql = "IF (SELECT ApptTime FROM Voice_ApptReminder WHERE ID = $ID) <> '1900-01-01 00:00:00.000' (SELECT DATENAME(MM, ApptDate) + RIGHT(CONVERT(VARCHAR(12), ApptDate, 107), 9) AS [Month DD, YYYY], LTRIM(RIGHT(CONVERT(VARCHAR(20), ApptTime, 100), 7)), Name, ApptPurpose, ID FROM Voice_ApptReminder WHERE ID = $ID) ELSE (SELECT DATENAME(MM, ApptDate) + RIGHT(CONVERT(VARCHAR(12), ApptDate, 107), 9) AS [Month DD, YYYY], AltApptTime, Name, ApptPurpose, ID FROM Voice_ApptReminder WHERE ID = $ID)";
	
	$stmt = sqlsrv_query( $conn, $tsql);

	echo '<Response>';
    
	
	
	
	
	WHILE( $result = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_NUMERIC))  
	{   
      
			IF( "VoiceBroadcastAppt.php?ID=".urlencode('.$result[4].'))
			
			{
			echo '<Say voice="alice" language="en-GB">Hello, '.$result[2].'. You have an appointment on '.$result[0].' at '.$result[1].'. The purpose of this appointment is to '.$result[3].'.
			
			</Say>'; 
			}
			ELSE die;
	}   
	
	

	echo '</Response>';
		
		sqlsrv_free_stmt( $stmt);    
         sqlsrv_close( $conn);
	
?>