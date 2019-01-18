/****** Object:  StoredProcedure [dbo].[StdDevCalculator]    Script Date: 1/18/2019 4:42:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[StdDevCalculator] @Hours NUMERIC(18,0)

AS



BEGIN

DECLARE @Beer INT
SET @Beer = 1

WHILE @Beer <= (SELECT COUNT(*) FROM StockSymbols)
BEGIN


WITH CTE5 AS(SELECT StdDev, DayCodeForStdDev, CurrentDate FROM OptionsCurrent
WHERE CurrentDate = (SELECT (CONVERT(DATE, DATEADD(hh, -@Hours, GETDATE())))) 
AND StockSymbol = (SELECT StockSymbol FROM StockSymbols WHERE ID = @Beer)),
CTE AS ((SELECT WeekDays FROM WeekDays WHERE ID BETWEEN (SELECT ID-62 FROM WeekDays 
WHERE WeekDays = CONVERT(DATE, DATEADD(hh, -@Hours, GETDATE()))) AND
((SELECT ID FROM WeekDays WHERE WeekDays = CONVERT(DATE, DATEADD(hh, -@Hours, GETDATE())))
))), CTE2 AS ((SELECT WeekDays FROM WeekDays WHERE ID BETWEEN (SELECT ID-20 FROM WeekDays 
WHERE WeekDays = CONVERT(DATE, DATEADD(hh, -@Hours, GETDATE()))) AND
((SELECT ID FROM WeekDays WHERE WeekDays = CONVERT(DATE, DATEADD(hh, -@Hours, GETDATE())))))
)

UPDATE CTE5
SET StdDev = (SELECT (CASE WHEN(DayCodeForStdDev = 0) THEN 
(SELECT (STDEV(AdjClose))/100 FROM StockPrices WHERE [Date] IN (SELECT WeekDays FROM CTE)
AND StockSymbol = (SELECT StockSymbol FROM StockSymbols WHERE ID = @Beer) 
AND CurrentDate = CONVERT(DATE, DATEADD(hh, -@Hours, GETDATE()))
) 
WHEN (DayCodeForStdDev = 1) THEN
(SELECT (STDEV(AdjClose))/100 FROM StockPrices WHERE [Date] IN (SELECT WeekDays FROM CTE2)
AND StockSymbol = (SELECT StockSymbol FROM StockSymbols WHERE ID = @Beer) 
AND CurrentDate = CONVERT(DATE, DATEADD(hh, -@Hours, GETDATE()))
) END)); 

SET @Beer = @Beer + 1
END



END