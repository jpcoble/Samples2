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

	
	  $tsql = "IF (SELECT FilingDate FROM Cases WHERE CaseNumber = $CaseNumber) <> '1900-01-01 00:00:00.000' (SELECT DATENAME(MM, C7FFInstallments.PmtDueDate1) + RIGHT(CONVERT(VARCHAR(12), C7FFInstallments.PmtDueDate1, 107), 9) AS [Month DD, YYYY], dbo.C7FFInstallments.HasPmt1BeenReceived, DATENAME(MM, C7FFInstallments.PmtDueDate2) + RIGHT(CONVERT(VARCHAR(12), C7FFInstallments.PmtDueDate2, 107), 9) AS [Month DD, YYYY], 
                         dbo.C7FFInstallments.HasPmt2BeenReceived, DATENAME(MM, C7FFInstallments.PmtDueDate3) + RIGHT(CONVERT(VARCHAR(12), C7FFInstallments.PmtDueDate3, 107), 9) AS [Month DD, YYYY], dbo.C7FFInstallments.HasPmt3BeenReceived, 
                         DATENAME(MM, C7FFInstallments.PmtDueDate4) + RIGHT(CONVERT(VARCHAR(12), C7FFInstallments.PmtDueDate4, 107), 9) AS [Month DD, YYYY], dbo.C7FFInstallments.HasPmt4BeenReceived
FROM            dbo.C7FFInstallments INNER JOIN
                         dbo.Cases ON dbo.C7FFInstallments.ClientID = dbo.Cases.ClientNumber
WHERE        (dbo.Cases.CaseNumber = $CaseNumber))";  
    /* Execute the query. */  
			
    
    $stmt = sqlsrv_query( $conn, $tsql);
	
	echo '<Response>';
	 
	IF( $result = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_NUMERIC))    
	{    
      
	  
		
			echo '<Say voice="alice" language="en-GB">Your first filing fee installment payment is due on '.$result[0].'. The answer as to whether it has been received is '.$result[1].'. 
			Your second filing fee installment payment is due on '.$result[2].'. The answer as to whether it has been received is '.$result[3].'.
			Your third filing fee installment payment is due on '.$result[4].'. The answer as to whether it has been received is '.$result[5].'.
			Your fourth filing fee installment payment is due on '.$result[6].'. The answer as to whether it has been received is '.$result[7].'.
			
			</Say>'; 
	}    
	
	ELSE 
	{
		echo '<Say voice="alice" language="en-GB">You have either entered an invalid case number, or your case has not yet been filed.</Say>'; 
	}
	
		echo '</Response>';
		
		sqlsrv_free_stmt( $stmt);    
         sqlsrv_close( $conn);
?>