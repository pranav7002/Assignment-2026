#!/bin/bash

goal_text="innovation distinguishes between a leader and a follower, and the code we write today becomes the foundation for the intelligence of tomorrow."

while true; do
    clear
    echo "typing test"
    echo ""
    echo "$goal_text"
    echo ""
    echo "press [enter] to begin"
    read 
    
    begin=$(date +%s)
    
    echo -n "typing> "
    read user_attempt
    
    finish=$(date +%s)

    elapsed_seconds=$(( finish - begin ))
    
    # safety check for division operations
    if [ $elapsed_seconds -lt 1 ]; then elapsed_seconds=1; fi

    # calculate words per minute
    total_chars=${#user_attempt}
    words_per_minute=$(( (total_chars * 60) / (elapsed_seconds * 5) ))

    # accuracy
    correct_hits=0
    goal_length=${#goal_text}
    attempt_length=${#user_attempt}
    
    for (( i=0; i<$goal_length && i<$attempt_length; i++ )); do
        if [[ "${goal_text:$i:1}" == "${user_attempt:$i:1}" ]]; then
            ((correct_hits++))
        fi
    done
    
    precision_score=$(( (correct_hits * 100) / goal_length ))

    echo -e "\n--- results ---"
    echo "duration: $elapsed_seconds s"
    echo "wpm: $words_per_minute wpm"
    echo "precision: $precision_score%"
    echo ""

    echo "try again? (r= retry, q = quit): "
    read action_choice
    if [[ "$action_choice" == "q" ]]; then
        echo "goodbye!"
        break
    fi
done