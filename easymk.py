#!/usr/bin/env python
# -*- coding: utf-8 -*-

import optparse
import sys
import os
import re

parser = optparse.OptionParser(usage="%prog -[ [d|1|v|o] -[debug|turn-on|verbose|output] ]", version="%prog 1.0")

##############################################################################
##############################################################################
##############################################################################

#
# on/off options
# ##############

#
# -d, --debug
#
parser.add_option( '-d', '--debug',
				  dest    = "debug",
				  default = False,
				  action  = "store_true",
				  help    = "Active Debug mode."
				 )
#
# -1, --turn-on
#
parser.add_option('-1', '--turn-on',
				  dest    = "onOff",
				  default = False,
				  action  = "store_true",
				  help    = "Enable inner flags"
				 )
#
# -v, --verbose
#
parser.add_option('-v', '--verbose',
				  dest    = "verbose",
				  default = False,
				  action  = "store_true",
				  help    = "Active verbose mode"
				 )

# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------

#
# -p, --with-prerequisite
#
parser.add_option('-p', '--with-prerequisite',
				  dest    = "prerequisite",
				  default = False,
				  action  = "store_true",
				  help    = "Makefile with prerequisite"
				 )
#
# -e, --examples
#
parser.add_option( '-e', '--examples',
				  dest    = "examples",
				  default = False,
				  action  = "store_true",
				  help    = "Show Examples."
				 )

#
# Set options
# ###########
#

#
# -o, --output
#
parser.add_option('-o', '--output',
				  dest    = "output_dest",
				  default = "a.out",
				  help    = "Define stdout FILE"
				 )

#
# -t, --lang
#
parser.add_option('-t', '--lang',
				  dest    = "lang",
				  default = "c",
				  help    = "Define language target"
				 )

##############################################################################
##############################################################################
##############################################################################
options, remainder = parser.parse_args()
##############################################################################

if options.debug == True :
	#
	# OnOff - options
	#
	print ('DEBUG         :', options.debug        )

	print ('ARGV          :', sys.argv[1:]         )
	print ('VERBOSE       :', options.verbose      )
	print ('TURN ON       :', options.onOff        )
	print ('PREREQUISITE  :', options.prerequisite )
	print ('EXAMPLES      :', options.examples     )

	print ('OUTPUT        :', options.output_dest  )
	print ('LANG          :', options.lang         )
# end if

if options.examples == True :
	examples="""
$ easymk -d -p  *.c

$ easymk -p *.c
$ easymk -p *.c --with-prerequisite
$ easymk -p -t cpp *.cpp
$ easymk -p --language cpp *.cpp
$ easymk -p --language cpp *

asasasasasas
	asasasasasasas
"""
	print examples

# end if

# Processing
# ============================================================================

#
# C language ...
#
lang = "c"
if (options.lang == lang )  :

	if (options.prerequisite == True)  :

		args = []

		for arg in sys.argv[2:]:
			str   = arg
			match = re.search("^.+\.c$", str)

			if match:
				if options.debug == True :
					print match.group()
				# end if

				# get main.c
				getmain = re.search("^main\.c$", str)
				if getmain:
					mainsource = getmain.group()
					args.insert(0, mainsource)
				else:
					args.append(match.group())
				# end if
			# end if
		# end for

		if options.debug == True :
			print " ".join(args)
		else:
			os.system("makefile-cansi-with-prerequisite " + " ".join(args) )
		# end if
	else:

		args = []

		for arg in sys.argv[2:]:
			str   = arg
			match = re.search("^.+\.c$", str)

			if match:
				if options.debug == True :
					print match.group()
				# end if

				# get main.c
				getmain = re.search("^main\.c$", str)
				if getmain:
					mainsource = getmain.group()
					args.insert(0, mainsource)
				else:
					args.append(match.group())
				# end if
			# end if
		# end for

		if options.debug == True :
			print " ".join(args)
		else:
			os.system("makefile-cansi-without-prerequisite" + " ".join(args) )
		# end if
	# end if
# end if




