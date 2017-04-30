sudo iptables -t nat -A OUTPUT -p tcp --dport 1935 -j REDIRECT
svn://svn.mplayerhq.hu/rtmpdump/tags/rel-2.3

sudo iptables -t nat -D OUTPUT -p tcp --dport 1935 -j REDIRECT
