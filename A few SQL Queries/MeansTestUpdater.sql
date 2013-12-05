USE [BKEstimator]
GO
/****** Object:  StoredProcedure [dbo].[MeansTestMover]    Script Date: 12/03/2013 17:31:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[MeansTestMover]

AS

BEGIN

UPDATE MeansTest
SET TakeHomeHouseholdIncome=(SELECT HouseholdNetIncome FROM IncomeAnalysis
WHERE MeansTest.ClientID=IncomeAnalysis.ClientID)



UPDATE MeansTest
SET HouseholdSize=(SELECT (HowManyDependantsInHousehold) FROM Income 
WHERE MeansTest.ClientID=Income.ClientID)
UPDATE MeansTest
SET NationalStandard=(CASE WHEN (HouseholdSize=1) THEN (SELECT NationalStd1
FROM MeansReference)
WHEN (HouseholdSize=2) THEN (SELECT NationalStd2 FROM MeansReference) 
WHEN (HouseholdSize=3) THEN (SELECT NationalStd3 FROM MeansReference) 
WHEN (HouseholdSize=4) THEN (SELECT NationalStd4 FROM MeansReference)
WHEN (HouseholdSize=5) THEN (SELECT NationalStd5 FROM MeansReference) 
WHEN (HouseholdSize=6) THEN (SELECT NationalStd6 FROM MeansReference)
WHEN (HouseholdSize=7) THEN (SELECT NationalStd7 FROM MeansReference)
WHEN (HouseholdSize=8) THEN (SELECT NationalStd8 FROM MeansReference)
WHEN (HouseholdSize=9) THEN (SELECT NationalStd9 FROM MeansReference)
WHEN (HouseholdSize=10) THEN (SELECT NationalStd10 FROM MeansReference)
WHEN (HouseholdSize=11) THEN (SELECT NationalStd11 FROM MeansReference)
WHEN (HouseholdSize=12) THEN (SELECT NationalStd12 FROM MeansReference)
WHEN (HouseholdSize=13) THEN (SELECT NationalStd13 FROM MeansReference)
WHEN (HouseholdSize=14) THEN (SELECT NationalStd14 FROM MeansReference)
WHEN (HouseholdSize=15) THEN (SELECT NationalStd15 FROM MeansReference)
WHEN (HouseholdSize=16) THEN (SELECT NationalStd16 FROM MeansReference)
WHEN (HouseholdSize=17) THEN (SELECT NationalStd17 FROM MeansReference)
WHEN (HouseholdSize=18) THEN (SELECT NationalStd18 FROM MeansReference)
WHEN (HouseholdSize=19) THEN (SELECT NationalStd19 FROM MeansReference)
WHEN (HouseholdSize=20) THEN (SELECT NationalStd20 FROM MeansReference)
ELSE 0 END)

UPDATE MeansTest
SET County=(SELECT County FROM BasicInfo 
WHERE MeansTest.ClientID=BasicInfo.ClientID)
UPDATE MeansTest
SET HousingNonMort=(CASE WHEN (MeansTest.County=(SELECT County1
FROM MeansReference) AND HouseholdSize=1) THEN (SELECT CountyNonMort11 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County1
FROM MeansReference) AND HouseholdSize=2) THEN (SELECT CountyNonMort21 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County1
FROM MeansReference) AND HouseholdSize=3) THEN (SELECT CountyNonMort31 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County1
FROM MeansReference) AND HouseholdSize=4) THEN (SELECT CountyNonMort41 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County1
FROM MeansReference) AND HouseholdSize=5) THEN (SELECT CountyNonMort51 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County2
FROM MeansReference) AND HouseholdSize=1) THEN (SELECT CountyNonMort12 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County2
FROM MeansReference) AND HouseholdSize=2) THEN (SELECT CountyNonMort22 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County2
FROM MeansReference) AND HouseholdSize=3) THEN (SELECT CountyNonMort32 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County2
FROM MeansReference) AND HouseholdSize=4) THEN (SELECT CountyNonMort42 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County2
FROM MeansReference) AND HouseholdSize=5) THEN (SELECT CountyNonMort52 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County3
FROM MeansReference) AND HouseholdSize=1) THEN (SELECT CountyNonMort13 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County3
FROM MeansReference) AND HouseholdSize=2) THEN (SELECT CountyNonMort23 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County3
FROM MeansReference) AND HouseholdSize=3) THEN (SELECT CountyNonMort33 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County3
FROM MeansReference) AND HouseholdSize=4) THEN (SELECT CountyNonMort43 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County3
FROM MeansReference) AND HouseholdSize=5) THEN (SELECT CountyNonMort53 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County4
FROM MeansReference) AND HouseholdSize=1) THEN (SELECT CountyNonMort14 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County4
FROM MeansReference) AND HouseholdSize=2) THEN (SELECT CountyNonMort24 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County4
FROM MeansReference) AND HouseholdSize=3) THEN (SELECT CountyNonMort34 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County4
FROM MeansReference) AND HouseholdSize=4) THEN (SELECT CountyNonMort44 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County4
FROM MeansReference) AND HouseholdSize=5) THEN (SELECT CountyNonMort54 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County5
FROM MeansReference) AND HouseholdSize=1) THEN (SELECT CountyNonMort15 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County5
FROM MeansReference) AND HouseholdSize=2) THEN (SELECT CountyNonMort25 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County5
FROM MeansReference) AND HouseholdSize=3) THEN (SELECT CountyNonMort35 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County5
FROM MeansReference) AND HouseholdSize=4) THEN (SELECT CountyNonMort45 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County5
FROM MeansReference) AND HouseholdSize=5) THEN (SELECT CountyNonMort55 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County6
FROM MeansReference) AND HouseholdSize=1) THEN (SELECT CountyNonMort16 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County6
FROM MeansReference) AND HouseholdSize=2) THEN (SELECT CountyNonMort26 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County6
FROM MeansReference) AND HouseholdSize=3) THEN (SELECT CountyNonMort36 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County6
FROM MeansReference) AND HouseholdSize=4) THEN (SELECT CountyNonMort46 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County6
FROM MeansReference) AND HouseholdSize=5) THEN (SELECT CountyNonMort56 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County7
FROM MeansReference) AND HouseholdSize=1) THEN (SELECT CountyNonMort17 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County7
FROM MeansReference) AND HouseholdSize=2) THEN (SELECT CountyNonMort27 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County7
FROM MeansReference) AND HouseholdSize=3) THEN (SELECT CountyNonMort37 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County7
FROM MeansReference) AND HouseholdSize=4) THEN (SELECT CountyNonMort47 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County7
FROM MeansReference) AND HouseholdSize=5) THEN (SELECT CountyNonMort57 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County8
FROM MeansReference) AND HouseholdSize=1) THEN (SELECT CountyNonMort18 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County8
FROM MeansReference) AND HouseholdSize=2) THEN (SELECT CountyNonMort28 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County8
FROM MeansReference) AND HouseholdSize=3) THEN (SELECT CountyNonMort38 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County8
FROM MeansReference) AND HouseholdSize=4) THEN (SELECT CountyNonMort48 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County8
FROM MeansReference) AND HouseholdSize=5) THEN (SELECT CountyNonMort58 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County9
FROM MeansReference) AND HouseholdSize=1) THEN (SELECT CountyNonMort19 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County9
FROM MeansReference) AND HouseholdSize=2) THEN (SELECT CountyNonMort29 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County9
FROM MeansReference) AND HouseholdSize=3) THEN (SELECT CountyNonMort39 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County9
FROM MeansReference) AND HouseholdSize=4) THEN (SELECT CountyNonMort49 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County9
FROM MeansReference) AND HouseholdSize=5) THEN (SELECT CountyNonMort59 
FROM MeansReference)
ELSE 0 END)

UPDATE MeansTest
SET HousingMort=(CASE WHEN (MeansTest.County=(SELECT County1
FROM MeansReference) AND HouseholdSize=1) THEN (SELECT CountyMort11 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County1
FROM MeansReference) AND HouseholdSize=2) THEN (SELECT CountyMort21 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County1
FROM MeansReference) AND HouseholdSize=3) THEN (SELECT CountyMort31 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County1
FROM MeansReference) AND HouseholdSize=4) THEN (SELECT CountyMort41 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County1
FROM MeansReference) AND HouseholdSize=5) THEN (SELECT CountyMort51 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County2
FROM MeansReference) AND HouseholdSize=1) THEN (SELECT CountyMort12 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County2
FROM MeansReference) AND HouseholdSize=2) THEN (SELECT CountyMort22 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County2
FROM MeansReference) AND HouseholdSize=3) THEN (SELECT CountyMort32 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County2
FROM MeansReference) AND HouseholdSize=4) THEN (SELECT CountyMort42 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County2
FROM MeansReference) AND HouseholdSize=5) THEN (SELECT CountyMort52 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County3
FROM MeansReference) AND HouseholdSize=1) THEN (SELECT CountyMort13 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County3
FROM MeansReference) AND HouseholdSize=2) THEN (SELECT CountyMort23 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County3
FROM MeansReference) AND HouseholdSize=3) THEN (SELECT CountyMort33 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County3
FROM MeansReference) AND HouseholdSize=4) THEN (SELECT CountyMort43 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County3
FROM MeansReference) AND HouseholdSize=5) THEN (SELECT CountyMort53 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County4
FROM MeansReference) AND HouseholdSize=1) THEN (SELECT CountyMort14 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County4
FROM MeansReference) AND HouseholdSize=2) THEN (SELECT CountyMort24 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County4
FROM MeansReference) AND HouseholdSize=3) THEN (SELECT CountyMort34 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County4
FROM MeansReference) AND HouseholdSize=4) THEN (SELECT CountyMort44 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County4
FROM MeansReference) AND HouseholdSize=5) THEN (SELECT CountyMort54 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County5
FROM MeansReference) AND HouseholdSize=1) THEN (SELECT CountyMort15 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County5
FROM MeansReference) AND HouseholdSize=2) THEN (SELECT CountyMort25 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County5
FROM MeansReference) AND HouseholdSize=3) THEN (SELECT CountyMort35 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County5
FROM MeansReference) AND HouseholdSize=4) THEN (SELECT CountyMort45 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County5
FROM MeansReference) AND HouseholdSize=5) THEN (SELECT CountyMort55 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County6
FROM MeansReference) AND HouseholdSize=1) THEN (SELECT CountyMort16 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County6
FROM MeansReference) AND HouseholdSize=2) THEN (SELECT CountyMort26 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County6
FROM MeansReference) AND HouseholdSize=3) THEN (SELECT CountyMort36 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County6
FROM MeansReference) AND HouseholdSize=4) THEN (SELECT CountyMort46 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County6
FROM MeansReference) AND HouseholdSize=5) THEN (SELECT CountyMort56 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County7
FROM MeansReference) AND HouseholdSize=1) THEN (SELECT CountyMort17 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County7
FROM MeansReference) AND HouseholdSize=2) THEN (SELECT CountyMort27 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County7
FROM MeansReference) AND HouseholdSize=3) THEN (SELECT CountyMort37 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County7
FROM MeansReference) AND HouseholdSize=4) THEN (SELECT CountyMort47 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County7
FROM MeansReference) AND HouseholdSize=5) THEN (SELECT CountyMort57 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County8
FROM MeansReference) AND HouseholdSize=1) THEN (SELECT CountyMort18 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County8
FROM MeansReference) AND HouseholdSize=2) THEN (SELECT CountyMort28 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County8
FROM MeansReference) AND HouseholdSize=3) THEN (SELECT CountyMort38 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County8
FROM MeansReference) AND HouseholdSize=4) THEN (SELECT CountyMort48 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County8
FROM MeansReference) AND HouseholdSize=5) THEN (SELECT CountyMort58 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County9
FROM MeansReference) AND HouseholdSize=1) THEN (SELECT CountyMort19 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County9
FROM MeansReference) AND HouseholdSize=2) THEN (SELECT CountyMort29 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County9
FROM MeansReference) AND HouseholdSize=3) THEN (SELECT CountyMort39 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County9
FROM MeansReference) AND HouseholdSize=4) THEN (SELECT CountyMort49 
FROM MeansReference)
WHEN (MeansTest.County=(SELECT County9
FROM MeansReference) AND HouseholdSize=5) THEN (SELECT CountyMort59 
FROM MeansReference)
ELSE 0 END)

UPDATE MeansTest
SET TransOp=(CASE WHEN TransRegionsID=1
AND NumberOfCars=0 THEN (SELECT TransPublic1 FROM MeansReference
WHERE MeansReferenceID=1)
WHEN TransRegionsID=1
AND NumberOfCars=1 THEN (SELECT TransOpCosts11 FROM MeansReference
WHERE MeansReferenceID=1)
WHEN TransRegionsID=1
AND NumberOfCars>=2 THEN (SELECT TransOpCosts21 FROM MeansReference
WHERE MeansReferenceID=1)
WHEN TransRegionsID=2
AND NumberOfCars=0 THEN (SELECT TransPublic2 FROM MeansReference
WHERE MeansReferenceID=1)
WHEN TransRegionsID=2
AND NumberOfCars=1 THEN (SELECT TransOpCosts11 FROM MeansReference
WHERE MeansReferenceID=1)
WHEN TransRegionsID=2
AND NumberOfCars>=2 THEN (SELECT TransOpCosts21 FROM MeansReference
WHERE MeansReferenceID=1)
WHEN TransRegionsID=3
AND NumberOfCars=0 THEN (SELECT TransPublic3 FROM MeansReference
WHERE MeansReferenceID=1)
WHEN TransRegionsID=3
AND NumberOfCars=1 THEN (SELECT TransOpCosts11 FROM MeansReference
WHERE MeansReferenceID=1)
WHEN TransRegionsID=3
AND NumberOfCars>=2 THEN (SELECT TransOpCosts21 FROM MeansReference
WHERE MeansReferenceID=1)
ELSE 0 END)


UPDATE MeansTest
SET TransOwner=(CASE WHEN TransRegionsID=1 and NumberOfCarsOwedFor=1 THEN 
(SELECT TransOwnerCosts11 FROM MeansReference WHERE MeansReference.MeansReferenceID=1)
WHEN TransRegionsID=1
AND NumberOfCarsOwedFor>=2 THEN (SELECT TransOwnerCosts21 FROM MeansReference
WHERE MeansReference.MeansReferenceID=1) 
WHEN TransRegionsID=2 and NumberOfCarsOwedFor=1 THEN 
(SELECT TransOwnerCosts12 FROM MeansReference WHERE MeansReference.MeansReferenceID=1)
WHEN TransRegionsID=2
AND NumberOfCarsOwedFor>=2 THEN (SELECT TransOwnerCosts22 FROM MeansReference
WHERE MeansReference.MeansReferenceID=1) 
WHEN TransRegionsID=3 and NumberOfCarsOwedFor=1 THEN 
(SELECT TransOwnerCosts13 FROM MeansReference WHERE MeansReference.MeansReferenceID=1)
WHEN TransRegionsID=3
AND NumberOfCarsOwedFor>=2 THEN (SELECT TransOwnerCosts23 FROM MeansReference
WHERE MeansReference.MeansReferenceID=1) 
ELSE 0 END)

UPDATE MeansTest
SET HouseholdSizeOver65=(CASE WHEN(SELECT HouseholdMembersOver65 FROM Income WHERE
MeansTest.ClientID=Income.ClientID)>0 THEN
(SELECT HouseholdMembersOver65 FROM Income WHERE
MeansTest.ClientID=Income.ClientID) ELSE 0 END) 
UPDATE MeansTest
SET OutOfPocketHealth=(CASE WHEN((HouseholdSizeOver65*(SELECT SixtyFiveAndOver FROM
MeansReference))+((HouseholdSize-HouseholdSizeOver65)*(SELECT Under65 FROM
MeansReference)))>0 THEN 
((HouseholdSizeOver65*(SELECT SixtyFiveAndOver FROM
MeansReference))+((HouseholdSize-HouseholdSizeOver65)*(SELECT Under65 FROM
MeansReference))) ELSE 0 END)

UPDATE MeansTest
SET AdminMulti=(CASE WHEN (DistrictID=(SELECT DistrictID1 FROM MeansReference WHERE MeansReference.MeansReferenceID=1))
THEN (SELECT DistrictAdmin1 FROM MeansReference WHERE MeansReference.MeansReferenceID=1)
WHEN (DistrictID=(SELECT DistrictID2 FROM MeansReference WHERE MeansReference.MeansReferenceID=1))
THEN (SELECT DistrictAdmin2 FROM MeansReference WHERE MeansReference.MeansReferenceID=1) 
WHEN (District=(SELECT District3 FROM MeansReference WHERE MeansReference.MeansReferenceID=1))
THEN (SELECT DistrictAdmin3 FROM MeansReference WHERE MeansReference.MeansReferenceID=1) 
WHEN (District=(SELECT District4 FROM MeansReference WHERE MeansReference.MeansReferenceID=1))
THEN (SELECT DistrictAdmin4 FROM MeansReference WHERE MeansReference.MeansReferenceID=1) 
WHEN (District=(SELECT District5 FROM MeansReference WHERE MeansReference.MeansReferenceID=1))
THEN (SELECT DistrictAdmin5 FROM MeansReference WHERE MeansReference.MeansReferenceID=1) 
WHEN (District=(SELECT District6 FROM MeansReference WHERE MeansReference.MeansReferenceID=1))
THEN (SELECT DistrictAdmin6 FROM MeansReference WHERE MeansReference.MeansReferenceID=1) 
ELSE 0 END)
UPDATE MeansTest
SET EstimatedC13Total=(CASE WHEN(EstimatedC13Payments*EstimatedC13Term)>0
THEN (EstimatedC13Payments*EstimatedC13Term) ELSE 0	END)
UPDATE MeansTest
SET AdministrativeExpense=(CASE WHEN((AdminMulti*EstimatedC13Total)/60)>0
THEN ((AdminMulti*EstimatedC13Total)/60)ELSE 0 END)

UPDATE MeansTest
SET ActualHousingPayment=(CASE WHEN (SELECT PropertyRentPmt1 FROM 
RealProperty WHERE MeansTest.ClientID=RealProperty.ClientID)>0
THEN (SELECT PropertyRentPmt1 FROM 
RealProperty WHERE MeansTest.ClientID=RealProperty.ClientID)
WHEN(SELECT(Property1stMortPmt1+Property2ndMortPmt1+
Property3rdMortPmt1) FROM RealProperty WHERE 
MeansTest.ClientID=RealProperty.ClientID)>0 THEN 
(SELECT(Property1stMortPmt1+Property2ndMortPmt1+
Property3rdMortPmt1) FROM RealProperty WHERE 
MeansTest.ClientID=RealProperty.ClientID)ELSE 0 END)
UPDATE MeansTest
SET HigherOfActualHouseOrTable=(CASE WHEN (ActualHousingPayment>HousingMort)
THEN ActualHousingPayment ELSE HousingMort END)

UPDATE MeansTest
SET MortSecured2=(CASE WHEN(SELECT Property1stMortPmt2 FROM RealProperty 
WHERE MeansTest.ClientID=RealProperty.ClientID)>0 THEN
(SELECT(Property1stMortPmt2)FROM RealProperty 
WHERE MeansTest.ClientID=RealProperty.ClientID)ELSE 0 END)+ 
(CASE WHEN(SELECT Property2ndMortPmt2 FROM RealProperty 
WHERE MeansTest.ClientID=RealProperty.ClientID)>0 THEN
(SELECT(Property2ndMortPmt2)FROM RealProperty 
WHERE MeansTest.ClientID=RealProperty.ClientID)ELSE 0 END)+
(CASE WHEN(SELECT Property3rdMortPmt2 FROM RealProperty 
WHERE MeansTest.ClientID=RealProperty.ClientID)>0 THEN
(SELECT(Property3rdMortPmt2)FROM RealProperty 
WHERE MeansTest.ClientID=RealProperty.ClientID)ELSE 0 END)

UPDATE MeansTest
SET MortSecured3=(CASE WHEN(SELECT Property1stMortPmt3 FROM RealProperty 
WHERE MeansTest.ClientID=RealProperty.ClientID)>0 THEN
(SELECT(Property1stMortPmt3)FROM RealProperty 
WHERE MeansTest.ClientID=RealProperty.ClientID)ELSE 0 END)+ 
(CASE WHEN(SELECT Property2ndMortPmt3 FROM RealProperty 
WHERE MeansTest.ClientID=RealProperty.ClientID)>0 THEN
(SELECT(Property2ndMortPmt3)FROM RealProperty 
WHERE MeansTest.ClientID=RealProperty.ClientID)ELSE 0 END)+
(CASE WHEN(SELECT Property3rdMortPmt3 FROM RealProperty 
WHERE MeansTest.ClientID=RealProperty.ClientID)>0 THEN
(SELECT(Property3rdMortPmt3)FROM RealProperty 
WHERE MeansTest.ClientID=RealProperty.ClientID)ELSE 0 END)

UPDATE MeansTest
SET MortSecured4=(CASE WHEN(SELECT Property1stMortPmt4 FROM RealProperty 
WHERE MeansTest.ClientID=RealProperty.ClientID)>0 THEN
(SELECT(Property1stMortPmt4)FROM RealProperty 
WHERE MeansTest.ClientID=RealProperty.ClientID)ELSE 0 END)+ 
(CASE WHEN(SELECT Property2ndMortPmt4 FROM RealProperty 
WHERE MeansTest.ClientID=RealProperty.ClientID)>0 THEN
(SELECT(Property2ndMortPmt4)FROM RealProperty 
WHERE MeansTest.ClientID=RealProperty.ClientID)ELSE 0 END)+
(CASE WHEN(SELECT Property3rdMortPmt4 FROM RealProperty 
WHERE MeansTest.ClientID=RealProperty.ClientID)>0 THEN
(SELECT(Property3rdMortPmt4)FROM RealProperty 
WHERE MeansTest.ClientID=RealProperty.ClientID)ELSE 0 END)

UPDATE MeansTest
SET MortSecured5=(CASE WHEN(SELECT Property1stMortPmt5 FROM RealProperty 
WHERE MeansTest.ClientID=RealProperty.ClientID)>0 THEN
(SELECT(Property1stMortPmt5)FROM RealProperty 
WHERE MeansTest.ClientID=RealProperty.ClientID)ELSE 0 END)+ 
(CASE WHEN(SELECT Property2ndMortPmt5 FROM RealProperty 
WHERE MeansTest.ClientID=RealProperty.ClientID)>0 THEN
(SELECT(Property2ndMortPmt5)FROM RealProperty 
WHERE MeansTest.ClientID=RealProperty.ClientID)ELSE 0 END)+
(CASE WHEN(SELECT Property3rdMortPmt5 FROM RealProperty 
WHERE MeansTest.ClientID=RealProperty.ClientID)>0 THEN
(SELECT(Property3rdMortPmt5)FROM RealProperty 
WHERE MeansTest.ClientID=RealProperty.ClientID)ELSE 0 END)


UPDATE MeansTest
SET Vehicle3=(CASE WHEN(SELECT (VehicleLoan1Balance3) FROM
Vehicles WHERE MeansTest.ClientID=Vehicles.ClientID)/60>0 THEN
(SELECT (VehicleLoan1Balance3)/60 FROM Vehicles WHERE MeansTest.ClientID=Vehicles.ClientID) ELSE 0 
END)+(CASE WHEN(SELECT (VehicleLoan2Balance3/60) FROM
Vehicles WHERE MeansTest.ClientID=Vehicles.ClientID)/60>0 THEN
(SELECT (VehicleLoan2Balance3/60) FROM Vehicles WHERE MeansTest.ClientID=Vehicles.ClientID)ELSE 0 
END)
UPDATE MeansTest
SET Vehicle4=(CASE WHEN(SELECT (VehicleLoan1Balance4) FROM
Vehicles WHERE MeansTest.ClientID=Vehicles.ClientID)/60>0 THEN
(SELECT (VehicleLoan1Balance4)/60 FROM Vehicles 
WHERE MeansTest.ClientID=Vehicles.ClientID) ELSE 0 
END)+(CASE WHEN(SELECT (VehicleLoan2Balance4) FROM
Vehicles WHERE MeansTest.ClientID=Vehicles.ClientID)/60>0 THEN
(SELECT (VehicleLoan2Balance4)/60 FROM Vehicles 
WHERE MeansTest.ClientID=Vehicles.ClientID)ELSE 0 
END)
UPDATE MeansTest
SET Vehicle5=(CASE WHEN(SELECT (VehicleLoan1Balance5) FROM
Vehicles WHERE MeansTest.ClientID=Vehicles.ClientID)/60>0 THEN
(SELECT (VehicleLoan1Balance5)/60 FROM Vehicles 
WHERE MeansTest.ClientID=Vehicles.ClientID) ELSE 0 
END)+(CASE WHEN(SELECT (VehicleLoan2Balance5) FROM
Vehicles WHERE MeansTest.ClientID=Vehicles.ClientID)/60>0 THEN
(SELECT (VehicleLoan2Balance5)/60 FROM Vehicles 
WHERE MeansTest.ClientID=Vehicles.ClientID) ELSE 0 
END)
UPDATE MeansTest
SET Vehicle6=(CASE WHEN(SELECT (VehicleLoan1Balance6) FROM
Vehicles WHERE MeansTest.ClientID=Vehicles.ClientID)/60>0 THEN
(SELECT (VehicleLoan1Balance6)/60 FROM Vehicles 
WHERE MeansTest.ClientID=Vehicles.ClientID)ELSE 0 
END)+(CASE WHEN(SELECT (VehicleLoan2Balance6) FROM
Vehicles WHERE MeansTest.ClientID=Vehicles.ClientID)/60>0 THEN
(SELECT (VehicleLoan2Balance6)/60 FROM Vehicles 
WHERE MeansTest.ClientID=Vehicles.ClientID)ELSE 0 
END)
UPDATE MeansTest
SET Vehicle7=(CASE WHEN(SELECT (VehicleLoan1Balance7) FROM
Vehicles WHERE MeansTest.ClientID=Vehicles.ClientID)/60>0 THEN
(SELECT (VehicleLoan1Balance7)/60 FROM Vehicles 
WHERE MeansTest.ClientID=Vehicles.ClientID)ELSE 0 
END)+(CASE WHEN(SELECT (VehicleLoan2Balance7) FROM
Vehicles WHERE MeansTest.ClientID=Vehicles.ClientID)/60>0 THEN
(SELECT (VehicleLoan2Balance7)/60 FROM Vehicles 
WHERE MeansTest.ClientID=Vehicles.ClientID)ELSE 0 
END)


UPDATE MeansTest
SET SecuredDebt1=(CASE WHEN(SELECT SecuredDebtAmt1 FROM SecuredDebts 
WHERE MeansTest.ClientID=SecuredDebts.ClientID)/60>0 THEN
(SELECT SecuredDebtAmt1 FROM SecuredDebts 
WHERE MeansTest.ClientID=SecuredDebts.ClientID)/60 ELSE 0
END)
UPDATE MeansTest
SET SecuredDebt2=(CASE WHEN(SELECT SecuredDebtAmt2 FROM SecuredDebts 
WHERE MeansTest.ClientID=SecuredDebts.ClientID)/60>0 THEN
(SELECT SecuredDebtAmt2 FROM SecuredDebts 
WHERE MeansTest.ClientID=SecuredDebts.ClientID)/60 ELSE 0
END)
UPDATE MeansTest
SET SecuredDebt3=(CASE WHEN(SELECT SecuredDebtAmt3 FROM SecuredDebts 
WHERE MeansTest.ClientID=SecuredDebts.ClientID)/60>0 THEN
(SELECT SecuredDebtAmt3 FROM SecuredDebts 
WHERE MeansTest.ClientID=SecuredDebts.ClientID)/60 ELSE 0
END)
UPDATE MeansTest
SET SecuredDebt4=(CASE WHEN(SELECT SecuredDebtAmt4 FROM SecuredDebts 
WHERE MeansTest.ClientID=SecuredDebts.ClientID)/60>0 THEN
(SELECT SecuredDebtAmt4 FROM SecuredDebts 
WHERE MeansTest.ClientID=SecuredDebts.ClientID)/60 ELSE 0
END)
UPDATE MeansTest
SET SecuredDebt5=(CASE WHEN(SELECT SecuredDebtAmt5 FROM SecuredDebts 
WHERE MeansTest.ClientID=SecuredDebts.ClientID)/60>0 THEN
(SELECT SecuredDebtAmt5 FROM SecuredDebts 
WHERE MeansTest.ClientID=SecuredDebts.ClientID)/60 ELSE 0
END)
UPDATE MeansTest
SET SecuredDebt6=(CASE WHEN(SELECT SecuredDebtAmt6 FROM SecuredDebts 
WHERE MeansTest.ClientID=SecuredDebts.ClientID)/60>0 THEN
(SELECT SecuredDebtAmt6 FROM SecuredDebts 
WHERE MeansTest.ClientID=SecuredDebts.ClientID)/60 ELSE 0
END)
UPDATE MeansTest
SET SecuredDebt7=(CASE WHEN(SELECT SecuredDebtAmt7 FROM SecuredDebts 
WHERE MeansTest.ClientID=SecuredDebts.ClientID)/60>0 THEN
(SELECT SecuredDebtAmt7 FROM SecuredDebts 
WHERE MeansTest.ClientID=SecuredDebts.ClientID)/60 ELSE 0
END)




UPDATE MeansTest
SET MeansTestNetHouseholdIncome=TakeHomeHouseholdIncome-(NationalStandard+
HousingNonMort+HigherOfActualHouseOrTable+TransOp+TransOwner+
OutOfPocketHealth+AdministrativeExpense+MortSecured2+MortSecured3+
MortSecured4+MortSecured5+Vehicle3+Vehicle4+Vehicle5+Vehicle6+
Vehicle7+SecuredDebt1+SecuredDebt2+SecuredDebt3+SecuredDebt4+SecuredDebt5+
SecuredDebt6+SecuredDebt7+TotalOtherMeansTestDeductions)

FROM  MeansTest, BasicInfo
WHERE MeansTest.ClientID=BasicInfo.ClientID 

END