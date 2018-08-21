#!/usr/bin/env bash

echo "Please enter topic for quotes ! (source: www.brainyquote.com/topics/"
read topic
echo "1. Extracting quotes\n"
./quoteextract.py -t $topic
qc=$(cat brainy_quotes.txt | wc -l)
if [ $qc -lt 30 ]
then
  echo "quote count is $qc...exiting"
  exit 1
else
  sleep 1
  echo "2. Removing noise"
  ./excessremoval.sh
  sleep 1
  echo "3. Formatting...Adding quotes"
  ./formatter.sh
  sleep 1
  echo "4. Extracting data from weeklyquote.json"
  ./dataextract.sh
  sleep 1
  echo "5. Backing up and adding new quots to weeklyquote.json"
  ./contentreplace.sh
  sleep 1
  echo "Done! Your new quotes are in weeklyquote.json"
fi
