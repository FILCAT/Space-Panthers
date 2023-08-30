#!/bin/bash
​
BAD_CONNECTIONS=$(grep -oP '"tookMilliseconds":\s*\K([0-9]+)' $1 | awk '$1 > 10' | wc -l)
BASE_DELTA_OVER_10=$(grep -oP '"baseDeltaSeconds":\s*\K([0-9]+)' $1 | awk '$1 > 10' | wc -l)
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color
OVER_BASE_DELTA_COUNT=0
while read -r baseDelta
do
    if (( baseDelta > 10 ))
    then
        echo $((baseDelta)) >> seconds.txt
        OVER_BASE_DELTA_COUNT=$((OVER_BASE_DELTA_COUNT+1))
    fi
done < <(grep -oP '"baseDeltaSeconds":\s*\K([0-9]+)' $1)
​
echo -e "${MAGENTA}Number of times tookMilliseconds is over 10: $BAD_CONNECTIONS${NC}"
echo -e "${CYAN}Number of times baseDelta has been over 10 seconds: $BASE_DELTA_OVER_10${NC}"
echo -e "Count when baseDelta has been over 10 seconds: $OVER_BASE_DELTA_COUNT"