#!/usr/bin/python

import cgi
import cgitb

from sqlite3 import *

cgitb.enable(display=0,logdir="/tmp")

print "Content-type: text/html"
print 


form=cgi.FieldStorage()
par=form["D1"].value
conn = connect('sample.db')
curs = conn.cursor()
#curs.execute("insert into T1 values\
#            ('Bread','basket')")
#conn.commit()
a=curs.execute("select D2 from T1 where D1=:par", {"par":par}).fetchone()[0]


print "#"
print a
print "#"


