<?php
	header('Content-type: text/xml');
	echo '<?xml version="1.0" encoding="UTF-8"?>';

	echo '<Response>';

	$user_pushed = (int) $_REQUEST['Digits'];

	if ($user_pushed == 1)
	{
		echo '<Gather action="MainClient.php" numDigits="7">'; //note just using clientid here, so one digit
		echo '<Say voice="alice" language="en-GB">Please enter your 7 digit case number</Say>';
		echo '</Gather>';
	}
	
	else if ($user_pushed == 2 )
	{
		echo '<Gather action="CreditorsMeeting.php" numDigits="7">'; //note just using clientid here, so one digit
		echo '<Say voice="alice" language="en-GB">Please enter your 7 digit case number</Say>';
		echo '</Gather>';
	}
	
	else if ($user_pushed == 3 )
	{
		echo '<Gather action="Confirmations.php" numDigits="7">'; //note just using clientid here, so one digit
		echo '<Say voice="alice" language="en-GB">Please enter your 7 digit case number</Say>';
		echo '</Gather>';
	}
	
	else if ($user_pushed == 4 )
	{
		echo '<Gather action="ActualConfirmationDate.php" numDigits="7">'; //note just using clientid here, so one digit
		echo '<Say voice="alice" language="en-GB">Please enter your 7 digit case number</Say>';
		echo '</Gather>';
	}
	
	else if ($user_pushed == 5 )
	{
		echo '<Gather action="AdditionalHearings.php" numDigits="7">'; //note just using clientid here, so one digit
		echo '<Say voice="alice" language="en-GB">Please enter your 7 digit case number</Say>';
		echo '</Gather>';
	}
	
	else if ($user_pushed == 6 )
	{
		echo '<Gather action="FilingFeeInstallments.php" numDigits="7">'; //note just using clientid here, so one digit
		echo '<Say voice="alice" language="en-GB">Please enter your 7 digit case number</Say>';
		echo '</Gather>';
	}
	
	else if ($user_pushed == 7 )
	{
		echo '<Gather action="C13PlanPmts.php" numDigits="7">'; //note just using clientid here, so one digit
		echo '<Say voice="alice" language="en-GB">Please enter your 7 digit case number</Say>';
		echo '</Gather>';
	}
	
	else if ($user_pushed == 8 )
	{
		echo '<Gather action="SuspendedPayments.php" numDigits="7">'; //note just using clientid here, so one digit
		echo '<Say voice="alice" language="en-GB">Please enter your 7 digit case number</Say>';
		echo '</Gather>';
	}
	
	
	
	
	else {
		echo "<Say>Sorry, that isn't a valid menu option.</Say>";
		
	}

	echo '</Response>';
?>