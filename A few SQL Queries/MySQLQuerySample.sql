/* These queries are part of a stored procedure that is being used on MySQL. 
I believe it would work the same on SQL Server. I have a lot of procedures using both versions of SQL.
I can find some that uses the unique methods of one or the other if necessary.
*/


INSERT INTO Service1Processor (CaseNumber, ServiceDate, Attorney, County)
SELECT S1.CaseNumber, S1.ServiceDate, S1.Attorney,  S1H.County FROM Service1 S1
INNER JOIN Service1Holder S1H
ON S1.CaseNumber = S1H.CaseNumber
AND S1.County = S1H.County;

UPDATE Service1Processor
SET Defendant = (SELECT S1H.Defendant FROM Service1Holder S1H INNER JOIN Service1 S1 ON S1.CaseNumber = S1H.CaseNumber
AND S1.County = S1H.County WHERE S1H.CaseNumber = Service1Processor.CaseNumber AND S1H.County = Service1Processor.County) ,
Address = (SELECT S1H.Address FROM Service1Holder S1H INNER JOIN Service1 S1 ON S1.CaseNumber = S1H.CaseNumber
AND S1.County = S1H.County WHERE S1H.CaseNumber = Service1Processor.CaseNumber AND S1H.County = Service1Processor.County),
Address2 = (SELECT S1H.Address2 FROM Service1Holder S1H INNER JOIN Service1 S1 ON S1.CaseNumber = S1H.CaseNumber
AND S1.County = S1H.County WHERE S1H.CaseNumber = Service1Processor.CaseNumber AND S1H.County = Service1Processor.County),
 City= (SELECT S1H.City FROM Service1Holder S1H INNER JOIN Service1 S1 ON S1.CaseNumber = S1H.CaseNumber
AND S1.County = S1H.County WHERE S1H.CaseNumber = Service1Processor.CaseNumber AND S1H.County = Service1Processor.County),
State= (SELECT S1H.State FROM Service1Holder S1H INNER JOIN Service1 S1 ON S1.CaseNumber = S1H.CaseNumber
AND S1.County = S1H.County WHERE S1H.CaseNumber = Service1Processor.CaseNumber AND S1H.County = Service1Processor.County),
Zip= (SELECT S1H.Zip FROM Service1Holder S1H INNER JOIN Service1 S1 ON S1.CaseNumber = S1H.CaseNumber
AND S1.County = S1H.County WHERE S1H.CaseNumber = Service1Processor.CaseNumber AND S1H.County = Service1Processor.County),
CaseCaption= (SELECT S1H.CaseCaption FROM Service1Holder S1H INNER JOIN Service1 S1 ON S1.CaseNumber = S1H.CaseNumber
AND S1.County = S1H.County WHERE S1H.CaseNumber = Service1Processor.CaseNumber AND S1H.County = Service1Processor.County),
LawsuitDate= (SELECT S1H.LawsuitDate FROM Service1Holder S1H INNER JOIN Service1 S1 ON S1.CaseNumber = S1H.CaseNumber
AND S1.County = S1H.County WHERE S1H.CaseNumber = Service1Processor.CaseNumber AND S1H.County = Service1Processor.County),
Amount= (SELECT S1H.Amount FROM Service1Holder S1H INNER JOIN Service1 S1 ON S1.CaseNumber = S1H.CaseNumber
AND S1.County = S1H.County WHERE S1H.CaseNumber = Service1Processor.CaseNumber AND S1H.County = Service1Processor.County),
County= (SELECT S1H.County FROM Service1Holder S1H INNER JOIN Service1 S1 ON S1.CaseNumber = S1H.CaseNumber
AND S1.County = S1H.County WHERE S1H.CaseNumber = Service1Processor.CaseNumber AND S1H.County = Service1Processor.County),
CaseType= (SELECT S1H.CaseType FROM Service1Holder S1H INNER JOIN Service1 S1 ON S1.CaseNumber = S1H.CaseNumber
AND S1.County = S1H.County WHERE S1H.CaseNumber = Service1Processor.CaseNumber AND S1H.County = Service1Processor.County);


