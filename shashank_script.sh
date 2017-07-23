#!/bin/bash
#assuming passwordless login is there
#excuting the script like :-
#/bin/bash <script name> <mention the hostnames seperated with ,>
#Ex: /bin/bash shashank_script.sh hostname1,hostname2 
#####################################################################
#passing the argument in the variable
hostnames=$@

#storing the value in the variable
echo > ./host_names

for host in $(echo $hostnames | sed "s/,/ /g")
do
    echo "$host:22" >> ./host_names
done
#providing the user prompt for entering the command 
echo "Enter the command to execute"
read -p 'Command: ' command

# ssh all servers

pssh -h host_names -t 10 -i "$command"
