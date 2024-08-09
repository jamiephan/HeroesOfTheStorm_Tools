#!/bin/bash

DATA1="$1"
DATA2="$2"

####
#Override Value below, so no asking is needed
####
#DATA1="HeroesSnapshot_2.48.2.76893_HeroesMasteryRingsPatch_Data"
#DATA2="HeroesSnapshot_2.48.4.77406_20191122BalancePatch_Data"


function customCommand(){
    case "$1" in
        all)
        git diff --no-index $2 $3
        ;;
    esac
}


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


while [ ! -d "$DIR/$DATA1" ] || [ "$DATA1" = "" ]
  do
    printf "Please select directory 1:\n\n"
    select d in *_Data/; do test -n "$d" && break; echo ">>> Invalid Selection"; done
    DATA1=$d
    #echo "Please enter directory name for Data 1 in $DIR: "
    #read DATA1
done



while [ ! -d "$DIR/$DATA2" ] || [ "$DATA2" = "" ]
  do
    printf "Please select directory 2:\n\n"
    select d in *_Data/; do test -n "$d" && break; echo ">>> Invalid Selection"; done
    DATA2=$d
    #echo "Please enter directory name for Data 2 in $DIR: "
    #read DATA2
done

while [ true ]
  do
    echo "Please enter the reletive path for file to compare: "
    read -r DATAPATH
    DATAPATH=${DATAPATH//\\//} # Replace Wuindows forward slash to backward slash
    if [[ "$DATAPATH" =~ ^:.* ]]
        then
            DATAPATH=${DATAPATH:1}
            customCommand $DATAPATH $DATA1 $DATA2
        continue
    fi
    git diff --no-index "$DIR/$DATA1/$DATAPATH" "$DIR/$DATA2/$DATAPATH"
done


