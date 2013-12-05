USE [DB_9ABA01_voicetext]
GO
/****** Object:  StoredProcedure [dbo].[CoomInserterSwitchboard]    Script Date: 12/3/2013 2:35:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[CoomInserterSwitchboard]

AS

BEGIN

DELETE FROM Letter_CourtReminder;

INSERT INTO Letter_CourtReminder (ClientNumber, Name, Address, Address2, City, State, Zip, Date, Time, Type, Location, Courtroom)
SELECT ClientNumber, Name, Address, Address2, City, State, Zip, Date, Time, Type, Location, Courtroom FROM CourtReminderStage;

DELETE FROM EMail_CourtReminder;

INSERT INTO EMail_CourtReminder (ClientNumber, Name, EMail, Date, Time, Type, Location, Courtroom)
SELECT ClientNumber, Name, EMail, Date, Time, Type, Location, Courtroom FROM CourtReminderStage;

DELETE FROM Text_CourtReminder;

INSERT INTO Text_CourtReminder (ClientNumber, Name, Number, Date, Time, HearingType, Location, Courtroom)
SELECT ClientNumber, Name, Cell, Date, Time, Type, Location, Courtroom FROM CourtReminderStage;

DELETE FROM Voice_CourtReminder;

INSERT INTO Voice_CourtReminder (ClientNumber, Name, Number, Date, Time, Type, Location, Courtroom)
SELECT ClientNumber, Name, Cell, Date, Time, Type, Location, Courtroom FROM CourtReminderStage;

END