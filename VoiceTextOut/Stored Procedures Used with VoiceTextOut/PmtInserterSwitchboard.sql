USE [DB_9ABA01_voicetext]
GO
/****** Object:  StoredProcedure [dbo].[PmtInserterSwitchboard]    Script Date: 12/3/2013 2:38:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[PmtInserterSwitchboard]

AS

BEGIN

DELETE FROM Letter_PaymentReminder;

INSERT INTO Letter_PaymentReminder (ClientNumber, Name, Address, Address2, City, State, Zip, DueDate, AmountDue)
SELECT ClientNumber, Name, Address, Address2, City, State, Zip, DueDate, AmountDue FROM PaymentReminderStage WHERE Email IS NULL OR Email = '';

DELETE FROM Email_PaymentReminder;

INSERT INTO Email_PaymentReminder (ClientNumber, Email, Name, DueDate, AmountDue)
SELECT ClientNumber, Email, Name, DueDate, AmountDue FROM PaymentReminderStage WHERE Email IS NOT NULL AND Email <> '';

DELETE FROM Text_PaymentReminder;

INSERT INTO Text_PaymentReminder (ClientNumber, Name, Number, DueDate, AmountDue)
SELECT ClientNumber, Name, Cell, DueDate, AmountDue FROM PaymentReminderStage;

DELETE FROM Voice_PaymentReminder;

INSERT INTO Voice_PaymentReminder (ClientNumber, Name, Number, DueDate, AmountDue)
SELECT ClientNumber, Name, Cell, DueDate, AmountDue FROM PaymentReminderStage;

END