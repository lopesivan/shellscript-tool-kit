# This is a comment
# comments can span one line only

import socket
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.connect(('google.com', 0))

print "MyIP = %s" % s.getsockname()[0]
