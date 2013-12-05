USE [BKTest]
GO
/****** Object:  UserDefinedFunction [dbo].[CalculatePmt]    Script Date: 12/03/2013 17:39:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[CalculatePmt]
(@ClientID int, @LoanBalance Numeric(18,0), @TermLeftForPayments Numeric(18,0), 
@InterestRate Numeric(18,6))
RETURNS Numeric(18,2)

AS

BEGIN
DECLARE @result Numeric(18,2)
SELECT @result = (TermLeftForPayments*(LoanBalance*((InterestRate/12)*(SELECT POWER(1+(InterestRate/12),TermLeftForPayments)))
/((SELECT POWER((1+(InterestRate/12)),TermLeftForPayments))-1))/60)
FROM SecuredDebtCalculator, BKClients
WHERE BKClients.ClientID=SecuredDebtCalculator.ClientID and 
@ClientID=SecuredDebtCalculator.ClientID and @LoanBalance=SecuredDebtCalculator.LoanBalance
and @TermLeftForPayments=SecuredDebtCalculator.TermLeftForPayments and @InterestRate=SecuredDebtCalculator.InterestRate 

GROUP BY BKClients.ClientID, SecuredDebtCalculator.LoanBalance, SecuredDebtCalculator.TermLeftForPayments, SecuredDebtCalculator.InterestRate 
ORDER BY BKClients.ClientID, SecuredDebtCalculator.LoanBalance, SecuredDebtCalculator.TermLeftForPayments, SecuredDebtCalculator.InterestRate 

RETURN @result

END