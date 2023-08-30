#!/bin/bash
​
MINED=$(grep 'mined' "$1" | wc -l)
ISWINNER=$(grep 'isWinner": true' "$1" | wc -l)
elections=$(grep 'isWinner": false' "$1" | wc -l)
BAD_CONNECTIONS=$(grep -oP '"tookMilliseconds":\s*\K([0-9]+)' "$1" | awk '$1 > 10' | wc -l)
BASE_DELTA_OVER_10=$(grep -oP '"baseDeltaSeconds":\s*\K([0-9]+)' "$1" | awk '$1 > 10' | wc -l)
SLASHFILTER=$(grep 'SLASHFILTER' "$1" | wc -l)
COMMIT_LOGS=$(grep 'logs added in this commit' "$1" | wc -l) # Modify this grep pattern to match the actual log message
BLOCK_DELAY=$(grep 'CAUTION: block production took longer than the block delay' "$1" | wc -l)
MINEONE_BEFORE=$(grep 'completed mineOne' "$1" | wc -l) # This is a placeholder. You might need to adjust based on actual logs
​
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
​
if [[ $MINED -ne $ISWINNER ]]
then
	echo -e "${RED}PROBLEM! Some blocks were not mined, check log for more info...${NC}"
	echo -e "Number of mined block(s):   $MINED"
	echo -e "${YELLOW}Number of winning ticket(s): $ISWINNER${NC}"
	echo -e "${BLUE}Number of elections ticket(s): $elections${NC}"
else
	echo -e "${GREEN}GOOD! All blocks were mined!${NC}"
	echo -e "Number of mined block(s):   $MINED"
	echo -e "${YELLOW}Number of winning ticket(s): $ISWINNER${NC}"
	echo -e "${BLUE}Number of elections ticket(s): $elections${NC}"
fi
​
echo -e "${MAGENTA}Number of times tookMilliseconds is over 10: $BAD_CONNECTIONS${NC}"
echo -e "${CYAN}Number of times baseDelta has been over 10 seconds: $BASE_DELTA_OVER_10${NC}"
echo -e "${RED}Number of SLASHFILTER logs: $SLASHFILTER${NC}"
echo -e "${YELLOW}Number of logs added in this commit: $COMMIT_LOGS${NC}"
echo -e "${BLUE}Number of CAUTION block delay logs: $BLOCK_DELAY${NC}"
echo -e "${GREEN}Number of completed mineOne logs: $MINEONE_BEFORE${NC}" # Adjust this based on actual logs