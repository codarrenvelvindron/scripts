#!/bin/bash
#first look for syscalls
file="$1"
sed 's/(.*/ /g' $file > "${file}clean" 
#Removes duplicates
sed 's/, /\n/g' "${file}clean" | sort | uniq > "${file}uniq"
#then we remove exited
sed -i '/+++ exited with 0 +++/d' "${file}uniq"
sed -i '/+++ exited with 1 +++/d' "${file}uniq"
#comma separated haha
sed -n -e 'H;${x;s/\n/,/g;s/^,//;p;}' "${file}uniq" > "${file}comma"
#remove whitespaces
sed 's/ //g' "${file}comma" > "${file}final"
