/* This query is part of a MySQL stored procedure and it would not 
work on SQL Server */


SELECT Defendant, Address, Address2, City, State, Zip,
CaseCaption, CaseNumber, LawsuitDate, 
Plaintiff, Amount, County, CaseType, Attorney , ServiceDate
INTO OUTFILE '/var/lib/mysql-files/ServiceOutput.xls'
FIELDS TERMINATED BY "\t"
ENCLOSED BY ""
LINES TERMINATED BY "\n"
FROM Service1Processor;

