#!/bin/bash
#
# sel_ldr.bash
# A simple shell script for starting up sel_ldr with an enhanced
# library path, for Linux. This allows us to install libraries in
# a user directory rather than having to put them someplace like
# /usr/lib
#
export PATH=$PATH:/opt/"Balsamiq Mockups"/bin:/usr/lib/x86_64-linux-gnu/
exec BM $@

