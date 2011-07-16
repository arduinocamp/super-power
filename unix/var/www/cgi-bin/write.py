#!/usr/bin/python

import cgi
import cgitb

from sqlite3 import *

cgitb.enable(display=0,logdir="/tmp")

print "Content-type: text/html"
print 


form=cgi.FieldStorage()
p1=form["D1"].value
p2=form["D2"].value
conn = connect('sample.db')
curs = conn.cursor()
curs.execute("insert into T1 values\
            (:p1,:p2)", {"p1":p1, "p2":p2})
conn.commit()

print "#"
print p1
print "#"
print p2
print "#"



