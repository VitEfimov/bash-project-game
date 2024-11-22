#!/bin/bash

# Functions for Greg's behavior:
function rundom_search() {
    echo $(((RANDOM % range) + 1))
}

source ./library.sh


function greg_guess() {
    if [ "$difficulty" -eq 1 ]; then
        greg_guess=$((RANDOM % range + 1))
    elif [ "$difficulty" -eq 2 ]; then
        ((greg_guess++))
    elif [ "$difficulty" -eq 3 ]; then
        greg_guess=$(( (greg_min + greg_max) / 2 ))
    else
        echo "Invalid level, try again..."
    fi
}


# Game start

echo "Hi, my name is Greg, do you wanna play with me? 1(YES), 2(NO)"
read answer

if [ "$answer" -ne 1 ]; then
    echo "Bye!"
    exit 0
fi

username=$(whoami)
logs="logs.txt"
statistics="statistics.txt"

function game() {
    echo "Choose the range of numbers: "
    read range

echo "Choose difficulty level: 1(low), 2(medium), 3(hard)"
read difficulty


date=$(date +"%Y-%m-%d")
time=$(date +"%H:%M:%S")
game_played=0
attempts=0
user_wins=0
greg_wins=0

((game_played++))

echo "$username vs Greg"

number=$(rundom_search)
user_attempts=0
greg_attempts=0
winner_attempts=0
greg_min=1
greg_max=$range
greg_guess=0

echo "We will guess a number between 1 and $range!"


while true; do

#User logic.
    echo "Your guess:"
    read user_guess
    ((user_attempts++))
    
    if [ "$user_guess" -eq "$number" ]; then
        echo "Congratulations, $username! You guessed it in $user_guess_count attempts!"
        ((user_wins++))
        ((winner_attempts=user_attempts))
        break
    elif [ "$user_guess" -lt "$number" ]; then
        echo "The number is bigger, try one more time!"
    else
        echo "The number is lower, try one more time!"
    fi


#Greg's logic.
    greg_guess
    ((greg_attempts++))
    echo "Greg's guess: $greg_guess"

    if [ "$greg_guess" -eq "$number" ]; then
        echo "Greg wins!"
        ((greg_wins++))
        ((winner_attempts=greg_attempts))
        break
    elif [ "$greg_guess" -lt "$number" ]; then
        echo "Greg's guess is lower"
        greg_min=$((greg_guess + 1))
    else
        echo "Greg's guess is higher"
        greg_max=$((greg_guess - 1))
    fi
done
}

#Run game()
game

#Chek the files is appear
if [ ! -f "$logs" ]; then
    touch "$logs"
fi
if [ ! -f "$statistics" ]; then
    touch "$statistics"
fi


#Sending the data to logs file
echo "Username: $username, Date: $date, Time: $time, Games played: $game_played, User wins: $user_wins, Greg wins: $greg_wins, User attempts: $user_attempts, Gregs attempts: $greg_attempts"  >> "$logs"

#logic for continue playing
while true; do 

echo "Do you want to play more? 1(Yes), 2(No)"
read answr

if [ "$answr" -ne 1 ]; then
    #Sending the data to logs file
    echo "Your games have been saved in the $logs. And Total statistics saved in the $statistics"    
    echo "Thanks for playing! Bye!"
    exit 0
fi    

#Run game()
game

# #Sending the data to logs file
echo "Username: $username, Date: $date, Time: $time, Games played: $game_played, User wins: $user_wins, Greg wins: $greg_wins, User attempts: $user_attempts, Gregs attempts: $greg_attempts" >> "$logs"

done



