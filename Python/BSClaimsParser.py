#!/usr/bin/python2.7
import cgi
import re
from mechanize import Browser
from bs4 import BeautifulSoup
import MySQLdb

# THIS IS A PARSER FOR A SCRAPER OF A TRUSTEE'S CLAIMS REGISTER

db = MySQLdb.connect("XXX","XXX","XXX","XXX" ) 

cursor = db.cursor() 

mech = Browser()

url = "http://127.0.0.1/Claims_files/basic.html"
page = mech.open(url)




soup = BeautifulSoup(page, "html5")

MainTable = soup.find('table')

table = soup.findAll("table")[0].find("table")

rows = table.findAll('tr') 




for row in rows:
    cols = row.find_all("td")
    CaseNumber = re.findall("[1][3-4]\d\d\d\d\d", str(MainTable))[0]
    Category = cols[2].get_text()
    Category = Category.encode("ascii", "ignore")
    Category = Category.strip()
    Creditor = cols[4].get_text()
    Creditor = Creditor.encode("ascii", "ignore")
    Creditor = Creditor.strip()
    Method = cols[6].get_text()
    Method = Method.encode("ascii", "ignore")
    Method = Method.strip()
    PayPercent = cols[7].get_text()
    PayPercent = PayPercent.encode("ascii", "ignore")
    PayPercent = PayPercent.strip()
    Amount = cols[8].get_text()
    Amount = Amount.encode("ascii", "ignore")
    Amount = Amount.strip()
    print (CaseNumber, Category, Creditor, Method, PayPercent, Amount)
    
    cursor.execute('''INSERT INTO TrusteeClaims(CaseNumber, Category,
         Creditor, Method, PayPercent, Amount)
         VALUES (%s, %s, %s, %s, %s, %s)''', (CaseNumber, Category, Creditor, Method, PayPercent, Amount))
    db.commit()

db.close()



