#!/bin/bash

# ----------------------------------------------------------------------------
LD_LIBRARY_PATH=/usr/lib/xulrunner-1.9.0.5/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH

/usr/lib/xulrunner-1.9.0.5/xpcshell $@
# ----------------------------------------------------------------------------
exit 0
