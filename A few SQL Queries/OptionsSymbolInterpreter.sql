/****** Object:  StoredProcedure [dbo].[OptionsChainInserterUpdater]    Script Date: 1/18/2019 4:40:18 PM ******/

/*
WHEN THE CBOE CHANGED THE FORMAT OF ITS DATA FOR DOWNLOAD A FEW MONTHS AGO, IT CHANGED HOW I HAD TO DISSECT THE SYMBOL 
TO GLEAM INFORMATION FROM IT.
I COMMENTED OUT THE UNNEEDED SECTIONS, BUT NOW I CAN'T REMEMBER WHY SOME OF THEM WERE THERE. THIS IS AN ATTEMPT TO SHOW
A SQL STORED PROCEDURE TO HANDLE COMPLEX STRING OPERATIONS

*/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[OptionsChainInserterUpdater] 

AS

BEGIN


DELETE FROM OptionsChains;

DELETE FROM OptionsChainImport WHERE Calls IS NULL;


UPDATE OptionsChainImport
SET Calls = (SELECT CONCAT(Calls,'-E)')); -- I can't remember why this was here


--GETS THE OPTIONS SYMBOL OUT OF THE PARENTHESIS, PRICING INFO, VOLUME, OPEN INTEREST:
INSERT INTO OptionsChains(ExpirationDate, CallSymbol, CallLastSale, CallBid, CallAsk, CallVol, 
CallOpenInterest, ExercisePrice,
PutSymbol, PutLastSale, PutBid, PutAsk, PutVol, 
PutOpenInterest, QuoteDate)
SELECT ExpirationDate, Calls,
SUBSTRING(Calls,CHARINDEX('(',Calls)+1 ,CHARINDEX(')',Calls)-CHARINDEX('(',Calls)-1),
CallLastSale, CallBid, CallAsk, CallVol, CallOpenInterest, ExercisePrice,
SUBSTRING(Puts,CHARINDEX('(',Puts)+1 ,CHARINDEX(')',Puts)-CHARINDEX('(',Puts)-1),
Puts, PutLastSale, PutBid, PutAsk, PutVol, 
PutOpenInterest, DateModified
FROM OptionsChainImport;



UPDATE OptionsChains
SET PutSymbol = REPLACE(PutSymbol, '-E', ' '), 
CallSymbol = REPLACE(CallSymbol, '-E', ' ');



-- GETS 3 LETTER & 4 LETTER STOCK SYMBOLS

-- NEED TO CHANGE THIS TO 2 LETTER, 3 LETTER AND 4 LETTER TOMORROW

-- THIS DOES GET 2, 3 AND 4 LETTER SYMBOLS


UPDATE OptionsChains
SET CallStockSymbol = CASE WHEN(ISNUMERIC(SUBSTRING(CallSymbol,3,1))) = 1 THEN LEFT(CallSymbol,2)
WHEN(ISNUMERIC(SUBSTRING(CallSymbol,4,1))) = 1 THEN LEFT(CallSymbol,3)
WHEN(ISNUMERIC(SUBSTRING(CallSymbol,5,1))) = 1 THEN LEFT(CallSymbol,4) END,
PutStockSymbol = CASE WHEN(ISNUMERIC(SUBSTRING(PutSymbol,3,1))) = 1 THEN LEFT(PutSymbol,2) 
WHEN(ISNUMERIC(SUBSTRING(PutSymbol,4,1))) = 1 THEN LEFT(PutSymbol,3)
WHEN(ISNUMERIC(SUBSTRING(PutSymbol,5,1))) = 1 THEN LEFT(PutSymbol,4) END;


EXEC BadOptionsChainEjector;

-- GETS THE EXERCISE PRICE

 

/* WOULD NEED TO STOP RIGHT HERE WITH NEW SYSTEM IF WE DECIDE TO GO WITH GETTING THE STRIKE PRICE AND DATE
FROM THE GIVEN IN THE NEW CBOE DOWNLOAD
*/



