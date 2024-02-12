#!/bin/bash
declare -a ip=(
"example.com"
"192.168.15.15"
"example2.com"
"10.10.10.235"
)

declare -A configs=(
["example.com"]=departement13_intermediate
["192.168.15.15"]=departement13_intermediate
["example2.com"]=departement13_modern
["10.10.10.235"]=departement13_modern
)

for i in "${ip[@]}"
do	
	echo "Analyse sslyze en cours pour : $i"

	py -m sslyze --mozilla_config=${configs[$i]} $i >> "OUTPUT_FILES\\$i.txt"
	if grep "FAILED - Not compliant." "OUTPUT_FILES\\$i.txt" || grep "ERROR" "OUTPUT_FILES\\$i.txt"
	then 
		touch "OUTPUT_FILES\\${i}_NOT_COMPLIANT.txt"
		mv "OUTPUT_FILES\\$i.txt" "OUTPUT_FILES\\${i}_NOT_COMPLIANT.txt"
	else
		echo "OK"
	fi
done

read -p "Fini" x
