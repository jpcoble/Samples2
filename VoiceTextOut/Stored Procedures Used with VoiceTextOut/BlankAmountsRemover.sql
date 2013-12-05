USE [DB_9ABA01_voicetext]
GO
/****** Object:  StoredProcedure [dbo].[BlankAmountsRemover]    Script Date: 12/3/2013 2:33:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[BlankAmountsRemover]

AS

BEGIN


DELETE FROM PaymentReminderStage WHERE AmountDue = 0

END