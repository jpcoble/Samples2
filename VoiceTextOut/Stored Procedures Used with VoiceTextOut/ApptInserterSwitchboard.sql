USE [DB_9ABA01_voicetext]
GO
/****** Object:  StoredProcedure [dbo].[ApptInserterSwitchboard]    Script Date: 12/3/2013 2:28:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ApptInserterSwitchboard]

AS

BEGIN

DELETE FROM Letter_ApptReminder;

INSERT INTO Letter_ApptReminder (ClientNumber, Name, Address, Address2, City, State, Zip, ApptDate, ApptPurpose, AltApptTime)
SELECT ClientNumber, Name, Address, Address2, City, State, Zip, ApptDate, ApptPurpose, AltTime FROM ApptReminderStage WHERE Email IS NULL OR Email = '';

DELETE FROM Email_ApptReminder;

INSERT INTO Email_ApptReminder (ClientNumber, Email, Name, ApptDate, ApptPurpose, AltAptTime)
SELECT ClientNumber, Email, Name, ApptDate, ApptPurpose, AltTime FROM ApptReminderStage WHERE Email IS NOT NULL AND Email <> '';

DELETE FROM Text_ApptReminder;

INSERT INTO Text_ApptReminder (ClientNumber, Name, Cell, ApptDate, ApptTime)
SELECT ClientNumber, Name, Cell, ApptDate, ApptTime FROM ApptReminderStage;

DELETE FROM Voice_ApptReminder;

INSERT INTO Voice_ApptReminder (ClientNumber, Name, Number, ApptDate, ApptTime, ApptPurpose)
SELECT ClientNumber, Name, Cell, ApptDate, ApptTime, ApptPurpose FROM ApptReminderStage;

END