#!/usr/bin/env python

'''

  Extracts a list of videos from a Youtube playlist.
  You'll need the playlist id, which is found in the playlist url, for example,

    www.youtube.com/view_play_list?p=643EDF14B9523A86

  The playlist id is "643EDF14B9523A86"

  Usage: yt-playlist_videos.py <playlist id>

    yt-playlist_videos.py 643EDF14B9523A86


  This script will output to stdout, so if you want something else, edit it.
  You can redirect stdout to a file too.

  The script is pretty simple, no error checking, etc. The unfortunate part
  is requiring an external library, namely lxml, to do XML parsing, since
  xml.etree.ElementTree can't handle namespaces in its ElementPath searchs.

  So, to run it, you'll need lxml [http://pypi.python.org/pypi/lxml].

'''

import sys

if sys.version_info < (2.6):
    print "This script requires Python version 2.6 or greater"
    sys.exit(1)

import re
import urllib2

try:
    from lxml import etree
except ImportError:
    print "This script requires lxml [http://pypi.python.org/pypi/lxml] to run"
    sys.exit(1)

PLAYLISTS_URL = "http://gdata.youtube.com/feeds/api/playlists/{0}?v=2"

def get_feed(pid):
    url = PLAYLISTS_URL.format(pid)
    res = urllib2.urlopen(url)
    # no error-checking here, it's sad.
    return res.read()

def get_videos(feed):
    doc = etree.fromstring(feed)
    videos = doc.xpath('atom:entry/media:group/media:content[@yt:format=5]',
        namespaces = { 'atom' : 'http://www.w3.org/2005/Atom',
                       'media' : 'http://search.yahoo.com/mrss/',
                       'yt' : 'http://gdata.youtube.com/schemas/2007'})
    return videos

def main():
    pid = sys.argv[1]
    feed = get_feed(pid)
    videos = get_videos(feed)
    for v in videos:
        print v.get('url')

if __name__ == '__main__':
    main()
