#!/usr/bin/python2.7
import cgitb
cgitb.enable()
import cgi
import re
from mechanize import Browser
from bs4 import BeautifulSoup
import MySQLdb
import string

#THIS IS A PARSER FOR FANTASY FOOTBALL DATA

db = MySQLdb.connect("XXX","XXX","XXX","XXX" ) 

cursor = db.cursor() 

mech = Browser()

url = "http://127.0.0.1/FootballQB.html"
page = mech.open(url)

soup = BeautifulSoup(page, "html5")

MainTable = soup.find('table class="data borderTop" width="100%"')


table = soup.findAll('table')[4]   



for j in range(3, 16): 
    

    rows = table.findAll('tr')[j] 

    Name = soup.title    

    cols = rows.find_all("td")
    GameDate = cols[0].get_text()
    Opp = cols[1].get_text()
    PassingYDS = cols[6].get_text()
    PassingTDS = cols[8].get_text()
    RushingYDS = cols[11].get_text()
    RushingTDS = cols[13].get_text()

    

    cursor.execute('''INSERT INTO QBOutput(GameDate, Opp, PassingYDS, PassingTDS, RushingYDS, RushingTDS, Name)
         VALUES (%s, %s, %s, %s, %s, %s, %s)''', (GameDate, Opp, PassingYDS, PassingTDS, RushingYDS, RushingTDS, Name))
    db.commit() 

db.close()

