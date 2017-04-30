#!/bin/bash
# vi:set nu nowrap:
# stopsrevices.sh: <+ =Short Description= +>.

# $Id:$
# Federal University of Rio de Janeiro
#      Author: Ivan carlos da Silva Lopes
#        Mail: lopesivan (dot) ufrj (at) gmail (dot) com
#     License: gpl
#    Language: Shell Script
#        File: stopsrevices.sh
#        Date: Qua 15 Set 2010 04:33:51 BRT
# Description:
#
#

# ----------------------------------------------------------------------------
sudo service flumotion stop
sudo /etc/init.d/proftpd stop
sudo service tomcat6 stop
sudo apache2ctl stop
sudo /etc/init.d/postfix stop
sudo ${HOME}/src/red5/red5-shutdown.sh
# ----------------------------------------------------------------------------
exit 0
