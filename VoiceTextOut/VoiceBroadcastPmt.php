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
	$tsql = "SELECT DATENAME(MM, DueDate) + RIGHT(CONVERT(VARCHAR(12), DueDate, 107), 9) AS [Month DD, YYYY], Name, AmountDue, ID FROM Voice_PaymentReminder WHERE ID = $ID";
	
	$stmt = sqlsrv_query( $conn, $tsql);

	echo '<Response>';
    
	
	
	
	
	WHILE( $result = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_NUMERIC))  
	{   
      
			IF( "VoiceBroadcastPmt.php?ID=".urlencode('.$result[3].'))
			
			{
			echo '<Say voice="alice" language="en-GB">Hello, '.$result[1].'. You have a payment due on '.$result[0].', in the amount of $'.$result[2].'. 
			This payment may be made by telephone, at the office, through the website, or it may be mailed to our bank lock box at P O Box 8 6 5, Gadsden, Alabama 3 5 9 0 2.
			
			</Say>'; 
			}
			ELSE die;
	}   
	
	

	echo '</Response>';
		
		sqlsrv_free_stmt( $stmt);    
         sqlsrv_close( $conn);
	
?>