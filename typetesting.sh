640b964#!/bin/bash

WORD_FILE="/usr/share/dict/words"
COUNT=20
DIFF="medium"

# CLI options
while getopts "n:d:" opt; do
    case $opt in
        n) COUNT=$OPTARG ;;
        d) DIFF=$OPTARG ;;
    esac
done

# colors
GRN="\033[32m"
RED="\033[31m"
DIM="\033[2m"
RST="\033[0m"
UND="\033[4m"
UND_OFF="\033[24m"

# generate words
generate_words() {
    count=$1
    min=$2
    max=$3
    grep -E "^[a-z]{$min,$max}$" "$WORD_FILE" | sort -R | head -n "$count"
}

# pick words
case "$DIFF" in
    easy) raw=$(generate_words "$COUNT" 2 5);;
    medium) raw=$(generate_words "$COUNT" 4 8);;
    hard) raw=$(generate_words "$COUNT" 6 12);;
    *) raw=$(generate_words "$COUNT" 3 8);;
esac

words=$(echo "$raw" | tr '\n' ' ')
words="${words% }"

# draw screen
render() {

    clear
    echo "typing test"
    echo "----------------"
    echo

    for ((i=0;i<${#words};i++)); do
        c="${words:$i:1}"

        if ((i < pos)); then
            if [[ "${typed:$i:1}" == "$c" ]]; then
                printf "${GRN}%s${RST}" "$c"
            else
                printf "${RED}%s${RST}" "$c"
            fi

        elif ((i == pos)); then
            printf "${UND}%s${UND_OFF}" "$c"

        else
            printf "${DIM}%s${RST}" "$c"
        fi
    done

    echo
    echo
}

# results
results() {

    secs=$1
    correct=0

    for ((i=0;i<${#words} && i<${#typed};i++)); do
        [[ "${typed:$i:1}" == "${words:$i:1}" ]] && ((correct++))
    done

    wc=$(echo "$words" | wc -w | tr -d ' ')

    wpm=0
    if ((secs>0)); then
        wpm=$(( (wc * 60) / secs ))
    fi

    acc=0
    if ((${#words}>0)); then
        acc=$(( (correct * 100) / ${#words} ))
    fi

    clear
    echo
    echo "results"
    echo "-------"
    echo "time: $secs seconds"
    echo "wpm: $wpm"
    echo "accuracy: $acc%"
    echo

    LOG="$HOME/.typetest_log.csv"

    if [[ ! -f "$LOG" ]]; then
        echo "date,time,wpm,accuracy" > "$LOG"
    fi

    echo "$(date +%F),$secs,$wpm,$acc" >> "$LOG"
}

# main
pos=0
typed=""
started=0
t0=0

echo "press enter to start"
read

render

while ((pos < ${#words})); do

    IFS= read -rsn1 key

    if ((started==0)); then
        t0=$SECONDS
        started=1
    fi

    # backspace
    if [[ "$key" == $'\x7f' ]]; then
        if ((pos>0)); then
            ((pos--))
            typed="${typed:0:$pos}"
        fi
        render
        continue
    fi

    [[ -z "$key" ]] && key=" "

    typed+="$key"
    ((pos++))

    render

done

results $((SECONDS - t0))