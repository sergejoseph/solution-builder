![Alt text](http://www.scientificcomputing.com/sites/scientificcomputing.com/files/openpower_foundation_ml.jpg)
# OpenPOWER Performance Enablement Kit
# Solution Builder - A Service Oriented Orchestrator
#
#
#
### The goal of this project is build a modular but expandable soltuion orchestrator that get a solution up and running quickly with minimum intervention required in single node, docker nodes, virtual nodes, and multi nodes bare-metal environments. In additional, this project aim is to develop a framework that allows for easy repeatability and for sharing of complex, multi-service deployments.
#
### Key Features:
- Deploy a service or collection of services (Solution) in a distributed fastion 
- Configure
- Manage
- Scale
- Expandable
- Shareable - i.e Application-specific knowledge
- Repeatable
- 
-
##### Suported Nodes:
- Bare metal.
- Docker container
- VM 
- Ubuntu 
- Fedora, Centos, and RHEL - TBD
##### Supported Cluster
- OpenPOWER
- Intel 
- Hybrid (x86 and OpenPower)
- VMs and Docker
- Cloud


##### A Brief Outline of scripts and files included in this project and their function follows:
-   solution definition file template - A Solution Definition file is a collection of services and their relationships, designed to give you an entire working deployment in one easy to use collection. It can be use in two distinct ways. One is to use it locally ( Docker or VM cluster) from your computer, which is useful to initially ensure that your solution works and for experimenting. After you are satisfied with the solution definition file, you can push it to github where it will be available to you and others.
-   deploy_solution.sh - Downloads, installs, configures, and starts all of the servicess defined in the solution definition file.
-	remove_solution.sh - Remove all servicess defined in the solution definition file.
-   start_solution.sh - Start all servicess defined in the solution definition file.
-   stop_solution.sh - Stop all servicess defined in the solution definition file.
-   solution_status.sh - Display status of all servicess defined in the solution definition file.
-	init_ssh_nodes.sh - A utiltiy script to set ssh passwordless connection to all the nodes defined in the solution definition file.

##### A Sample Solution - Apache Bigtop Orchestrator.
- Java Open JDK 1.8 
- Apache Bigtop  v1.2+ 
  * Hadoop  v2.7.3
  * Spark  v1.6.2 / Spark 2.1
  * Zeppelin  v0.6.2
  * Bigtop-groovy  v2.4.4
  * jsvc  v1.0.15
  * Tomcat  v6.0.36
  * Apache Zookeeper  v3.4.6
- Scala  v2.10.4
- python
- openssl
- snappy
- lzo
#
#
# Lets Start 
### Installer requirements 
- Any Linux, Windows, OS x system
  * Must have ssh and sshpass installed
  * sshpass for Mac OS x - https://fauxzen.com/installing-sshpass-os-x/   
- OpenPower or x86 architecture 

### Cluster prep
- Creating User Account in All Nodes - 
Example:
```
sudo useradd myname -U -G sudo -m
sudo passwd myname
```
IMPORTANT - The username must match service's username defined in the solution definition file 
- Mapping the nodes - You have to edit hosts file in /etc/ folder on ALL nodes, specify the IP address of each system followed by their host names. Example
```
# sudo vim /etc/hosts
Append the following lines in the /etc/hosts file.
192.168.1.1 hadoop-master 
192.168.1.2 hadoop-slave-1 
192.168.1.3 hadoop-slave-2
.....
.....
```
Quick Cluster Deployment


1. Cluster Basic Requirement
 
Hardware and Software Requirement

a) You need 1 Management or Installer node from which you install and run all jobs
Example: spoc8cxeond.aus.stglabs.ibm.com running redhat 7

b) You also need 1 Master node and 1 or more datanodes. Example on a 4 nodes cluster, you need 5 total nodes.
— Installer node can be running  Ubuntu or Redhat.

c)  Install ubuntu 16.04 on all cluster nodes, and setup private network.
— Create local DNS for your private network  in /etc/hosts
— Add the cluster NODES and installer node’s private ip address to each server in  /etc/hosts

Example of Entries in /etc/hosts

10.10.2.10 wlkmaster
10.10.2.11 wlk1
10.10.2.12 wlk2
10.10.2.13 wlk3
 10.10.2.9 clustermgmt

IMPORTANT:  all nodes must be in the same subnet and private network as in the /etc/hosts entries above

Set Hostname

—Login to each cluster nodes and set the hostname appropriately
example to set the masternode hostname to wlkmaster: 

$ sudo set hostname wlkmaster      

d) Install sshpass

$ sudo apt-get install sshpass

 2. Building the cluster

a) login to the installer or management node , create a user to manage the cluster. 
—Exit and log back in with the cluster management user.

b) download the package

$ git clone https://github.com/OpenPOWER-BigData/solution-builder.git 
$ cd solution-builder
—use the solution_def template file to build your own custom input file  using the fields below:

#Service Name, required service, target node IP address, Username_to_RunService, namenode hostname, resourcemanager hostname, spark-master hostname

— create a USER on each cluster node to run services
$ init_ssh_nodes.sh Your_Solution_Def_File

$ ./deploy_solution.sh --sd <solution definition file name> --spark-version <spark version>

    where:
        <spark version> is one of ["1.6.2", "2.1"]

3. Test cluster functionality

a)Testing Hadoop

$ ssh Cluster_username@wlkmaster "bash -s" < common/hadoopTest.sh 

b) Testing Spark
$ ssh Cluster_username@wlkmaster "bash -s" < common/hadoopTest.sh 

——End of installation———

4. Optional: To uninstall and Reinstall Apache BigTop

a) login to the management or installer node with the cluster management user

$ cd ./solution-builder
$ ./remove_solution.sh —sd  <solution definition file name>
$ $ ./deploy_solution.sh --sd <solution definition file name> --spark-version <spark version>