UPDATE OptionsChains
SET CallExpYear = (SELECT (CASE WHEN(ISNUMERIC(SUBSTRING(CallSymbol,3,1))) = 1 
AND (ISNUMERIC(SUBSTRING(CallSymbol,2,1))) = 0 THEN
(SUBSTRING(CallSymbol, 3, 2)) 
WHEN(ISNUMERIC(SUBSTRING(CallSymbol,4,1))) = 1 
AND (ISNUMERIC(SUBSTRING(CallSymbol,3,1))) = 0 THEN
(SUBSTRING(CallSymbol, 4, 2))
WHEN(ISNUMERIC(SUBSTRING(CallSymbol,5,1))) = 1 
AND (ISNUMERIC(SUBSTRING(CallSymbol,4,1))) = 0 THEN
(SUBSTRING(CallSymbol, 5, 2)) END)),
CallExpDay =
(SELECT (CASE WHEN(ISNUMERIC(SUBSTRING(CallSymbol,3,1))) = 1 
AND (ISNUMERIC(SUBSTRING(CallSymbol,2,1))) = 0
THEN (SUBSTRING(CallSymbol, 5, 2)) 
WHEN(ISNUMERIC(SUBSTRING(CallSymbol,4,1))) = 1 
AND (ISNUMERIC(SUBSTRING(CallSymbol,3,1))) = 0
THEN (SUBSTRING(CallSymbol, 6, 2))  
WHEN(ISNUMERIC(SUBSTRING(CallSymbol,5,1))) = 1 
AND (ISNUMERIC(SUBSTRING(CallSymbol,4,1))) = 0
THEN (SUBSTRING(CallSymbol, 7, 2)) ELSE 0 END)),
CallExpirationMonthLetter = (SELECT (CASE WHEN(ISNUMERIC(SUBSTRING(CallSymbol,3,1))) = 1
AND (ISNUMERIC(SUBSTRING(CallSymbol,2,1))) = 0
THEN (SUBSTRING(CallSymbol, 7, 1)) 
WHEN(ISNUMERIC(SUBSTRING(CallSymbol,4,1))) = 1
AND (ISNUMERIC(SUBSTRING(CallSymbol,3,1))) = 0
THEN (SUBSTRING(CallSymbol, 8, 1)) 
WHEN(ISNUMERIC(SUBSTRING(CallSymbol,5,1))) = 1
AND (ISNUMERIC(SUBSTRING(CallSymbol,4,1))) = 0
THEN (SUBSTRING(CallSymbol, 9, 1)) END)),
PutExpYear = (SELECT (CASE WHEN(ISNUMERIC(SUBSTRING(PutSymbol,3,1))) = 1 
AND (ISNUMERIC(SUBSTRING(PutSymbol,2,1))) = 0 THEN
(SUBSTRING(PutSymbol, 3, 2)) 
WHEN(ISNUMERIC(SUBSTRING(PutSymbol,4,1))) = 1 
AND (ISNUMERIC(SUBSTRING(PutSymbol,3,1))) = 0 THEN
(SUBSTRING(PutSymbol, 4, 2))
WHEN(ISNUMERIC(SUBSTRING(PutSymbol,5,1))) = 1 
AND (ISNUMERIC(SUBSTRING(PutSymbol,4,1))) = 0 THEN
(SUBSTRING(PutSymbol, 5, 2)) END)),
PutExpDay =
(SELECT (CASE WHEN(ISNUMERIC(SUBSTRING(PutSymbol,3,1))) = 1 
AND (ISNUMERIC(SUBSTRING(PutSymbol,2,1))) = 0
THEN (SUBSTRING(PutSymbol, 5, 2)) 
WHEN(ISNUMERIC(SUBSTRING(PutSymbol,4,1))) = 1 
AND (ISNUMERIC(SUBSTRING(PutSymbol,3,1))) = 0
THEN (SUBSTRING(PutSymbol, 6, 2))  
WHEN(ISNUMERIC(SUBSTRING(PutSymbol,5,1))) = 1 
AND (ISNUMERIC(SUBSTRING(PutSymbol,4,1))) = 0
THEN (SUBSTRING(PutSymbol, 7, 2)) ELSE 0 END)),
PutExpirationMonthLetter = (SELECT (CASE WHEN(ISNUMERIC(SUBSTRING(PutSymbol,3,1))) = 1
AND (ISNUMERIC(SUBSTRING(PutSymbol,2,1))) = 0
THEN (SUBSTRING(PutSymbol, 7, 1)) 
WHEN(ISNUMERIC(SUBSTRING(PutSymbol,4,1))) = 1
AND (ISNUMERIC(SUBSTRING(PutSymbol,3,1))) = 0
THEN (SUBSTRING(PutSymbol, 8, 1)) 
WHEN(ISNUMERIC(SUBSTRING(PutSymbol,5,1))) = 1
AND (ISNUMERIC(SUBSTRING(PutSymbol,4,1))) = 0
THEN (SUBSTRING(PutSymbol, 9, 1)) END));



