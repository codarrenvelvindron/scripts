#!/usr/bin/env bash
count=0
rm -rf oldquotes.txt

while [ $count -le 14 ]
do
  cat weeklyquote.json | jq ".[] | .q[$count].quote" >> oldquotes.txt
  cat weeklyquote.json | jq ".[] | .q[$count].author" >> oldquotes.txt
  (( count++ ))
done
