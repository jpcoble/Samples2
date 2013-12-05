USE [DB_9ABA01_voicetext]
GO
/****** Object:  StoredProcedure [dbo].[FFReminderProcessor]    Script Date: 12/3/2013 2:37:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[FFReminderProcessor]

AS

BEGIN


UPDATE FilingFeeReminderStage
SET AmountDue = (CASE WHEN Type = '7' THEN '76.50' WHEN Type = '13' THEN '70.25' END);

DELETE FROM FilingFeeReminderStage WHERE HasPmtBeenReceived = 'Yes';

END