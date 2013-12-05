<?php
    header('Content-type: text/xml');
    echo '<?xml version="1.0" encoding="UTF-8"?>';
 
    echo '<Response>';
 
    # @start snippet
    $user_pushed = (int) $_REQUEST['Digits'];
    # @end snippet
 
    if ($user_pushed == 1)
    {
        echo '<Say voice="alice" language="en-GB">In a Chapter 7 Straight Bankruptcy, your non-exempt assets are sold by the Chapter 7 Trustee in order to liquidate your debts. The great thing is that only about 1 out of 100 Chapter 7 Bankruptcies has any non exempt assets. Therefore, you lose debt, but none of your property. Some debts are not discharged in Chapter 7 Bankruptcies For example most student loans, some taxes, and child support. In a Chapter 7, if you want to keep the collateral, you must continue to pay for your secured debts. For example, if you have a car loan and you want to keep the car, you must continue to pay for it.

Another Procedure used in the bankruptcy court is a Chapter 13 Debt Consolidation. In a Chapter 13 debt consolidation, you make a monthly payment to the Chapter 13 trustee for the elimination of all your debts. Depending on your circumstances, the trustee may pay nothing to the unsecured creditors (such as credit cards and medical bills), yet still completely eliminate those debts. A Chapter 13 can be useful if you are behind on your car payment or mortgage payment, if you have a high interest rate on your car, if you have debts that are not dischargeable in a Chapter 7 or if you would lose property in a Chapter 7. The monthly payment in a Chapter 13 debt consolidation can often be less than your car payment and at the same time include your car payment. 

A determination of which type of procedure is best to recommend for you as well as what the benefits will be for you can only be determined after your free initial consultation. If you would like a call from a licensed attorney to discuss your situation, please leave a message telling us the best time to call you and you will be contacted by an attorney within 24 hours. We look forward to helping you STOP your creditors! 

For more information, please go to stopyourcreditors.net on the internet or call us at 8 5 5 3 9 9 D E B T that’s 8 5 5 3 9 9 3 3 2 8 toll free or call 2 0 5 6 9 0 4 8 6 6 for an appointment.
</Say>';
    }
	ELSE IF ($user_pushed == 2)
	{
		echo '<Say voice="alice" language="en-GB">If you file for bankruptcy, any pending foreclosure sale is immediately STOPPED. In most cases, you can keep your house. If you are behind on your mortgage payments, a bankruptcy can be used to spread the time to catch up the amount you are behind on your mortgage up to 60 months. Furthermore, in some cases, second mortgages can be eliminated in bankruptcy.</Say>';
	}
	ELSE IF ($user_pushed == 3)
	{
		echo '<Say voice="alice" language="en-GB">If you file your bankruptcy before a car is repossessed, the company that repossessed the car MUST return it to you. A car can be paid for through a bankruptcy. In some cases, you may only have to pay the value of the car as opposed to the loan balance if the loan balance is more than the value of the car. In most cases, the interest rate can be significantly reduced. Furthermore, the time to pay off the balance on the car can be spread over five years if needed in order to reduce your monthly payments. This is even if you have only a couple of years left to pay.</Say>';
	}
	ELSE IF ($user_pushed == 4)
	{
		echo '<Say voice="alice" language="en-GB">When you file for Bankruptcy, lawsuits and garnishments filed for the purpose of attempting to collect a debt MUST stop. This is due to the fact that collection activity must STOP when you file for bankruptcy.</Say>';
	}
	ELSE IF ($user_pushed == 5)
	{
		echo '<Say voice="alice" language="en-GB">When you file for Bankruptcy, collection activity MUST stop, INCLUDING collection phone calls. If a creditor continues to call you after the filing of bankruptcy, they could be forced to pay money to you for having made the calls.</Say>';
	}
	ELSE IF ($user_pushed == 6)
	{
		echo '<Say voice="alice" language="en-GB">In a bankruptcy, some taxes may actually be eliminated without payment. Other taxes may be paid through a repayment plan and it is possible that those taxes may be paid instead of other debts that would normally be paid for in a repayment plan, while at the same time, those other debts are eliminated. </Say>';
	}
	ELSE IF ($user_pushed == 7)
	{
		echo '<Say voice="alice" language="en-GB">In a bankruptcy, back child support can not be eliminated, but can be paid through a repayment plan and it is possible that the back child support may be paid instead of other debts that would normally be paid for in a repayment plan, while at the same time, those other debts are eliminated.</Say>';
		
	}
	ELSE IF ($user_pushed == 8)
	{
	    echo '<Say voice="alice" language="en-GB">Please hold while you are being connected</Say>';
		echo '<Dial>+1205XXXXXXX</Dial>';
	}
	ELSE IF ($user_pushed == 9)
	{
	    echo '<Redirect method="GET">handle-incoming-call.xml</Redirect>';
		
	}
	
	
	
	
    else {
        // We'll implement the rest of the functionality in the 
        // following sections.
        echo "<Say>Sorry, I can't do that yet.</Say>";
        echo '<Redirect>handle-incoming-call.xml</Redirect>';
    }
 
    echo '</Response>';
?>