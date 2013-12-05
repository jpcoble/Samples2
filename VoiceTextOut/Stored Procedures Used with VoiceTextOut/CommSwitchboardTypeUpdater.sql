USE [DB_9ABA01_voicetext]
GO
/****** Object:  StoredProcedure [dbo].[CommSwitchboardTypeUpdater]    Script Date: 12/3/2013 2:34:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[CommSwitchboardTypeUpdater]

AS

BEGIN

UPDATE CourtReminderStage
SET Type = 'Creditors Meeting' WHERE Type IS NULL AND CourtRoom = '341 Room';

UPDATE CourtReminderStage
SET Type = 'Confirmation Hearing' WHERE Type IS NULL  AND CourtRoom <> '341 Room';

END