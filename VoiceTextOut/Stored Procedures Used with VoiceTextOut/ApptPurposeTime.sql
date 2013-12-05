USE [DB_9ABA01_voicetext]
GO
/****** Object:  StoredProcedure [dbo].[ApptPurposeTime]    Script Date: 12/3/2013 2:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ApptPurposeTime]

AS

BEGIN


UPDATE ApptReminderStage
SET ApptPurpose = (CASE WHEN ApptPurposeNo = 2 THEN 'Drop Off or Upload your tax returns, payroll transcripts, and at home form. You will not see an attorney at this appointment. You will simply be dropping off or uploading the requested documents. '
WHEN ApptPurposeNo = 3 THEN 'This is the deadline for you to have all requested information either uploaded or dropped off at the office. If everything is not in the office by this date, your signing date will have to be moved. You will not see an attorney at this appointment.'
WHEN ApptPurposeNo = 4 THEN 'the Signing of your Bankruptcy Petition. You will meet with an attorney at this appointment.' END),
AltTime = (CASE WHEN ApptTime IS NULL THEN 'Any Time During The Day' ELSE (CONVERT (VARCHAR(15), CAST (ApptTime AS TIME), 100)) END)

END