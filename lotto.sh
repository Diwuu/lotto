#!/bin/bash


function scrape() {
	curl --silent -o "output.txt" "https://www.lotto.pl/"
}
scrape


function losowanie(){
	
	grep -m 1 -A 35 "resultsItem lotto" output.txt | grep '<strong>' | 
	grep -oE '[0-9][0-9]-[0-9][0-9]-[0-9][0-9]|[0-9][0-9]:[0-9][0-9]' | tr '\n' ' '
	printf "\n$3"
	grep -m 1 -A $2 "resultsItem $1" output.txt | grep '<span>[0-9]' | grep -Eo '[0-9]{1,4}' | tr '\n' ' '
}

NORMAL=$(tput sgr0)

printf "Wyniki Lotto "
losowanie "lotto" 35 "$(tput setaf 220)"
printf "\n${NORMAL}Lotto Plus: "
losowanie "lottoPlus" 35 "$(tput setaf 4)"
printf "\n${NORMAL}Eurojakcpot "
losowanie "euroJackpot" 50 "$(tput setaf 3)"
printf "\n${NORMAL}Ekstrapensja "
losowanie EkstraPensja 35 "$(tput setaf 190)" 
printf "\n${NORMAL}Ekstra Premia "
losowanie EkstraPremia 35 "$(tput setaf 64)"
printf "\n${NORMAL}Mini Lotto " 
losowanie MiniLotto 35 "$(tput setaf 220)"
printf "\n${NORMAL}Multi Multi "
losowanie multiMulti 90 "$(tput setaf 165)"
printf "\n"