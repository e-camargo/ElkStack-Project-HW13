#!/bin/bash

#
# Execute from your JumpBox.
#
# Save at ~ and replace <container_name> w/ yours
#

sudo docker container list -a
sudo docker start <container_name>
sudo docker attach <container_name>
