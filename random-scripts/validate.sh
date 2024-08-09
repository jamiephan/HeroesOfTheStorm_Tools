#!/bin/bash
n=1
while read line; do
	echo "Checking Line $n: $line";
	# grep -qr AbilityClass( --include "*\.galaxy" ./mods
	# echo "$line("
	a=$(grep -qr "$line("  --include "*\.galaxy" ./mods && echo "OK" || echo "NOK")
	if [ "$a" = "NOK" ]; then
		echo $line >> "nook.txt" 
	fi

	# if [[ grep -q "a" ]] ; then
	# 	echo $line;
	# else
	# 	echo ""
	# fi

	# if grep -qir  

	n=$((n+1));
done < "search.txt"
