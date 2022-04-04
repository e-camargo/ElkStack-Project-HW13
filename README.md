# ElkStack-Project-HW13
Homework: GitHub Fundamentals and Project 13 Submission

## Automated ELK Stack Deployment

-- ElkStack-Project-HW13\Diagrams\ElkProjectDiagram.drawio

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above (e.g., ElkProjectDiagram.drawio) or alternatively, select portions of the Playbook YAMLS may be used to install only certain pieces of it, such as Filebeat. For example, filebeat-playbook.yml and its corresponding filebeat-config.yml.

This document contains the following details:

- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in use
  - Machines being monitored
- How to use the Ansible build

### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application. Load balancing ensures that the application will be highly available, in addition to restricting traffic to the network. Furthermore, it protects a network against distributed denial-of-service (DDoS) attacks, ensuring one of the three components of the C.I.A Triad: Availability.

A "jump box" permits segmentation between administrative functions of the network. And with the use of SSH Key Pair Authentication, the "jump box" secures and limits administrative authentication to the network.

An ELK Stack implementation facilitates log, application and system performance analytics:

-- Metricbeat collects metrics on the Operating System and running services (e.g., CPU, Memory, HTTP traffic, etc.).
-- Filebeat is an agent that serves as a log aggregator that in this network ingests logs to Elasticsearch.

The configuration details of each machine may be found below.

| Name          | Function             | IP Address                                   | Operating System | Virtual Network |
|---------------|----------------------|----------------------------------------------|------------------|-----------------|
| Home          | access/testing       | PRI:67.176.130.63                            | macOS Monterrey  | not applicable  |
| Jump Box      | Administration       | PUB:13.64.111.120 PRI:10.0.0.4/24            | Ubuntu 1804      | RedTeam         |
| Web-1,2 and 3 | DVWA                 | respectively:10.0.0.5  10.0.0.6 and 10.0.0.7 | Ubuntu 1804      | RedTeam         |
| Elk-VM01      | Elasticsearch/Kibana | PUB:20.25.84.179 PRI:10.1.0.4/24             | Ubuntu 2004      | ElkStack        |

### Access Policies

Exposure to the machines on the internal network from the public Internet is by design and in accordance to inbound security rules. Only the JUMP BOX is permitted remote login and command line execution from the Internet. Access to this machine is enforced by Azure's Network Security Group to allow connections only from IP addresses: 67.176.130.63 (i.e., "the internet/home host public ip"). 

A summary of the access policies in place can be found in the table below.

| Name          | Publicly Accessible | Allowed IP Address                                             |
|---------------|---------------------|----------------------------------------------------------------|
| Jump Box      | Yes (SSH)           | 67.176.130.63 (i.e., "the internet/home host public ip")       |
| Elk-VM01      | Yes (TCP 5601)      | 67.176.130.63 (i.e., "the internet/home host public ip")       |
| Web-1,2 and 3 | Yes (HTTP)          | 13.91.134.90 (i.e., "the Load Balancer's Public, Frontend IP") |

### Elk Configuration

Ansible automated the configuration of the ELK Stack setu-up, providing a scalable standardization of settings and versions.

The Elk playbook orchestrates the following tasks:

- ... Installs Docker
- ... Installs Python 3.0
- ... Increases virtual Memory
- ... Enables Docker Service on boot
- ... Publishes Elk TCP port ranges

Target Machines & Beats

With Filebeat and Metricbeat we can analyze spikes in CPU utilization for example. We can also analyze visual representations of granular details on HTTP traffic patterns, from country destinations to the types Operating Systems accessing web servers.

The ELK server is configured to monitor:

[webservers]

- 10.0.0.5 Web-1
- 10.0.0.6 Web-2
- 10.0.0.7 Web-3

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned (in this project, it is the Jump-Box):

SSH into the control node:

- Copy the Playbook YAML and its corresponding config file to the Jump-Box Ansible container.
- Update the Playbook YAML and the config file with the values pertinent to your network.
- Run the playbook, and navigate to the web servers to check that the installation worked as expected.

NOTE: Included in this repo,

-- ElkStack-Project-HW13\Linux\QueryWebSrvDockCont.sh

When executed from your Jump-Box' container, it will output to the terminal the status of the Docker containers on each of your web servers.

File Details:

- filebeat-playbook.yml (located, /etc/ansible/roles/): Filebeat playbook
- Hosts (located, "/etc/ansible/"): Ansible hosts file
- Ansible.cfg (located, "/etc/ansible/"): Ansible configuration file

Misc:

- _Which URL do you navigate to in order to check that the ELK server is running?

-- URL (Where the IP is the Elk-VM01 virtual machine public IP): http://20.25.84.179:5601/app/kibana

_The specific commands to download the playbook, update the files, etc._

- (1) run ansible-playbook /etc/ansible/roles/filebeat-playbook.yml
- (2) run ansible-playbook /etc/ansible/roles/metricbeat-playbook.yml
