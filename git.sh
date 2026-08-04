#!/bin/bash
echo "This is git push every day"
echo ""
datetime=$(date +%Y_%m_%d_%H_%M_%S)
for i in {1..31};do
	filename="${datetime}_${i}.txt"
	touch "$filename"
	echo "touch $i/31:$filename"
	git add "$filename"
	git commit -m "add $filename"
done
echo "touch file"
git push
