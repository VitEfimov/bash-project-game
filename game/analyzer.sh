#!/usr/bin/bash

#here is you need mention file directory for library.sh
#Example: /mnt/c/users/15717/REVATURE/group6-haiku/afterNoon/Game/library.sh

# source /mnt/c/users/15717/REVATURE/group6-haiku/afterNoon/Game/library.sh
source ./library.sh

declare -a rows

#here is you need mention file directory for logs.txt and statistics.txt if you want run it in crontab.
#Example: "/mnt/c/users/15717/REVATURE/group6-haiku/afterNoon/Game/logs.txt"
# logs="/mnt/c/users/15717/REVATURE/group6-haiku/afterNoon/Game/logs.txt"
# statistics="/mnt/c/users/15717/REVATURE/group6-haiku/afterNoon/Game/statistics.txt"

logs="logs.txt"
statistics=statistics.txt

while IFS=\n read -r line
	do
	username=$(echo "$line" | awk -F'[, ]+' '{print $2}')
	date=$(echo "$line" | awk -F'[, ]+' '{print $4}')
	time=$(echo "$line" | awk -F'[, ]+' '{print $6}')
	game_played=$(echo "$line" | awk -F'[, ]+' '{print $9}')
	user_wins=$(echo "$line" | awk -F'[, ]+' '{print $12}')
	greg_wins=$(echo "$line" | awk -F'[, ]+' '{print $15}')
	user_attempts=$(echo "$line" | awk -F'[, ]+' '{print $18}')
	greg_attempts=$(echo "$line" | awk -F'[, ]+' '{print $21}')
		if [ "$user_wins" -eq "1" ]; then
			winner_attempts="$user_attempts"
		else
			winner_attempts="$greg_attempts"
		fi

	rows+=("$username,$date,$time,$game_played,$user_wins,$greg_wins,$winner_attempts")
done < "$logs"

#redirect output to the statistics.txt file
# exec > "$statistics"

#Print headers of the table
{
	printf "%-10s %-15s %-10s %-10s %-10s %-10s %-10s\n" "Username" "Date" "Time" "Games" "User Wins" "Greg Wins" "Attempts"

echo "-------------------------------------------------------------------------------"

#iteration over the array
for row in "${rows[@]}"; do
	IFS=',' read -r username date time game_played user_wins greg_wins winner_attempts<<< "$row"
	printf "%-10s %-15s %-10s %-10s %-10s %-10s %-10s\n" "$username" "$date" "$time" "$game_played" "$user_wins" "$greg_wins" "$winner_attempts"
done

#call function from library.sh
total rows
} >> "$statistics"

#  exec >&2


