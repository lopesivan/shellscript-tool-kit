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

#
# --bakefile-help
#
parser.add_option('', '--bakefile-help',
	dest    = "bakefile_help",
	default = False,
	action  = "store_true",
	help    = "Bakefile test"
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
#  --wx-samples
#
parser.add_option( '', '--wx-samples',
	dest    = "wx_samples",
	default = False,
	action  = "store_true",
	help    = "Set wx samples."
)

##############################################################################
# ----------------------------------------------------------------------------
##############################################################################

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
#
# -p, --platform
#
parser.add_option('-p', '--platform',
	dest    = "platform",
	default = "NONE",
	help    = "Define Operation system target"
)
#
# --project
#
parser.add_option('', '--project',
	dest    = "project",
	default = "NONE",
	help    = "Define project target"
)
#
# --action
#
parser.add_option('-a', '--action',
	dest    = "action",
	default = "build",
	help    = "Define action on target"
)
#
# -n, --name
#
parser.add_option('-n', '--name',
	dest    = "name",
	default = "NONE",
	help    = "Define iname of target"
)
#
# --test
#
parser.add_option('-T', '--test',
	dest    = "test",
	default = "0",
	type    = "int",
	help    = "Define action on target"
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
	print 'DEBUG      : ', options.debug
	print 'ARGV       : ', sys.argv[1:]
	print 'VERBOSE    : ', options.verbose
	print 'TURN ON    : ', options.onOff
	print 'BAKEFILE   : ', options.bakefile_help
	print 'EXAMPLES   : ', options.examples
	print 'WX-SAMPLES : ', options.wx_samples
	#
	# Set options
	#
	print 'OUTPUT     :', options.output_dest
	print 'LANG       :', options.lang
	print 'PLATFORM   :', options.platform
	print 'ACTION     :', options.action
	print 'PROJECT    :', options.project
	print 'TEST       :', options.test
	print 'NAME       :', options.name

# ----------------------------------------------------------------------------
# functions:

def build_boost_sample_01():
	boost_prj_dir =\
	r"C:\workspace\boost-projects\src\boost-projects\samples\ex-01"
	os.chdir(boost_prj_dir)
	os.system("clean.bat")
	os.system("gen-make.bat")
	os.system("build-make.bat")

def build_wx_samples(d, a):

	Dirs = [
'aui'       , 'calendar'    , 'caret'    , 'checklst' ,
'collpane'  , 'combo'       , 'config'   , 'console'  ,
'dataview'  , 'db'          , 'debugrpt' , 'dialogs'  ,
'dialup'    , 'display'     , 'dnd'      , 'docview'  ,
'docvwmdi'  , 'dragimag'    , 'drawing'  , 'dynamic'  ,
'erase'     , 'event'       , 'except'   , 'exec'     ,
'font'      , 'grid'        , 'htlbox'   , 'image'    ,
'ipc'       , 'joytest'     , 'keyboard' , 'layout'   ,
'listbox'   , 'mediaplayer' , 'memcheck' , 'menu'     ,
'mfc'       , 'multimon'    , 'nativdlg' , 'notebook' ,
'oleauto'   , 'ownerdrw'    , 'png'      , 'popup'    ,
'power'     , 'printing'    , 'propsize' , 'regtest'  ,
'render'    , 'rotate'      , 'sashtest' , 'scroll'   ,
'scrollsub' , 'shaped'      , 'sockets'  , 'sound'    ,
'splash'    , 'splitter'    , 'statbar'  , 'taskbar'  ,
'text'      , 'thread'      , 'treectrl' , 'typetest' ,
'validate'  , 'vscroll'     , 'wizard'   , 'access'   ,
'artprov'   , 'animate'     , 'controls' , 'help'     ,
'listctrl'  , 'mdi'         , 'minifram' , 'richtext' ,
'toolbar'   , 'widgets'     , 'xrc'      , 'minimal'  ,
'mobile'    , 'opengl'      ,
]

	if Dirs.count(d):
		os.chdir('C:\wxWidgets-2.8.11\samples\%s' % (d) )

		# --wx-sample -a build -n animate
		# --wx-sample -n animate
		if a == "build"   :
			os.system("clean.bat")
			os.system("gen-Makefile.bat")
			os.system("build-Makefile.bat")

		# --wx-sample -a clean -n animate 
		if a == "clean"   :
			os.system("clean.bat")

		# --wx-sample -a rebuild -n animate 
		if a == "rebuild" :
			os.system("clean.bat")
			os.system("gen-Makefile.bat")
			os.system("build-Makefile.bat")

	else:
		for dir in Dirs:
			print dir

			os.chdir('C:\wxWidgets-2.8.11\samples\%s' % (dir) )

			# --wx-sample -a build
			# --wx-sample
			if a == "build"   :
				os.system("clean.bat")
				os.system("gen-Makefile.bat")
				os.system("build-Makefile.bat")

			# --wx-sample -a clean
			if a == "clean"   :
				os.system("clean.bat")

			# --wx-sample -a rebuild
			if a == "rebuild" :
				os.system("clean.bat")
				os.system("gen-Makefile.bat")
				os.system("build-Makefile.bat")

# ----------------------------------------------------------------------------

#
# Show commands examples
#
if options.examples == True :
	examples="""
** Show workspace dir on Linux
easybuild -d -p linux

** Show workspace dir on Windows
easybuild -d -p win

** Show bakefile help
easybuild --bakefile-help

** build wx samples
easybuild --wx-sample -a clean -n animate
easybuild --wx-sample -a rebuild -n animate
easybuild --wx-sample


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
# ----------------------------------------------------------------------------

#
# Do $ bakefile -h
#
if options.bakefile_help == True :
	args = []
	args.append("-h")
	os.system("bakefile " + " ".join(args) )
# ----------------------------------------------------------------------------

#
# Do WX-samples
#
if options.wx_samples == True :
	# --wx-sample -a build
	# --wx-sample
	# --wx-sample -a clean
	# --wx-sample -a rebuild
	build_wx_samples(options.name, options.action)

# ----------------------------------------------------------------------------

#
# Do test
#
if options.test == 1 :
	#build_boost_sample_01()
	build_wx_samples()

# ----------------------------------------------------------------------------
#
# PWD on workspace ...
#
if options.debug == True :

	if options.platform == "linux" :
		user = "ivan"
		os.chdir('/home/%s/workspace' % user)
		os.system("pwd")

	if options.platform == "win" :
		os.chdir(r'C:\workspace')
		os.system("cd")

# Processing
# ============================================================================

# ============================================================================
print "Bye!"
