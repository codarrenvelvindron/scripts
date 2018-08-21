#!/usr/bin/env bash

sed -e '16,$d' brainy_quotes.txt > removed_lines.txt
sed '/BrainyQuote/d' removed_lines.txt > remove_brainy.txt
sed '/blocker/d' remove_brainy.txt > excess_removed.txt
rm -rf removed_lines.txt remove_brainy.txt
