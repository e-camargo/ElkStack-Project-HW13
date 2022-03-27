#!/bin/bash

#
# Execute from your ansible container.
#
# Leverages an OS and a Docker query command to return system and docker details. Replace with your IPs and the for loop will irerate through your array.
#  
#
web_servers=(10.0.0.5 10.0.0.6 10.0.0.7)
for in in "${web_servers[@]}"
do
ssh -i /root/.ssh/id_rsa RedTeamAdmin@"$i" 'echo $(uname -a; sudo docker container list -a)'
done
