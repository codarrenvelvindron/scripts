#!/usr/bin/env python

from bs4 import BeautifulSoup as BS
import requests
import argparse
import sys

def parse_args():
  parser = argparse.ArgumentParser()
  parser.add_argument('-t', '--topic', help='enter topic for quotes')
  return parser.parse_args()

def test_url(u):
  r = requests.get(u)
  sc = r.status_code
  if (sc == 404):
    print ("Topic not found!")
    return 1
  else:
    print ("We found your topic")
    return 0

def get_quotes(u):
  #headers = {'User-Agent': 'Mozilla/5.0'}
  page = requests.get(u)
  soup = BS(page.content, 'html.parser')
  for img in soup.find_all('img', alt=True):
    f.write (img['alt'] + "\n")

if __name__ == "__main__":
  args = parse_args()
  if not args.topic:
    sys.exit('[!] Please enter a topic: ./quote_extract.py -t "quotetopic"')

  maintopic = args.topic
  urltopic = "https://www.brainyquote.com/topics/" + str(maintopic)

  url_exists = test_url(urltopic) #if it returns 0 url exists and we continue
  if (url_exists == 0):
    f = open("brainy_quotes.txt", "w+")
    get_quotes(urltopic)
    f.close()
  else:
    print "Goodbye!"
