#!/usr/bin/env python
import sys
import json
import requests
from optparse import OptionParser

WSAPI = '''https://api.cloudacl.com/webapi/getcategory?uri=%s&key=%s'''

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

    if result['errorcode']==0:
        print "errorcode: %d id: %s url: %s desc: %s" %(result['errorcode'], result['id'], result['url'], result['desc'])
    else:
        print "errorcode: %d message: %s" %(result['errorcode'], result['desc'])

if __name__ == '__main__':
    main()
