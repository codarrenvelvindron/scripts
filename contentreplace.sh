#!/usr/bin/env bash

cp -rp weeklyquote.json weeklyquote.json_old

while IFS= read -r line1 && IFS= read -r line2 <&3; do
  sed -i "s/$line1/$line2/" weeklyquote.json
done <oldquotes.txt 3<formatted.txt
