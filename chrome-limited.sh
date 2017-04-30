#!/bin/sh
ulimit -Sv 10240000 #amount of memory available in bytes
/usr/bin/google-chrome-stable "$@"
