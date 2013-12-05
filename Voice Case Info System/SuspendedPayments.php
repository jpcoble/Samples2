<?php
	header('Content-type: text/xml');
	echo '<?xml version="1.0" encoding="UTF-8"?>';
	$serverName = "XXX";   
	$uid = "DB_9ABA01_coblelaw3_admin";     
	$pwd = "XXX";    
	$databaseName = "DB_9ABA01_coblelaw3";   
   
	$connectionInfo = array( "UID"=>$uid,                              
                         "PWD"=>$pwd,                              
                         "Database"=>$databaseName);   
    
	/* Connect using SQL Server Authentication. */    
	$conn = sqlsrv_connect( $serverName, $connectionInfo);   

	$CaseNumber = $_REQUEST['Digits'];	

	$tsql = "IF (SELECT DateSuspensionEnds FROM Cases WHERE CaseNumber = $CaseNumber) <> '1900-01-01 00:00:00.000' (SELECT CurrentlySuspended, DATENAME(MM, DateSuspensionEnds) + RIGHT(CONVERT(VARCHAR(12), DateSuspensionEnds, 107), 9) AS [Month DD, YYYY] FROM Cases WHERE CaseNumber=$CaseNumber)";
	
	    
    /* Execute the query. */  
			
    
    $stmt = sqlsrv_query( $conn, $tsql);
	
	echo '<Response>';
	 
	IF( $result = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_NUMERIC))    
	{    
      
	  
		
			echo '<Say voice="alice" language="en-GB">'.$result[0].', Your Chapter 13 Payments are currently suspended. 
			You must resume making payments to the Chapter 13 Trustee on, '.$result[1].' 
			
			</Say>'; 
	}    
	
	ELSE 
	{
		echo '<Say voice="alice" language="en-GB">Your case is not currently suspended.</Say>'; 
	}
	
		echo '</Response>';
		
		sqlsrv_free_stmt( $stmt);    
         sqlsrv_close( $conn);
?>