-- GETS STOCK SYMBOLS OPTIONS EXPIRATION MONTHS FOR CALLS ONLY

UPDATE OptionsChains
SET CallExpirationMonth = (SELECT (CASE WHEN (ISNUMERIC(SUBSTRING(CallSymbol,4,1)) <> 1) 
THEN (CASE WHEN CallExpirationMonthLetter = 'A' THEN 01
WHEN CallExpirationMonthLetter = 'B' THEN 02
WHEN CallExpirationMonthLetter = 'C' THEN 03
WHEN CallExpirationMonthLetter = 'D' THEN 04
WHEN CallExpirationMonthLetter = 'E' THEN 05
WHEN CallExpirationMonthLetter = 'F' THEN 06
WHEN CallExpirationMonthLetter = 'G' THEN 07
WHEN CallExpirationMonthLetter = 'H' THEN 08
WHEN CallExpirationMonthLetter = 'I' THEN 09
WHEN CallExpirationMonthLetter = 'J' THEN 10
WHEN CallExpirationMonthLetter = 'K' THEN 11
WHEN CallExpirationMonthLetter = 'L' THEN 12 END) 
ELSE
(CASE WHEN CallExpirationMonthLetter = 'A' THEN 01
WHEN CallExpirationMonthLetter = 'B' THEN 02
WHEN CallExpirationMonthLetter = 'C' THEN 03
WHEN CallExpirationMonthLetter = 'D' THEN 04
WHEN CallExpirationMonthLetter = 'E' THEN 05
WHEN CallExpirationMonthLetter = 'F' THEN 06
WHEN CallExpirationMonthLetter = 'G' THEN 07
WHEN CallExpirationMonthLetter = 'H' THEN 08
WHEN CallExpirationMonthLetter = 'I' THEN 09
WHEN CallExpirationMonthLetter = 'J' THEN 10
WHEN CallExpirationMonthLetter = 'K' THEN 11
WHEN CallExpirationMonthLetter = 'L' THEN 12
END) END)), 
PutExpirationMonth = (SELECT (CASE WHEN (ISNUMERIC(SUBSTRING(CallSymbol,4,1)) <> 1) 
THEN (CASE WHEN PutExpirationMonthLetter = 'M' THEN 01
WHEN PutExpirationMonthLetter = 'N' THEN 02
WHEN PutExpirationMonthLetter = 'O' THEN 03
WHEN PutExpirationMonthLetter = 'P' THEN 04
WHEN PutExpirationMonthLetter = 'Q' THEN 05
WHEN PutExpirationMonthLetter = 'R' THEN 06
WHEN PutExpirationMonthLetter = 'S' THEN 07
WHEN PutExpirationMonthLetter = 'T' THEN 08
WHEN PutExpirationMonthLetter = 'U' THEN 09
WHEN PutExpirationMonthLetter = 'V' THEN 10
WHEN PutExpirationMonthLetter = 'W' THEN 11
WHEN PutExpirationMonthLetter = 'X' THEN 12 END) 
ELSE
(CASE WHEN PutExpirationMonthLetter = 'M' THEN 01
WHEN PutExpirationMonthLetter = 'N' THEN 02
WHEN PutExpirationMonthLetter = 'O' THEN 03
WHEN PutExpirationMonthLetter = 'P' THEN 04
WHEN PutExpirationMonthLetter = 'Q' THEN 05
WHEN PutExpirationMonthLetter = 'R' THEN 06
WHEN PutExpirationMonthLetter = 'S' THEN 07
WHEN PutExpirationMonthLetter = 'T' THEN 08
WHEN PutExpirationMonthLetter = 'U' THEN 09
WHEN PutExpirationMonthLetter = 'V' THEN 10
WHEN PutExpirationMonthLetter = 'W' THEN 11
WHEN PutExpirationMonthLetter = 'X' THEN 12
END) END));


UPDATE OptionsChains
SET CallExpFullDate = (SELECT CONVERT(DATE,(CONCAT(CallExpirationMonth,'/', CallExpDay,'/',CallExpYear)))),
PutExpFullDate = (SELECT CONVERT(DATE,(CONCAT(PutExpirationMonth,'/', PutExpDay,'/',PutExpYear))));
*/

END






