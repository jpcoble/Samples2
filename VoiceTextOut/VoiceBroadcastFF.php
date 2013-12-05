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
	$tsql = "SELECT DATENAME(MM, DueDate) + RIGHT(CONVERT(VARCHAR(12), DueDate, 107), 9) AS [Month DD, YYYY], Name, AmountDue, ID FROM Voice_FFPmtReminder WHERE ID = $ID";
	
	$stmt = sqlsrv_query( $conn, $tsql);

	echo '<Response>';
    
	
	
	
	
	WHILE( $result = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_NUMERIC))  
	{   
      
			IF( "VoiceBroadcastFF.php?ID=".urlencode('.$result[3].'))
			
			{
			echo '<Say voice="alice" language="en-GB">Hello, '.$result[1].'. You have a filing payment due on '.$result[0].', in the amount of $'.$result[2].'. 
			This payment can NOT be made in the usual way. It has to be paid electronically by John. Therefore, this payment MUST be received three days
			before the due date. This payment can only go to the Bank Lock Box in Gadsden. The address is P O Box 8 6 5, Gadsden, Alabama 3 5 9 0 2. 
			This payment can only be made by money order or official bank check. It can not be made by personal check, debit card, credit card or cash.
			This payment can not be paid at the office.
			
			</Say>'; 
			}
			ELSE die;
	}   
	
	

	echo '</Response>';
		
		sqlsrv_free_stmt( $stmt);    
         sqlsrv_close( $conn);
	
?>