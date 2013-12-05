USE [DB_9ABA01_voicetext]
GO
/****** Object:  StoredProcedure [dbo].[FFInserterSwitchboard]    Script Date: 12/3/2013 2:36:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[FFInserterSwitchboard]

AS

BEGIN

DELETE FROM Letter_FFPmtReminder;

INSERT INTO Letter_FFPmtReminder (ClientNumber, CaseNumber, Name, Address, Address2, City, State, Zip, DueDate, AmountDue, HasPmtBeenReceived)
SELECT ClientNumber, CaseNumber, Name, Address, Address2, City, State, Zip, DueDate, AmountDue, HasPmtBeenReceived FROM FilingFeeReminderStage;

DELETE FROM Email_FFPmtReminder;

INSERT INTO Email_FFPmtReminder (ClientNumber, CaseNumber, Email, Name, DueDate, AmountDue, HasPmtBeenReceived)
SELECT ClientNumber, CaseNumber, Email, Name, DueDate, AmountDue, HasPmtBeenReceived FROM FilingFeeReminderStage;

DELETE FROM Text_FFPmtReminder;

INSERT INTO Text_FFPmtReminder (ClientNumber, Name, Number, DueDate, AmountDue)
SELECT ClientNumber, Name, Cell, DueDate, AmountDue FROM FilingFeeReminderStage;

DELETE FROM Voice_FFPmtReminder;

INSERT INTO Voice_FFPmtReminder (ClientNumber, CaseNumber, Name, Number, DueDate, AmountDue, HasPmtBeenReceived)
SELECT ClientNumber, CaseNumber, Name, Cell, DueDate, AmountDue, HasPmtBeenReceived FROM FilingFeeReminderStage;

END