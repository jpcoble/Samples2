USE [BKEstimator]
GO
/****** Object:  StoredProcedure [dbo].[UpdateC13Analyzer]    Script Date: 12/03/2013 17:35:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[UpdateC13Analyzer]

AS

BEGIN

Execute UpdateUnsecureds
Execute UpdateNonExAnalyzer
Execute UpdateVehicleAnalyzer
Execute UpdateSecuredAnalyzer

UPDATE C13Analyzer
SET TillRate=(CASE WHEN(SELECT TillRate FROM AttorneyInputs
WHERE AttorneyInputs.ClientID=C13Analyzer.ClientID)>0 THEN
(SELECT TillRate FROM AttorneyInputs
WHERE AttorneyInputs.ClientID=C13Analyzer.ClientID)ELSE 0 END) 
UPDATE C13Analyzer
SET UnsecuredDebt=(CASE WHEN(SELECT TotalUnsecuredDebt FROM UnsecuredAnalyzer
WHERE C13Analyzer.ClientID=UnsecuredAnalyzer.ClientID)>0 THEN (SELECT TotalUnsecuredDebt FROM UnsecuredAnalyzer
WHERE C13Analyzer.ClientID=UnsecuredAnalyzer.ClientID)ELSE 0 END)
UPDATE C13Analyzer
SET UnsecuredBeforeCalc=UnsecuredDebt+AddtionalUnsecured
UPDATE C13Analyzer
SET Unsecured5Percent=(CASE WHEN(UnsecuredBeforeCalc*.05)>0 
THEN (UnsecuredBeforeCalc*.05)ELSE 0 END)
UPDATE C13Analyzer
SET NonExEquity=(CASE WHEN(SELECT TotalC13NonExEquity FROM NonExAnalyzer
WHERE NonExAnalyzer.ClientID=C13Analyzer.ClientID)>0 THEN
(SELECT TotalC13NonExEquity FROM NonExAnalyzer
WHERE NonExAnalyzer.ClientID=C13Analyzer.ClientID) ELSE 0 END)
UPDATE C13Analyzer
SET TotalUnsecured=(CASE WHEN(UnsecuredBeforeCalc<NonExEquity) 
THEN UnsecuredBeforeCalc
WHEN Unsecured5Percent>NonExEquity THEN Unsecured5Percent
ELSE NonExEquity END)

UPDATE C13Analyzer
SET PrinRes1stMortIntRate=(SELECT PrinRes1stMortIntRate FROM AttorneyInputs
WHERE AttorneyInputs.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PrinRes2NDMortIntRate=(SELECT PrinRes2ndMortIntRate FROM AttorneyInputs
WHERE AttorneyInputs.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PrinRes3rdMortIntRate=(SELECT PrinRes3rdMortIntRate FROM AttorneyInputs
WHERE AttorneyInputs.ClientID=C13Analyzer.ClientID)

UPDATE C13Analyzer
SET VehicleMakeModelYr1=(SELECT VehicleMakeModelYr1 FROM Vehicles
WHERE C13Analyzer.ClientID=Vehicles.ClientID)
UPDATE C13Analyzer
SET VehicleCompany11=(SELECT VehicleLoan1Company1 FROM Vehicles
WHERE C13Analyzer.ClientID=Vehicles.ClientID)
UPDATE C13Analyzer
SET VehicleCompany21=(SELECT VehicleLoan2Company1 FROM Vehicles
WHERE C13Analyzer.ClientID=Vehicles.ClientID)
UPDATE C13Analyzer
SET VehicleValue1=(SELECT VehicleRetail1 FROM AttorneyInputs
WHERE C13Analyzer.ClientID=AttorneyInputs.ClientID)
UPDATE C13Analyzer
SET Vehicle13Balance11=(CASE WHEN (SELECT VehicleSecuredPortion11 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)>0
THEN (SELECT VehicleSecuredPortion11 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)
ELSE 0 END)
UPDATE C13Analyzer
SET Vehicle13Balance21=(CASE WHEN (SELECT VehicleSecuredPortion21 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)>0
THEN (SELECT VehicleSecuredPortion21 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)
ELSE 0 END)
UPDATE C13Analyzer
SET VehicleTotalBalance1=Vehicle13Balance11+Vehicle13Balance21
UPDATE C13Analyzer
SET VehicleInterest1=(CASE WHEN(TermOfPlan*(VehicleTotalBalance1*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0
THEN ((TermOfPlan*(VehicleTotalBalance1*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-VehicleTotalBalance1
ELSE 0 END)
UPDATE C13Analyzer
SET VehicleKeepSurrender1=(SELECT VehicleKeepSurrender1 FROM AttorneyInputs
WHERE AttorneyInputs.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET VehiclePayThruPlan1=(CASE WHEN(C13Analyzer.VehicleKeepSurrender1='No')
THEN 0 ELSE (VehicleTotalBalance1+VehicleInterest1) END)

UPDATE C13Analyzer
SET VehicleMakeModelYr2=(SELECT VehicleMakeModelYr2 FROM Vehicles
WHERE C13Analyzer.ClientID=Vehicles.ClientID)
UPDATE C13Analyzer
SET VehicleCompany12=(SELECT VehicleLoan1Company2 FROM Vehicles
WHERE C13Analyzer.ClientID=Vehicles.ClientID)
UPDATE C13Analyzer
SET VehicleCompany22=(SELECT VehicleLoan2Company2 FROM Vehicles
WHERE C13Analyzer.ClientID=Vehicles.ClientID)
UPDATE C13Analyzer
SET VehicleValue2=(SELECT VehicleRetail2 FROM AttorneyInputs
WHERE C13Analyzer.ClientID=AttorneyInputs.ClientID)
UPDATE C13Analyzer
SET Vehicle13Balance12=(CASE WHEN (SELECT VehicleSecuredPortion12 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)>0
THEN (SELECT VehicleSecuredPortion12 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)
ELSE 0 END)
UPDATE C13Analyzer
SET Vehicle13Balance22=(CASE WHEN (SELECT VehicleSecuredPortion22 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)>0
THEN (SELECT VehicleSecuredPortion22 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)
ELSE 0 END)
UPDATE C13Analyzer
SET VehicleTotalBalance2=Vehicle13Balance12+Vehicle13Balance22
UPDATE C13Analyzer
SET VehicleInterest2=(CASE WHEN(TermOfPlan*(VehicleTotalBalance2*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0
THEN ((TermOfPlan*(VehicleTotalBalance2*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-VehicleTotalBalance2
ELSE 0 END)
UPDATE C13Analyzer
SET VehicleKeepSurrender2=(SELECT VehicleKeepSurrender2 FROM AttorneyInputs
WHERE AttorneyInputs.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET VehiclePayThruPlan2=(CASE WHEN(C13Analyzer.VehicleKeepSurrender2='No')
THEN 0 ELSE (VehicleTotalBalance2+VehicleInterest2) END)

UPDATE C13Analyzer
SET VehicleMakeModelYr3=(SELECT VehicleMakeModelYr3 FROM Vehicles
WHERE C13Analyzer.ClientID=Vehicles.ClientID)
UPDATE C13Analyzer
SET VehicleCompany13=(SELECT VehicleLoan1Company3 FROM Vehicles
WHERE C13Analyzer.ClientID=Vehicles.ClientID)
UPDATE C13Analyzer
SET VehicleCompany23=(SELECT VehicleLoan2Company3 FROM Vehicles
WHERE C13Analyzer.ClientID=Vehicles.ClientID)
UPDATE C13Analyzer
SET VehicleValue3=(SELECT VehicleRetail3 FROM AttorneyInputs
WHERE C13Analyzer.ClientID=AttorneyInputs.ClientID)
UPDATE C13Analyzer
SET Vehicle13Balance13=(CASE WHEN (SELECT VehicleSecuredPortion13 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)>0
THEN (SELECT VehicleSecuredPortion13 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)
ELSE 0 END)
UPDATE C13Analyzer
SET Vehicle13Balance23=(CASE WHEN (SELECT VehicleSecuredPortion23 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)>0
THEN (SELECT VehicleSecuredPortion23 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)
ELSE 0 END)
UPDATE C13Analyzer
SET VehicleTotalBalance3=Vehicle13Balance13+Vehicle13Balance23
UPDATE C13Analyzer
SET VehicleInterest3=(CASE WHEN(TermOfPlan*(VehicleTotalBalance3*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0
THEN ((TermOfPlan*(VehicleTotalBalance3*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-VehicleTotalBalance3
ELSE 0 END)
UPDATE C13Analyzer
SET VehicleKeepSurrender3=(SELECT VehicleKeepSurrender3 FROM AttorneyInputs
WHERE AttorneyInputs.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET VehiclePayThruPlan3=(CASE WHEN(C13Analyzer.VehicleKeepSurrender3='No')
THEN 0 ELSE (VehicleTotalBalance3+VehicleInterest3) END)

UPDATE C13Analyzer
SET VehicleMakeModelYr4=(SELECT VehicleMakeModelYr4 FROM Vehicles
WHERE C13Analyzer.ClientID=Vehicles.ClientID)
UPDATE C13Analyzer
SET VehicleCompany14=(SELECT VehicleLoan1Company4 FROM Vehicles
WHERE C13Analyzer.ClientID=Vehicles.ClientID)
UPDATE C13Analyzer
SET VehicleCompany24=(SELECT VehicleLoan2Company4 FROM Vehicles
WHERE C13Analyzer.ClientID=Vehicles.ClientID)
UPDATE C13Analyzer
SET VehicleValue4=(SELECT VehicleRetail4 FROM AttorneyInputs
WHERE C13Analyzer.ClientID=AttorneyInputs.ClientID)
UPDATE C13Analyzer
SET Vehicle13Balance14=(CASE WHEN (SELECT VehicleSecuredPortion14 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)>0
THEN (SELECT VehicleSecuredPortion14 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)
ELSE 0 END)
UPDATE C13Analyzer
SET Vehicle13Balance24=(CASE WHEN (SELECT VehicleSecuredPortion24 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)>0
THEN (SELECT VehicleSecuredPortion24 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)
ELSE 0 END)
UPDATE C13Analyzer
SET VehicleTotalBalance4=Vehicle13Balance14+Vehicle13Balance24
UPDATE C13Analyzer
SET VehicleInterest4=(CASE WHEN(TermOfPlan*(VehicleTotalBalance4*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0
THEN ((TermOfPlan*(VehicleTotalBalance4*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-VehicleTotalBalance4
ELSE 0 END)
UPDATE C13Analyzer
SET VehicleKeepSurrender4=(SELECT VehicleKeepSurrender4 FROM AttorneyInputs
WHERE AttorneyInputs.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET VehiclePayThruPlan4=(CASE WHEN(C13Analyzer.VehicleKeepSurrender4='No')
THEN 0 ELSE (VehicleTotalBalance4+VehicleInterest4) END)

UPDATE C13Analyzer
SET VehicleMakeModelYr5=(SELECT VehicleMakeModelYr5 FROM Vehicles
WHERE C13Analyzer.ClientID=Vehicles.ClientID)
UPDATE C13Analyzer
SET VehicleCompany15=(SELECT VehicleLoan1Company5 FROM Vehicles
WHERE C13Analyzer.ClientID=Vehicles.ClientID)
UPDATE C13Analyzer
SET VehicleCompany25=(SELECT VehicleLoan2Company5 FROM Vehicles
WHERE C13Analyzer.ClientID=Vehicles.ClientID)
UPDATE C13Analyzer
SET VehicleValue5=(SELECT VehicleRetail5 FROM AttorneyInputs
WHERE C13Analyzer.ClientID=AttorneyInputs.ClientID)
UPDATE C13Analyzer
SET Vehicle13Balance15=(CASE WHEN (SELECT VehicleSecuredPortion15 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)>0
THEN (SELECT VehicleSecuredPortion15 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)
ELSE 0 END)
UPDATE C13Analyzer
SET Vehicle13Balance25=(CASE WHEN (SELECT VehicleSecuredPortion25 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)>0
THEN (SELECT VehicleSecuredPortion25 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)
ELSE 0 END)
UPDATE C13Analyzer
SET VehicleTotalBalance5=Vehicle13Balance15+Vehicle13Balance25
UPDATE C13Analyzer
SET VehicleInterest5=(CASE WHEN(TermOfPlan*(VehicleTotalBalance5*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0
THEN ((TermOfPlan*(VehicleTotalBalance5*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-VehicleTotalBalance5
ELSE 0 END)
UPDATE C13Analyzer
SET VehicleKeepSurrender5=(SELECT VehicleKeepSurrender5 FROM AttorneyInputs
WHERE AttorneyInputs.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET VehiclePayThruPlan5=(CASE WHEN(C13Analyzer.VehicleKeepSurrender5='No')
THEN 0 ELSE (VehicleTotalBalance5+VehicleInterest5) END)

UPDATE C13Analyzer
SET VehicleMakeModelYr7=(SELECT VehicleMakeModelYr7 FROM Vehicles
WHERE C13Analyzer.ClientID=Vehicles.ClientID)
UPDATE C13Analyzer
SET VehicleCompany17=(SELECT VehicleLoan1Company7 FROM Vehicles
WHERE C13Analyzer.ClientID=Vehicles.ClientID)
UPDATE C13Analyzer
SET VehicleCompany27=(SELECT VehicleLoan2Company7 FROM Vehicles
WHERE C13Analyzer.ClientID=Vehicles.ClientID)
UPDATE C13Analyzer
SET VehicleValue7=(SELECT VehicleRetail7 FROM AttorneyInputs
WHERE C13Analyzer.ClientID=AttorneyInputs.ClientID)
UPDATE C13Analyzer
SET Vehicle13Balance17=(CASE WHEN (SELECT VehicleSecuredPortion17 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)>0
THEN (SELECT VehicleSecuredPortion17 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)
ELSE 0 END)
UPDATE C13Analyzer
SET Vehicle13Balance27=(CASE WHEN (SELECT VehicleSecuredPortion27 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)>0
THEN (SELECT VehicleSecuredPortion27 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)
ELSE 0 END)
UPDATE C13Analyzer
SET VehicleTotalBalance7=Vehicle13Balance17+Vehicle13Balance27
UPDATE C13Analyzer
SET VehicleInterest7=(CASE WHEN(TermOfPlan*(VehicleTotalBalance7*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0
THEN ((TermOfPlan*(VehicleTotalBalance7*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-VehicleTotalBalance7
ELSE 0 END)
UPDATE C13Analyzer
SET VehicleKeepSurrender7=(SELECT VehicleKeepSurrender7 FROM AttorneyInputs
WHERE AttorneyInputs.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET VehiclePayThruPlan7=(CASE WHEN(C13Analyzer.VehicleKeepSurrender7='No')
THEN 0 ELSE (VehicleTotalBalance7+VehicleInterest7) END)

UPDATE C13Analyzer
SET VehicleMakeModelYr6=(SELECT VehicleMakeModelYr6 FROM Vehicles
WHERE C13Analyzer.ClientID=Vehicles.ClientID)
UPDATE C13Analyzer
SET VehicleCompany16=(SELECT VehicleLoan1Company6 FROM Vehicles
WHERE C13Analyzer.ClientID=Vehicles.ClientID)
UPDATE C13Analyzer
SET VehicleCompany26=(SELECT VehicleLoan2Company6 FROM Vehicles
WHERE C13Analyzer.ClientID=Vehicles.ClientID)
UPDATE C13Analyzer
SET VehicleValue6=(SELECT VehicleRetail6 FROM AttorneyInputs
WHERE C13Analyzer.ClientID=AttorneyInputs.ClientID)
UPDATE C13Analyzer
SET Vehicle13Balance16=(CASE WHEN (SELECT VehicleSecuredPortion16 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)>0
THEN (SELECT VehicleSecuredPortion16 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)
ELSE 0 END)
UPDATE C13Analyzer
SET Vehicle13Balance26=(CASE WHEN (SELECT VehicleSecuredPortion26 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)>0
THEN (SELECT VehicleSecuredPortion26 FROM
VehicleAnalyzer WHERE VehicleAnalyzer.ClientID=C13Analyzer.ClientID)
ELSE 0 END)
UPDATE C13Analyzer
SET VehicleTotalBalance6=Vehicle13Balance16+Vehicle13Balance26
UPDATE C13Analyzer
SET VehicleInterest6=(CASE WHEN(TermOfPlan*(VehicleTotalBalance6*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0
THEN ((TermOfPlan*(VehicleTotalBalance6*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-VehicleTotalBalance6
ELSE 0 END)
UPDATE C13Analyzer
SET VehicleKeepSurrender6=(SELECT VehicleKeepSurrender6 FROM AttorneyInputs
WHERE AttorneyInputs.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET VehiclePayThruPlan6=(CASE WHEN(C13Analyzer.VehicleKeepSurrender6='No')
THEN 0 ELSE (VehicleTotalBalance6+VehicleInterest6) END)




UPDATE C13Analyzer
SET SecuredCreditor1=(SELECT SecuredCreditor1 FROM SecuredDebts
WHERE C13Analyzer.ClientID=SecuredDebts.ClientID)
UPDATE C13Analyzer
SET SecuredBalThruPlan1=(CASE WHEN(SELECT SecuredSecuredPortion1
FROM SecuredAnalyzer WHERE SecuredAnalyzer.ClientID=C13Analyzer.ClientID)
>0 THEN (SELECT SecuredSecuredPortion1
FROM SecuredAnalyzer WHERE SecuredAnalyzer.ClientID=C13Analyzer.ClientID)
ELSE 0 END)
UPDATE C13Analyzer
SET SecuredInterest1=(CASE WHEN(TermOfPlan*(SecuredBalThruPlan1*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0
THEN ((TermOfPlan*(SecuredBalThruPlan1*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-SecuredBalThruPlan1
ELSE 0 END)
UPDATE C13Analyzer
SET SecuredKeepSurrender1=(SELECT AttorneyInputs.SecuredKeepSurrender1 FROM AttorneyInputs
WHERE AttorneyInputs.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer 
SET SecuredTotal1=(CASE WHEN(C13Analyzer.SecuredKeepSurrender1='No' 
OR SecuredNonPMSIHousehold1='True')
THEN 0 ELSE (SecuredBalThruPlan1+SecuredInterest1) END)

UPDATE C13Analyzer
SET SecuredCreditor2=(SELECT SecuredCreditor2 FROM SecuredDebts
WHERE C13Analyzer.ClientID=SecuredDebts.ClientID)
UPDATE C13Analyzer
SET SecuredBalThruPlan2=(CASE WHEN(SELECT SecuredSecuredPortion2
FROM SecuredAnalyzer WHERE SecuredAnalyzer.ClientID=C13Analyzer.ClientID)
>0 THEN (SELECT SecuredSecuredPortion2
FROM SecuredAnalyzer WHERE SecuredAnalyzer.ClientID=C13Analyzer.ClientID)
ELSE 0 END)
UPDATE C13Analyzer
SET SecuredInterest2=(CASE WHEN(TermOfPlan*(SecuredBalThruPlan2*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0 
THEN ((TermOfPlan*(SecuredBalThruPlan2*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-SecuredBalThruPlan2
ELSE 0 END)
UPDATE C13Analyzer
SET SecuredKeepSurrender2=(SELECT AttorneyInputs.SecuredKeepSurrender2 FROM AttorneyInputs
WHERE AttorneyInputs.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer 
SET SecuredTotal2=(CASE WHEN(C13Analyzer.SecuredKeepSurrender2='No' 
OR SecuredNonPMSIHousehold2='True')
THEN 0 ELSE (SecuredBalThruPlan2+SecuredInterest2) END)

UPDATE C13Analyzer
SET SecuredCreditor3=(SELECT SecuredCreditor3 FROM SecuredDebts
WHERE C13Analyzer.ClientID=SecuredDebts.ClientID)
UPDATE C13Analyzer
SET SecuredBalThruPlan3=(CASE WHEN(SELECT SecuredSecuredPortion3
FROM SecuredAnalyzer WHERE SecuredAnalyzer.ClientID=C13Analyzer.ClientID)
>0 THEN (SELECT SecuredSecuredPortion3
FROM SecuredAnalyzer WHERE SecuredAnalyzer.ClientID=C13Analyzer.ClientID)
ELSE 0 END)
UPDATE C13Analyzer
SET SecuredInterest3=(CASE WHEN(TermOfPlan*(SecuredBalThruPlan3*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0
THEN ((TermOfPlan*(SecuredBalThruPlan3*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-SecuredBalThruPlan3
ELSE 0 END)
UPDATE C13Analyzer
SET SecuredKeepSurrender3=(SELECT AttorneyInputs.SecuredKeepSurrender3 FROM AttorneyInputs
WHERE AttorneyInputs.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer 
SET SecuredTotal3=(CASE WHEN(C13Analyzer.SecuredKeepSurrender3='No' 
OR SecuredNonPMSIHousehold3='True')
THEN 0 ELSE (SecuredBalThruPlan3+SecuredInterest3) END)

UPDATE C13Analyzer
SET SecuredCreditor4=(SELECT SecuredCreditor4 FROM SecuredDebts
WHERE C13Analyzer.ClientID=SecuredDebts.ClientID)
UPDATE C13Analyzer
SET SecuredBalThruPlan4=(CASE WHEN(SELECT SecuredSecuredPortion4
FROM SecuredAnalyzer WHERE SecuredAnalyzer.ClientID=C13Analyzer.ClientID)
>0 THEN (SELECT SecuredSecuredPortion4
FROM SecuredAnalyzer WHERE SecuredAnalyzer.ClientID=C13Analyzer.ClientID)
ELSE 0 END)
UPDATE C13Analyzer
SET SecuredInterest4=(CASE WHEN(TermOfPlan*(SecuredBalThruPlan4*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0
THEN ((TermOfPlan*(SecuredBalThruPlan4*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-SecuredBalThruPlan4
ELSE 0 END)
UPDATE C13Analyzer
SET SecuredKeepSurrender4=(SELECT AttorneyInputs.SecuredKeepSurrender4 FROM AttorneyInputs
WHERE AttorneyInputs.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer 
SET SecuredTotal4=(CASE WHEN(C13Analyzer.SecuredKeepSurrender4='No' 
OR SecuredNonPMSIHousehold4='True')
THEN 0 ELSE (SecuredBalThruPlan4+SecuredInterest4) END)

UPDATE C13Analyzer
SET SecuredCreditor5=(SELECT SecuredCreditor5 FROM SecuredDebts
WHERE C13Analyzer.ClientID=SecuredDebts.ClientID)
UPDATE C13Analyzer
SET SecuredBalThruPlan5=(CASE WHEN(SELECT SecuredSecuredPortion5
FROM SecuredAnalyzer WHERE SecuredAnalyzer.ClientID=C13Analyzer.ClientID)
>0 THEN (SELECT SecuredSecuredPortion5
FROM SecuredAnalyzer WHERE SecuredAnalyzer.ClientID=C13Analyzer.ClientID)
ELSE 0 END)
UPDATE C13Analyzer
SET SecuredInterest5=(CASE WHEN(TermOfPlan*(SecuredBalThruPlan5*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0
THEN ((TermOfPlan*(SecuredBalThruPlan5*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-SecuredBalThruPlan5
ELSE 0 END)
UPDATE C13Analyzer
SET SecuredKeepSurrender5=(SELECT AttorneyInputs.SecuredKeepSurrender5 FROM AttorneyInputs
WHERE AttorneyInputs.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer 
SET SecuredTotal5=(CASE WHEN(C13Analyzer.SecuredKeepSurrender5='No' 
OR SecuredNonPMSIHousehold5='True')
THEN 0 ELSE (SecuredBalThruPlan5+SecuredInterest5) END)

UPDATE C13Analyzer
SET SecuredCreditor6=(SELECT SecuredCreditor6 FROM SecuredDebts
WHERE C13Analyzer.ClientID=SecuredDebts.ClientID)
UPDATE C13Analyzer
SET SecuredBalThruPlan6=(CASE WHEN(SELECT SecuredSecuredPortion6
FROM SecuredAnalyzer WHERE SecuredAnalyzer.ClientID=C13Analyzer.ClientID)
>0 THEN (SELECT SecuredSecuredPortion6
FROM SecuredAnalyzer WHERE SecuredAnalyzer.ClientID=C13Analyzer.ClientID)
ELSE 0 END)
UPDATE C13Analyzer
SET SecuredInterest6=(CASE WHEN(TermOfPlan*(SecuredBalThruPlan6*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0
THEN ((TermOfPlan*(SecuredBalThruPlan6*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-SecuredBalThruPlan6
ELSE 0 END)
UPDATE C13Analyzer
SET SecuredKeepSurrender6=(SELECT AttorneyInputs.SecuredKeepSurrender6 FROM AttorneyInputs
WHERE AttorneyInputs.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer 
SET SecuredTotal6=(CASE WHEN(C13Analyzer.SecuredKeepSurrender6='No' 
OR SecuredNonPMSIHousehold6='True')
THEN 0 ELSE (SecuredBalThruPlan6+SecuredInterest6) END)

UPDATE C13Analyzer
SET SecuredCreditor7=(SELECT SecuredCreditor7 FROM SecuredDebts
WHERE C13Analyzer.ClientID=SecuredDebts.ClientID)
UPDATE C13Analyzer
SET SecuredBalThruPlan7=(CASE WHEN(SELECT SecuredSecuredPortion7
FROM SecuredAnalyzer WHERE SecuredAnalyzer.ClientID=C13Analyzer.ClientID)
>0 THEN (SELECT SecuredSecuredPortion7
FROM SecuredAnalyzer WHERE SecuredAnalyzer.ClientID=C13Analyzer.ClientID)
ELSE 0 END)
UPDATE C13Analyzer
SET SecuredInterest7=(CASE WHEN(TermOfPlan*(SecuredBalThruPlan7*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0
THEN ((TermOfPlan*(SecuredBalThruPlan7*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-SecuredBalThruPlan7
ELSE 0 END)
UPDATE C13Analyzer
SET SecuredKeepSurrender7=(SELECT AttorneyInputs.SecuredKeepSurrender7 FROM AttorneyInputs
WHERE AttorneyInputs.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer 
SET SecuredTotal7=(CASE WHEN(C13Analyzer.SecuredKeepSurrender7='No' 
OR SecuredNonPMSIHousehold7='True')
THEN 0 ELSE (SecuredBalThruPlan7+SecuredInterest7) END)



UPDATE C13Analyzer
SET Property1=(SELECT PropertyType1 FROM RealProperty
WHERE RealProperty.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyKeepSurrender1=(SELECT RealPropertyKeepSurrender1 FROM AttorneyInputs
WHERE AttorneyInputs.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyMortCo11=(SELECT Property1stMortCompany1 FROM RealProperty
WHERE RealProperty.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyMortArrear11=(CASE WHEN(SELECT (Property1stMortPmt1*Property1stMortMonthsBehind1) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)>0 THEN
(SELECT (Property1stMortPmt1*Property1stMortMonthsBehind1) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)ELSE 0 END)
UPDATE C13Analyzer
SET PropertyInt11=(CASE WHEN(TermOfPlan*(PropertyMortArrear11*((C13Analyzer.PrinRes1stMortIntRate/12)*
(SELECT POWER(1+(C13Analyzer.PrinRes1stMortIntRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.PrinRes1stMortIntRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND PrinRes1stMortIntRate>0
THEN ((TermOfPlan*(PropertyMortArrear11*((C13Analyzer.PrinRes1stMortIntRate/12)*
(SELECT POWER(1+(C13Analyzer.PrinRes1stMortIntRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.PrinRes1stMortIntRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-PropertyMortArrear11
ELSE 0 END)
UPDATE C13Analyzer
SET PropertyMortCo21=(SELECT Property2ndMortCompany1 FROM RealProperty
WHERE RealProperty.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyMortArrear21=(CASE WHEN(SELECT (Property2ndMortPmt1*Property2ndMortMonthsBehind1) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)>0 THEN
(SELECT (Property2ndMortPmt1*Property2ndMortMonthsBehind1) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)ELSE 0 END)
UPDATE C13Analyzer
SET PropertyInt21=(CASE WHEN(TermOfPlan*(PropertyMortArrear21*((C13Analyzer.PrinRes2ndMortIntRate/12)*
(SELECT POWER(1+(C13Analyzer.PrinRes2ndMortIntRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.PrinRes2ndMortIntRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND PrinRes2ndMortIntRate>0
THEN ((TermOfPlan*(PropertyMortArrear21*((C13Analyzer.PrinRes2ndMortIntRate/12)*
(SELECT POWER(1+(C13Analyzer.PrinRes2ndMortIntRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.PrinRes2ndMortIntRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-PropertyMortArrear21
ELSE 0 END)
UPDATE C13Analyzer
SET PropertyMortCo31=(SELECT Property3rdMortCompany1 FROM RealProperty
WHERE RealProperty.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyMortArrear31=(CASE WHEN(SELECT (Property3rdMortPmt1*Property3rdMortMonthsBehind1) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)>0 THEN
(SELECT (Property3rdMortPmt1*Property3rdMortMonthsBehind1) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)ELSE 0 END)
UPDATE C13Analyzer
SET PropertyInt31=(CASE WHEN(TermOfPlan*(PropertyMortArrear31*((C13Analyzer.PrinRes3rdMortIntRate/12)*
(SELECT POWER(1+(C13Analyzer.PrinRes3rdMortIntRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.PrinRes3rdMortIntRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND PrinRes3rdMortIntRate>0 
THEN ((TermOfPlan*(PropertyMortArrear31*((C13Analyzer.PrinRes3rdMortIntRate/12)*
(SELECT POWER(1+(C13Analyzer.PrinRes3rdMortIntRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.PrinRes3rdMortIntRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-PropertyMortArrear31
ELSE 0 END)
UPDATE C13Analyzer
SET PropertyTotalThruPlan1=(CASE WHEN(PropertyKeepSurrender1='No') THEN 0 ELSE 
(PropertyMortArrear11+PropertyInt11+PropertyMortArrear21+
PropertyInt21+PropertyMortArrear31+PropertyInt31) END)

UPDATE C13Analyzer
SET Property2=(SELECT PropertyType2 FROM RealProperty
WHERE RealProperty.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyKeepSurrender2=(SELECT RealPropertyKeepSurrender2 FROM AttorneyInputs
WHERE AttorneyInputs.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyMortCo12=(SELECT Property1stMortCompany2 FROM RealProperty
WHERE RealProperty.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyMortArrear12=(CASE WHEN(SELECT (Property1stMortPmt2*Property1stMortMonthsBehind2) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)>0 THEN
(SELECT (Property1stMortPmt2*Property1stMortMonthsBehind2) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)ELSE 0 END)
UPDATE C13Analyzer
SET PropertyInt12=(CASE WHEN(TermOfPlan*(PropertyMortArrear12*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0 
THEN ((TermOfPlan*(PropertyMortArrear12*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-PropertyMortArrear12
ELSE 0 END)
UPDATE C13Analyzer
SET PropertyMortCo22=(SELECT Property2ndMortCompany2 FROM RealProperty
WHERE RealProperty.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyMortArrear22=(CASE WHEN(SELECT (Property2ndMortPmt2*Property2ndMortMonthsBehind2) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)>0 THEN
(SELECT (Property2ndMortPmt2*Property2ndMortMonthsBehind2) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)ELSE 0 END)
UPDATE C13Analyzer
SET PropertyInt22=(CASE WHEN(TermOfPlan*(PropertyMortArrear22*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0
THEN ((TermOfPlan*(PropertyMortArrear22*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-PropertyMortArrear22
ELSE 0 END)
UPDATE C13Analyzer
SET PropertyMortCo32=(SELECT Property3rdMortCompany2 FROM RealProperty
WHERE RealProperty.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyMortArrear32=(CASE WHEN(SELECT (Property3rdMortPmt2*Property3rdMortMonthsBehind2) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)>0 THEN
(SELECT (Property3rdMortPmt2*Property3rdMortMonthsBehind2) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)ELSE 0 END)
UPDATE C13Analyzer
SET PropertyInt32=(CASE WHEN(TermOfPlan*(PropertyMortArrear32*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0
THEN ((TermOfPlan*(PropertyMortArrear32*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-PropertyMortArrear32
ELSE 0 END)
UPDATE C13Analyzer
SET PropertyTotalThruPlan2=(CASE WHEN(PropertyKeepSurrender2='No') THEN 0 ELSE 
(PropertyMortArrear12+PropertyInt12+PropertyMortArrear22+
PropertyInt22+PropertyMortArrear32+PropertyInt32) END)

UPDATE C13Analyzer
SET Property3=(SELECT PropertyType3 FROM RealProperty
WHERE RealProperty.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyKeepSurrender3=(SELECT RealPropertyKeepSurrender3 FROM AttorneyInputs
WHERE AttorneyInputs.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyMortCo13=(SELECT Property1stMortCompany3 FROM RealProperty
WHERE RealProperty.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyMortArrear13=(CASE WHEN(SELECT (Property1stMortPmt3*Property1stMortMonthsBehind3) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)>0 THEN 
(SELECT (Property1stMortPmt3*Property1stMortMonthsBehind3) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)ELSE 0 END)
UPDATE C13Analyzer
SET PropertyInt13=(CASE WHEN(TermOfPlan*(PropertyMortArrear13*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0
THEN ((TermOfPlan*(PropertyMortArrear13*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-PropertyMortArrear13
ELSE 0 END)
UPDATE C13Analyzer
SET PropertyMortCo23=(SELECT Property2ndMortCompany3 FROM RealProperty
WHERE RealProperty.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyMortArrear23=(CASE WHEN(SELECT (Property2ndMortPmt3*Property2ndMortMonthsBehind3) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)>0 THEN
(SELECT (Property2ndMortPmt3*Property2ndMortMonthsBehind3) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)ELSE 0 END)
UPDATE C13Analyzer
SET PropertyInt23=(CASE WHEN(TermOfPlan*(PropertyMortArrear23*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0
THEN ((TermOfPlan*(PropertyMortArrear23*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-PropertyMortArrear23
ELSE 0 END)
UPDATE C13Analyzer
SET PropertyMortCo33=(SELECT Property3rdMortCompany3 FROM RealProperty
WHERE RealProperty.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyMortArrear33=(CASE WHEN(SELECT (Property3rdMortPmt3*Property3rdMortMonthsBehind3) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)>0 THEN
(SELECT (Property3rdMortPmt3*Property3rdMortMonthsBehind3) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)ELSE 0 END)
UPDATE C13Analyzer
SET PropertyInt33=(CASE WHEN(TermOfPlan*(PropertyMortArrear33*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0
THEN ((TermOfPlan*(PropertyMortArrear33*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-PropertyMortArrear33
ELSE 0 END)
UPDATE C13Analyzer
SET PropertyTotalThruPlan3=(CASE WHEN(PropertyKeepSurrender3='No') THEN 0 ELSE 
(PropertyMortArrear13+PropertyInt13+PropertyMortArrear23+
PropertyInt23+PropertyMortArrear33+PropertyInt33) END)

UPDATE C13Analyzer
SET Property4=(SELECT PropertyType4 FROM RealProperty
WHERE RealProperty.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyKeepSurrender4=(SELECT RealPropertyKeepSurrender4 FROM AttorneyInputs
WHERE AttorneyInputs.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyMortCo14=(SELECT Property1stMortCompany4 FROM RealProperty
WHERE RealProperty.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyMortArrear14=(CASE WHEN(SELECT (Property1stMortPmt4*Property1stMortMonthsBehind4) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)>0 THEN
(SELECT (Property1stMortPmt4*Property1stMortMonthsBehind4) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)ELSE 0 END)
UPDATE C13Analyzer
SET PropertyInt14=(CASE WHEN(TermOfPlan*(PropertyMortArrear14*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0
THEN ((TermOfPlan*(PropertyMortArrear14*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-PropertyMortArrear14
ELSE 0 END)
UPDATE C13Analyzer
SET PropertyMortCo24=(SELECT Property2ndMortCompany4 FROM RealProperty
WHERE RealProperty.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyMortArrear24=(CASE WHEN(SELECT (Property2ndMortPmt4*Property2ndMortMonthsBehind4) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)>0 THEN
(SELECT (Property2ndMortPmt4*Property2ndMortMonthsBehind4) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)ELSE 0 END)
UPDATE C13Analyzer
SET PropertyInt24=(CASE WHEN(TermOfPlan*(PropertyMortArrear24*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0
THEN ((TermOfPlan*(PropertyMortArrear24*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-PropertyMortArrear24
ELSE 0 END)
UPDATE C13Analyzer
SET PropertyMortCo34=(SELECT Property3rdMortCompany4 FROM RealProperty
WHERE RealProperty.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyMortArrear34=(CASE WHEN(SELECT (Property3rdMortPmt4*Property3rdMortMonthsBehind4) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)>0 THEN
(SELECT (Property3rdMortPmt4*Property3rdMortMonthsBehind4) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)ELSE 0 END)
UPDATE C13Analyzer
SET PropertyInt34=(CASE WHEN(TermOfPlan*(PropertyMortArrear34*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0
THEN ((TermOfPlan*(PropertyMortArrear34*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-PropertyMortArrear34
ELSE 0 END)
UPDATE C13Analyzer
SET PropertyTotalThruPlan4=(CASE WHEN(PropertyKeepSurrender4='No') THEN 0 ELSE 
(PropertyMortArrear14+PropertyInt14+PropertyMortArrear24+
PropertyInt24+PropertyMortArrear34+PropertyInt34) END)

UPDATE C13Analyzer
SET Property5=(SELECT PropertyType5 FROM RealProperty
WHERE RealProperty.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyKeepSurrender5=(SELECT RealPropertyKeepSurrender5 FROM AttorneyInputs
WHERE AttorneyInputs.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyMortCo15=(SELECT Property1stMortCompany5 FROM RealProperty
WHERE RealProperty.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyMortArrear15=(CASE WHEN(SELECT (Property1stMortPmt5*Property1stMortMonthsBehind5) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)>0 THEN
(SELECT (Property1stMortPmt5*Property1stMortMonthsBehind5) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)ELSE 0 END)
UPDATE C13Analyzer
SET PropertyInt15=(CASE WHEN(TermOfPlan*(PropertyMortArrear15*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0
THEN ((TermOfPlan*(PropertyMortArrear15*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-PropertyMortArrear15
ELSE 0 END)
UPDATE C13Analyzer
SET PropertyMortCo25=(SELECT Property2ndMortCompany5 FROM RealProperty
WHERE RealProperty.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyMortArrear25=(CASE WHEN(SELECT (Property2ndMortPmt5*Property2ndMortMonthsBehind5) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)>0 THEN
(SELECT (Property2ndMortPmt5*Property2ndMortMonthsBehind5) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)ELSE 0 END)
UPDATE C13Analyzer
SET PropertyInt25=(CASE WHEN(TermOfPlan*(PropertyMortArrear25*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0
THEN ((TermOfPlan*(PropertyMortArrear25*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-PropertyMortArrear25
ELSE 0 END)
UPDATE C13Analyzer
SET PropertyMortCo35=(SELECT Property3rdMortCompany5 FROM RealProperty
WHERE RealProperty.ClientID=C13Analyzer.ClientID)
UPDATE C13Analyzer
SET PropertyMortArrear35=(CASE WHEN(SELECT (Property3rdMortPmt5*Property3rdMortMonthsBehind5) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)>0 THEN
(SELECT (Property3rdMortPmt5*Property3rdMortMonthsBehind5) 
FROM RealProperty WHERE RealProperty.ClientID=C13Analyzer.ClientID)ELSE 0 END)
UPDATE C13Analyzer
SET PropertyInt35=(CASE WHEN(TermOfPlan*(PropertyMortArrear35*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
>0 AND TillRate>0
THEN ((TermOfPlan*(PropertyMortArrear35*((C13Analyzer.TillRate/12)*
(SELECT POWER(1+(C13Analyzer.TillRate/12),TermOfPlan)))
/((SELECT POWER((1+(C13Analyzer.TillRate/12)),TermOfPlan))-1))/TermOfPlan)
*TermOfPlan)-PropertyMortArrear35
ELSE 0 END)
UPDATE C13Analyzer
SET PropertyTotalThruPlan5=(CASE WHEN(PropertyKeepSurrender5='No') THEN 0 ELSE 
(PropertyMortArrear15+PropertyInt15+PropertyMortArrear25+
PropertyInt25+PropertyMortArrear35+PropertyInt35) END)


UPDATE C13Analyzer
SET ChildSupportArrearage=(CASE WHEN(SELECT TotalChildSupportArrearage FROM DebtSummary
WHERE DebtSummary.ClientID=C13Analyzer.ClientID)>0 
AND ChildSupportArrearageThruPlanYesNo='False' THEN
(SELECT TotalChildSupportArrearage FROM DebtSummary
WHERE DebtSummary.ClientID=C13Analyzer.ClientID)ELSE 0 END)
UPDATE C13Analyzer
SET TotalStudentLoans=(CASE WHEN(SELECT TotalStudentLoans FROM DebtSummary
WHERE DebtSummary.ClientID=C13Analyzer.ClientID)>0
AND StudentLoansThroughPlanYesNo='False' THEN 
(SELECT TotalStudentLoans FROM DebtSummary
WHERE DebtSummary.ClientID=C13Analyzer.ClientID)ELSE 0 END)

UPDATE C13Analyzer
SET Total13BeforeAttorneyTrustee=(CASE WHEN(TotalUnsecured+VehiclePayThruPlan1+VehiclePayThruPlan2+
VehiclePayThruPlan3+VehiclePayThruPlan4+VehiclePayThruPlan5+VehiclePayThruPlan6+
VehiclePayThruPlan7+SecuredTotal1+SecuredTotal2+SecuredTotal3+SecuredTotal4+
SecuredTotal5+SecuredTotal6+SecuredTotal7+PropertyTotalThruPlan1+
PropertyTotalThruPlan2+PropertyTotalThruPlan3+PropertyTotalThruPlan4+
PropertyTotalThruPlan5+BackTaxesIRS+BackTaxesSDOR+ChildSupportArrearage+
Priority3+TotalStudentLoans+FilingFee)>0 THEN (TotalUnsecured+VehiclePayThruPlan1+VehiclePayThruPlan2+
VehiclePayThruPlan3+VehiclePayThruPlan4+VehiclePayThruPlan5+VehiclePayThruPlan6+
VehiclePayThruPlan7+SecuredTotal1+SecuredTotal2+SecuredTotal3+SecuredTotal4+
SecuredTotal5+SecuredTotal6+SecuredTotal7+PropertyTotalThruPlan1+
PropertyTotalThruPlan2+PropertyTotalThruPlan3+PropertyTotalThruPlan4+
PropertyTotalThruPlan5+BackTaxesIRS+BackTaxesSDOR+ChildSupportArrearage+
Priority3+TotalStudentLoans+FilingFee)ELSE 0 END)
UPDATE C13Analyzer
SET Total13BeforeTrustee=(CASE WHEN(Total13BeforeAttorneyTrustee+AttorneyFeeThruPlan)>0
THEN (Total13BeforeAttorneyTrustee+AttorneyFeeThruPlan)ELSE 0 END)
UPDATE C13Analyzer
SET TrusteeFee=(CASE WHEN(TrusteePercentage*Total13BeforeTrustee)>0 THEN
(TrusteePercentage*Total13BeforeTrustee)ELSE 0 END)
UPDATE C13Analyzer
SET TotalLiquidationTestNumber=(CASE WHEN(Total13BeforeTrustee+TrusteeFee)>0 THEN
(Total13BeforeTrustee+TrusteeFee)ELSE 0 END)
UPDATE C13Analyzer
SET LiquidationMonthlyPmt=(CASE WHEN(TotalLiquidationTestNumber/TermOfPlan)>0 THEN
(TotalLiquidationTestNumber/TermOfPlan)ELSE 0 END)



FROM  C13Analyzer, AttorneyInputs, BasicInfo
WHERE C13Analyzer.ClientID=BasicInfo.ClientID 

END