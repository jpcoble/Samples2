/****** Object:  StoredProcedure [dbo].[CoreIVDaily_NewList]    Script Date: 1/18/2019 4:37:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[CoreIVDaily_NewList] @CurrentDate DATE 

AS



BEGIN


DECLARE @StockSymbol VARCHAR(6), 
@ExpirationDate DATE, @AtTheMoneyExPriceC NUMERIC(18,2),
@AtTheMoneyExPriceP NUMERIC(18,2), @CallImpliedVol NUMERIC(18,4),
@PutImpliedVol NUMERIC(18,4), @TotalImpliedVol NUMERIC(18,4), @ID INT, @ID_Stock INT;

EXEC OptionsFullSensitivity_NewList_RESEQUENCER @CurrentDate;

SET @ID_Stock = 1

WHILE @ID_Stock <= 76

BEGIN

SET @ID = (SELECT MIN(ID) FROM OptionsFullSensitivity_NewList WHERE CurrentDate = @CurrentDate AND
StockSymbol = (SELECT StockSymbol FROM StockSymbols2 WHERE ID = @ID_Stock ));        

WHILE @ID <= (SELECT MAX(ID) FROM OptionsFullSensitivity_NewList WHERE CurrentDate = @CurrentDate AND
StockSymbol = (SELECT StockSymbol FROM StockSymbols2 WHERE ID = @ID_Stock ))

BEGIN

SET @StockSymbol = (SELECT StockSymbol FROM OptionsFullSensitivity_NewList WHERE ID = @ID);
SET @ExpirationDate = (SELECT ExpirationDate FROM OptionsFullSensitivity_NewList WHERE ID = @ID);

WITH CTE AS (SELECT ExercisePrice, StockPrice
FROM OptionsFullSensitivity_NewList WHERE CurrentDate = @CurrentDate
AND StockSymbol = @StockSymbol AND ExpirationDate = @ExpirationDate AND (StockPrice >= ExercisePrice)
)

SELECT @AtTheMoneyExPriceC = (SELECT ExercisePrice FROM CTE WHERE ABS(ExercisePrice - StockPrice) = (SELECT MIN(ABS(ExercisePrice - StockPrice))
FROM CTE)); 

WITH CTE AS (SELECT ExercisePrice, StockPrice
FROM OptionsFullSensitivity_NewList WHERE CurrentDate = @CurrentDate
AND StockSymbol = @StockSymbol AND ExpirationDate = @ExpirationDate AND (StockPrice <= ExercisePrice)
)

SELECT @AtTheMoneyExPriceP = (SELECT ExercisePrice FROM CTE WHERE ABS(ExercisePrice - StockPrice) = (SELECT MIN(ABS(ExercisePrice - StockPrice))
FROM CTE)); 


WITH CTE AS (SELECT t, CallBidAskAvg, ExercisePrice FROM OptionsFullSensitivity_NewList WHERE
CurrentDate = @CurrentDate AND StockSymbol = @StockSymbol AND ExpirationDate = @ExpirationDate
AND ExercisePrice = @AtTheMoneyExPriceC)
SELECT @CallImpliedVol = (SELECT SQRT((2 * PI())/t) * CallBidAskAvg/ExercisePrice AS CallImpliedVol FROM CTE);

WITH CTE AS (SELECT t, PutBidAskAvg, ExercisePrice FROM OptionsFullSensitivity_NewList WHERE
CurrentDate = @CurrentDate AND StockSymbol = @StockSymbol AND ExpirationDate = @ExpirationDate
AND ExercisePrice = @AtTheMoneyExPriceP)
SELECT @PutImpliedVol = (SELECT SQRT((2 * PI())/t) * PutBidAskAvg/ExercisePrice AS PutImpliedVol FROM CTE);

WITH CTE AS (SELECT t, PutBidAskAvg, ExercisePrice FROM OptionsFullSensitivity_NewList WHERE
CurrentDate = @CurrentDate AND StockSymbol = @StockSymbol AND ExpirationDate = @ExpirationDate
AND ExercisePrice = @AtTheMoneyExPriceP), CTE2 AS (SELECT t, CallBidAskAvg, ExercisePrice 
FROM OptionsFullSensitivity_NewList WHERE
CurrentDate = @CurrentDate AND StockSymbol = @StockSymbol AND ExpirationDate = @ExpirationDate
AND ExercisePrice = @AtTheMoneyExPriceC)

SELECT @TotalImpliedVol = (SELECT ((SELECT SQRT((2 * PI())/t) * PutBidAskAvg/ExercisePrice FROM CTE)
+ (SELECT SQRT((2 * PI())/t) * CallBidAskAvg/ExercisePrice FROM CTE2))/2 AS TotalImpliedVol);


INSERT INTO TEMP_CoreDaily_IV(CurrentDate, StockSymbol, ExpirationDate, AtTheMoneyExPriceC, CallImpliedVol,
AtTheMoneyExPriceP, PutImpliedVol, TotalImpliedVol)
SELECT @CurrentDate, @StockSymbol, @ExpirationDate, @AtTheMoneyExPriceC, @CallImpliedVol, 
@AtTheMoneyExPriceP, @PutImpliedVol, @TotalImpliedVol FROM OptionsFullSensitivity_NewList
WHERE CurrentDate = @CurrentDate AND StockSymbol = @StockSymbol AND ExpirationDate = @ExpirationDate;

SET @ID = @ID + 1;

END 

INSERT INTO CoreDaily_IV_NewList(CurrentDate, StockSymbol, ExpirationDate, AtTheMoneyExPriceC, CallImpliedVol, AtTheMoneyExPriceP,
PutImpliedVol, TotalImpliedVol, DateModified)
SELECT DISTINCT CurrentDate, StockSymbol, ExpirationDate, AtTheMoneyExPriceC, CallImpliedVol, AtTheMoneyExPriceP,
PutImpliedVol, TotalImpliedVol, GETDATE()  FROM TEMP_CoreDaily_IV 
ORDER BY StockSymbol, ExpirationDate;

DELETE FROM TEMP_CoreDaily_IV; 

SET @ID_Stock = @ID_Stock + 1;

END

END
