#!/usr/bin/env python
# -*- coding: utf-8 -*-

cmd = 'convert -size 1000x1000 xc:white -strokewidth 1 '

for i in range(0, 999, 100):
  cmd += "-draw 'line "+str(i)+",0 "+str(i)+",999' "

for i in range(0, 999, 100):
  cmd += "-draw 'line 0,"+str(i)+" 999,"+str(i)+"' "

cmd += "grid.jpg"

print cmd
