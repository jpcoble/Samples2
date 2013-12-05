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

	
	 $tsql = "SELECT     TOP (100) PERCENT DATENAME(MM, AdditionalHearingDate) + RIGHT(CONVERT(VARCHAR(12), AdditionalHearingDate, 107), 9) AS [Month DD, YYYY], LTRIM(RIGHT(CONVERT(VARCHAR(20), AdditionalHearingTime, 100), 7)), dbo.AdditionalHearings.AdditionalHearingType, 
                      dbo.AdditionalHearings.AdditionalHearingLocation, dbo.AdditionalHearings.AdditionalHearingRoomNumber, dbo.AdditionalHearings.ClientPresent
FROM         dbo.AdditionalHearings INNER JOIN
                      dbo.Cases ON dbo.AdditionalHearings.ClientID = dbo.Cases.ClientNumber
WHERE     (dbo.AdditionalHearings.AdditionalHearingDate >= GETDATE()) AND (dbo.Cases.CaseNumber = $CaseNumber)
ORDER BY dbo.AdditionalHearings.AdditionalHearingDate";   
    /* Execute the query. */  
			
    
    $stmt = sqlsrv_query( $conn, $tsql);
	
	echo '<Response>';
	 
	WHILE( $result = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_NUMERIC))    
	{    
      
	  
		
			echo '<Say voice="alice" language="en-GB">You have a '.$result[2].' hearing on '.$result[0].', at '.$result[1].', at the '.$result[3].', in '.$result[4].'.
			The answer to whether you need to be present at this hearing is '.$result[5].'. 
			</Say>'; 
	}    
	
	
	
		echo '</Response>';
		
		sqlsrv_free_stmt( $stmt);    
         sqlsrv_close( $conn);
?>