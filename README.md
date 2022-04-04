# ElkStack-Project-HW13
Homework: GitHub Fundamentals and Project 13 Submission

## Automated ELK Stack Deployment

-- ElkStack-Project-HW13\Diagrams\ElkProjectDiagram.drawio

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above (e.g., ElkProjectDiagram.drawio). Alternatively, select portions of the Playbook YAMLS may be used to install only certain pieces of it, such as Filebeat. For example, filebeat-playbook.yml and its corresponding filebeat-config.yml.

This document contains the following details:

- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build

### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly AVAILABLE, in addition to restricting TRAFFIC to the network.

Balancing traffic protects a network against distributed denial-of-service (DDoS) attacks ensuring one of the three components of the C.I.A Triad: Availability.

A "jump box" permits segmentation between administrative functions of the network; with the use of SSH Key Pair Authentication, the "jump box" secures and limits administrative authentication to the network.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the LOGS and SYSTEM METRICS.

-- Metricbeat collects metrics on the Operating System and running services (e.g., CPU (docker, system, etc.), Memory, HTTP traffic, etc.).
-- Filebeat is an agent that serves as a log aggregator that in this network ingests logs to Elasticsearch.

The configuration details of each machine may be found below.

| Name          | Function             | IP Address                                   | Operating System | Virtual Network |
|---------------|----------------------|----------------------------------------------|------------------|-----------------|
| Home          | access/testing       | PRI:67.176.130.63                            | macOS Monterrey  | not applicable  |
| Jump Box      | Administration       | PUB:13.64.111.120 PRI:10.0.0.4/24            | Ubuntu 1804      | RedTeam         |
| Web-1,2 and 3 | DVWA                 | respectively:10.0.0.5  10.0.0.6 and 10.0.0.7 | Ubuntu 1804      | RedTeam         |
| Elk-VM01      | Elasticsearch/Kibana | PUB:20.25.84.179 PRI:10.1.0.4/24             | Ubuntu 2004      | ElkStack        |

### Access Policies

The machines on the internal network are not exposed to the public Internet.

Only the JUMP BOX and ELK-VM01 virtual machines can accept connections from the Internet. Access to this machine is only allowed from the following

IP addresses:

67.176.130.63 (i.e., "the internet/home host public ip") 
and 
13.91.134.90 (i.e., "the Load Balancer's Public, Frontend IP")


Machines within the network can only be accessed in accordance to Inbound Security Rules defined within the Network Security Groups.


A summary of the access policies in place can be found in the table below.

| Name          | Publicly Accessible | Allowed IP Address                                             |
|---------------|---------------------|----------------------------------------------------------------|
| Jump Box      | Yes (SSH)           | 67.176.130.63 (i.e., "the internet/home host public ip")       |
| Elk-VM01      | Yes (TCP 5601)      | 67.176.130.63 (i.e., "the internet/home host public ip")       |
| Web-1,2 and 3 | Yes (HTTP)          | 13.91.134.90 (i.e., "the Load Balancer's Public, Frontend IP") |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...

The main advantage of automating configurations with Ansible is that you allow for a scalable standardization of settings and versions.

The playbook implements the following tasks:

- ... Installs Docker
- ... Installs Python 3.0
- ... Increases virtual Memory
- ... Enables Docker Service on boot
- ... Publishes Elk TCP port ranges

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

-- ElkStack-Project-HW13\Diagrams
\ElkDockerPS

### Target Machines & Beats
This ELK server is configured to monitor the following machines:

As defined in the

\roles
metricbeat-playbook.yml (hosts: webservers)
and
filebeat-playbook.yml (hosts: webservers)

and in

/etc/ansible/hosts:

[webservers]
10.0.0.5 ansible_python_interpreter=/usr/bin/python3
10.0.0.6 ansible_python_interpreter=/usr/bin/python3
10.0.0.7 ansible_python_interpreter=/usr/bin/python3

We have installed the following Beats on these machines:

10.0.0.5 Web-1
10.0.0.6 Web-2
10.0.0.7 Web-3

-- ElkStack-Project-HW13\Diagrams\Filebeat_Install_screenshot
and
\Metricbeat_Install_screenshot

These Beats allow us to collect the following information from each machine:

Metricbeat allows us to analyze spikes in CPU utilization when running "apt-get update" for example. We can also analyze visual representations of granular details on HTTP traffic patterns, from country destinations to the types Operating Systems of the sources reaching our web servers.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned:

SSH into the control node and follow the steps below:

- Copy the Playbook YAML and if applicable its corresponding config file to Jump Box Ansible container.
- Update the Playbook YAML and the Config with key values.

[Example]

filebeat-playbook.yml (hosts: webservers)
and
filebeat-config.yml (setup.kibana: host: "Elk-VM01:5601", output.elasticsearch: hosts: ["Elk-VM01:9200"])

- Run the playbook, and navigate to the web servers to check that the installation worked as expected.

NOTE: Included in this repo,

-- ElkStack-Project-HW13\Linux\QueryWebSrvDockCont.sh

which will output the running Docker containers on your web servers from your Ansible container within your "jump box".

- _Which file is the playbook? Where do you copy it?

RedTeamAdmin@RedTeam-JumpBox-01:~/Ansible-ymls$ sudo docker cp /home/RedTeamAdmin/Ansible-ymls/roles/filebeat-playbook.yml 60d5404ded25:/etc/ansible/roles/

- _Which file do you update to make Ansible run the playbook on a specific machine? The "/etc/ansible/hosts" file.

ansible.cfg: #inventory      = /etc/ansible/hosts

_How do I specify which machine to install the ELK server on versus which to install Filebeat on?

filebeat-playbook.yml (hosts: webservers)
and
install-elk-playbook.yml (hosts: hosts: elk)

- _Which URL do you navigate to in order to check that the ELK server is running?

-- URL (Where the IP is the Elk-VM01 virtual machine public IP): http://20.25.84.179:5601/app/kibana

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._

(1) run ansible-playbook /etc/ansible/roles/filebeat-playbook.yml
and
(2) run ansible-playbook /etc/ansible/roles/metricbeat-playbook.yml
