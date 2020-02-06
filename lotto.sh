#!/bin/bash

function scrape() {
	curl --silent -o "output.txt" "https://www.lotto.pl/"
}

function scrape2() {
	curl --silent -o "output.txt" "https://www.lotto.pl/$1/wyniki-i-wygrane"
}

function losowanie(){
	
	grep -m 1 -A 35 "resultsItem $1" output.txt | grep '<strong>' | 
	grep -oE '[0-9][0-9]-[0-9][0-9]-[0-9][0-9]|[0-9][0-9]:[0-9][0-9]' | tr '\n' ' '
	printf "\n$3"
	grep -m 1 -A $2 "resultsItem $1" output.txt | grep '<span>[0-9]' | grep -Eo '[0-9]{1,4}' | tr '\n' ' '
}


if [ "$1" == '' ]; then
	scrape
	NORMAL=$(tput sgr0)

	printf "Wyniki Lotto ";
	losowanie "lotto" 35 "$(tput setaf 220)";
	printf "\n${NORMAL}Lotto Plus: ";
	losowanie "lottoPlus" 35 "$(tput setaf 4)";
	printf "\n${NORMAL}Eurojackpot ";
	losowanie "euroJackpot" 50 "$(tput setaf 3)";
	printf "\n${NORMAL}Ekstrapensja ";
	losowanie EkstraPensja 35 "$(tput setaf 190)";
	printf "\n${NORMAL}Ekstra Premia ";
	losowanie EkstraPremia 35 "$(tput setaf 64)";
	printf "\n${NORMAL}Mini Lotto " ;
	losowanie MiniLotto 35 "$(tput setaf 220)";
	printf "\n${NORMAL}Multi Multi ";
	losowanie multiMulti 90 "$(tput setaf 165)";
	printf "\n";

elif [ "$1" == "lotto" ]; then
	scrape2 "lotto";
	grep -m 4 -A 1 "lotto img-fluid" output.txt | grep -Eo "<td>[0-9][0-9]-[0-9][0-9]-[0-9][0-9]" | grep -oE '[0-9][0-9]-[0-9][0-9]-[0-9][0-9]|[0-9][0-9]:[0-9][0-9]' > daty.txt
	grep -m 4 -A 1 "lotto img-fluid" output.txt | grep -Eo "<span>[0-9][0-9]</span>|<span>[0-9]</span>" | grep -Eo '[0-9]{1,4}' > los.txt
	
	printf "\n"
	
	for i in {1..10}
	do
		printf "$(tput sgr0)\nLosowanie z dnia: "
		sed -i -e '1w /dev/stdout' -e '1,3d' daty.txt
		printf "Lotto: $(tput setaf 220)"
		sed -i -e '1,6w /dev/stdout' -e '1,18d' los.txt | tr '\n' ' '
		printf "\n$(tput sgr0)Lotto Plus: $(tput setaf 4)"
		sed -i -e '1,6w /dev/stdout' -e '1,25d' los.txt | tr '\n' ' '
		printf "\n"
	done
 
 
elif [ "$1" == "eurojackpot" ]; then
	scrape2 "eurojackpot";
	grep -m 4 -A 1 "lotto img-fluid" output.txt | grep -Eo "<td>[0-9][0-9]-[0-9][0-9]-[0-9][0-9]" | grep -oE '[0-9][0-9]-[0-9][0-9]-[0-9][0-9]|[0-9][0-9]:[0-9][0-9]' > daty.txt
	grep -m 4 -A 1 "lotto img-fluid" output.txt | grep -Eo "<span>[0-9][0-9]</span>|<span>[0-9]</span>" | grep -Eo '[0-9]{1,4}' > los.txt
	
	printf "\n"
	sed -i '1,7d' los.txt
	for i in {1..10}
	do
		printf "$(tput sgr0)\nLosowanie z dnia: "
		sed -i -e '1w /dev/stdout' -e '1d' daty.txt
		printf "Eurojackpot: $(tput setaf 3)"
		sed -i -e '1,7w /dev/stdout' -e '1,21d' los.txt | tr '\n' ' '
		
		
		printf "\n"
	done
elif [ "$1" == "mini-lotto" ]; then
	scrape2 "mini-lotto";
	grep -m 4 -A 1 "lotto img-fluid" output.txt | grep -Eo "<td>[0-9][0-9]-[0-9][0-9]-[0-9][0-9]" | grep -oE '[0-9][0-9]-[0-9][0-9]-[0-9][0-9]|[0-9][0-9]:[0-9][0-9]' > daty.txt
	grep -m 4 -A 1 "lotto img-fluid" output.txt | grep -Eo "<span>[0-9][0-9]</span>|<span>[0-9]</span>" | grep -Eo '[0-9]{1,4}' > los.txt
	
	printf "\n"
	for i in {1..10}
	do
		printf "$(tput sgr0)\nLosowanie z dnia: "
		sed -i -e '1w /dev/stdout' -e '1,2d' daty.txt
		printf "MiniLotto: $(tput setaf 220)"
		sed -i -e '1,5w /dev/stdout' -e '1,22d' los.txt | tr '\n' ' '
		
		printf "\n"
	done
fi



