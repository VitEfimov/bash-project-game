# project01_vitefimov


This is a bush language project.

You will play with Greg.

Your goal is to win against Greg.
First, define a range between 1 and any number you want.
Then, you will have your first attempt to guess the number from the range.
If your attempt fails (the number you choose doesn't match the randomly selected number from the range), Greg will take his turn.
The first person to guess the number correctly wins!

Greg has three levels of difficulty:

 - Low: Greg uses random search.
 - Medium: Greg uses linear search.
 - Hard: Greg uses binary search.
All necessary files in the repo, logs, and statistics files will be generated automatically.
If you want to run the analyzer file in crontab, follow these instructions:

 - Comment out the logs, statistics files, and source keyword.
 - Uncomment the files with the same names but with absolute paths, starting from /mnt.
 - Add the path from your machine.
 - Open the Ubuntu terminal and use the crontab -e command to edit.

Example: * * * * * /mnt/c/users/15717/REVATURE/group6-haiku/afterNoon/Game/analyzer.sh >> /mnt/c/users/15717/REVATURE/group6-haiku/afterNoon/Game/cron.log 2>&1

Next Release:

- Separate packages for users, with logs (including date) and statistics files.
- Add days played and time spent in the game.


