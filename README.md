This is for a school proeject on bash scripting
The file that i created was deploymentAudit.sh
The otherfiles are dummy files for it to work on
a description of what it does is outlined below 








At the beginning of each program (Bash script file), after the "#!/bin/bash" line, include comments with the author's name and the script's purpose.

The objective of this project is to help you gain hands-on experience with practical Bash scripting in a real-world DevOps scenario. Suppose you are in the role of a DevOps engineer responsible for auditing the contents of a deployment directory before pushing it to production. Your task is to write a Bash script named deploymentAudit.sh that checks the folder structure, flags unauthorized or suspicious files, and analyzes file names and contents for potential issues.

You can use all the Bash commands and concepts learned in previous lectures, including loops, conditionals, pattern matching, file operations, and string manipulation. You must work with a provided dataset named deployment_dir.zip. Download deployment_dir.zip. Your script must present a menu-driven interface that allows the user to select one of the five tasks or type end to exit the program. You must implement each task as a separate function within the script.

Task 1: Write a Bash script function that iterates through all directories in the deployment directory and counts how many files exist of each type, such as .sh, .conf, .php, .js, .css, .bak, .tmp, and so on. Finally, print a summary table showing the counts for each file type.  Save the output in task1Output.txt. [ 15 Points ]
Task 2: Write a Bash script function that scans all file names for suspicious patterns. Specifically, flag any files whose names contain terms like debug, test, or temp, or which have extensions such as .bak, .old, or .tmp. And then print warnings such as: WARNING: Suspicious file detected - tmp/build.bak. Save the output in task2Output.txt. [ 15 Points ]
Task 3: Write a Bash script function that scans all .sh files in the deployment directory to detect the presence of potentially dangerous commands like rm -rf, scp, curl, or sudo. If any of these commands are found, print a report in the format: cleanup.sh: uses dangerous command 'rm -rf'. Save the output in task3Output.txt. [ 15 Points ]
Task 4: Write a Bash script function that scans all the contents of logs/access.log and logs/error.log to identify traffic and error patterns. Count how many unique IP addresses accessed the server, determine the top 3 most visited pages, and extract any "File does not exist" entries. Save the output in task4Output.txt. [ 15Points ]
Task 5: Write a Bash script function that searches through configuration files such as .env, .conf, .json, and .pem for signs of hardcoded secrets or credentials. Look for keywords such as SECRET, PASSWORD, KEY, or PRIVATE within the file content. Then print any lines that contain these sensitive terms, along with the filename. Save the output in task5Output.txt. [ 15 Points ]
