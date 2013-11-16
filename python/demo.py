#!/usr/bin/env python
#import sys
import json
import requests
from optparse import OptionParser

WSAPI = '''https://api.cloudacl.com/webfiltering-webapp/webapi/webcategories/getCategoryByUrl?url=%s&key=%s'''

def get_category(url, key):
    url = WSAPI %(url, key)
    rsp = requests.get(url)
    json = rsp.json()
    return json

def main():
    parser = OptionParser(usage="%prog -k key <website>", version="%prog 1.0")
    parser.add_option("-k", "--key", dest="key", default="nokey", help="key", metavar="KEY")
    (options, args) = parser.parse_args()
    if len(args) == 0:
        OptionParser.print_usage(parser)
        sys.exit()

    site = args[0]
    result = get_category(site.encode('utf-8'), options.key.encode('utf-8'))

    if 'url' in result:
        print "id: %s url: %s desc: %s" %(result['id'], result['url'], result['desc'])
    else:
        print "code: %s message: %s" %(result['id'], result['desc'])

if __name__ == '__main__':
    main()
