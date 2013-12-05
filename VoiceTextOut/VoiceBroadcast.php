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
	$tsql = "SELECT DATENAME(MM, Date) + RIGHT(CONVERT(VARCHAR(12), Date, 107), 9) AS [Month DD, YYYY], LTRIM(RIGHT(CONVERT(VARCHAR(20), Time, 100), 7)), Name, Type, Location, Courtroom, ID FROM Voice_CourtReminder WHERE ID = $ID";
	
	$stmt = sqlsrv_query( $conn, $tsql);

	echo '<Response>';
    
	
	
	
	
	WHILE( $result = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_NUMERIC))  
	{   
      
			IF( "VoiceBroadcast.php?ID=".urlencode('.$result[6].'))
			
			{
			echo '<Say voice="alice" language="en-GB">Hello, '.$result[2].'. You have a '.$result[3].' hearing on '.$result[0].' at '.$result[1].' at the '.$result[4].' in '.$result[5].'.
			
			</Say>'; 
			}
			ELSE die;
	}   
	
	

	echo '</Response>';
		
		sqlsrv_free_stmt( $stmt);    
         sqlsrv_close( $conn);
	
?>