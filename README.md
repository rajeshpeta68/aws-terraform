# AWS 3-Tier Network Infrastructure — Practice Project

## 📌 Project Overview

Design and deploy a **highly available 3-tier web application infrastructure on AWS** across two Availability Zones.

The objective of this project is to gain hands-on experience with core AWS networking and compute components and understand how traffic flows between public and private resources.

---

## 🎯 Objectives

Build an AWS infrastructure that demonstrates:

* VPC design
* Public and private subnets
* Route tables and routing
* Internet Gateway
* NAT Gateway
* EC2 instances
* Network ACLs
* Public vs private network access
* Multi-AZ architecture
* Internet access from private subnets

---

## 🏗️ Architecture

The infrastructure should be deployed across **two Availability Zones**.

```text
                              INTERNET
                                  |
                           Internet Gateway
                                  |
                    +-------------+-------------+
                    |            VPC            |
                    |                            |
          +---------+---------+   +--------------+--------+
          |    AZ-1           |   |       AZ-2             |
          |                   |   |                        |
          |  Public Subnet    |   |    Public Subnet      |
          |                   |   |                        |
          |  Web EC2           |   |    Web EC2             |
          |  NAT Gateway       |   |    NAT Gateway         |
          |                   |   |                        |
          +---------+---------+   +----------+-------------+
                    |                        |
              Public Route Table       Public Route Table
                    |                        |
          +---------+---------+   +----------+-------------+
          |  Private Subnet   |   |   Private Subnet      |
          |                   |   |                        |
          |  App EC2          |   |   App EC2              |
          |                   |   |                        |
          +-------------------+   +------------------------+
                    |                        |
                    +---------- NAT ---------+
                               |
                            INTERNET
```

---

# 🏢 Infrastructure Requirements

## 1. VPC

Create a dedicated VPC for the application.

Requirements:

* Define an appropriate CIDR range.
* Enable DNS support.
* Enable DNS hostnames.
* Use the VPC as the networking boundary for all resources.

Example:

```text
VPC
CIDR: 10.0.0.0/16
```

---

## 2. Availability Zones

Use **two Availability Zones** in the same AWS Region.

Example:

```text
Region: ap-south-1

AZ-1
AZ-2
```

The actual Availability Zones can be selected based on the AWS account.

---

# 🌐 Subnet Design

Create public and private subnets in both Availability Zones.

## Public Subnets

Public subnets will contain resources that require direct internet connectivity.

```text
Public Subnet AZ-1
10.0.1.0/24

Public Subnet AZ-2
10.0.2.0/24
```

Deploy:

* Web EC2
* NAT Gateway

---

## Private Subnets

Private subnets will contain application servers that should not be directly reachable from the internet.

```text
Private Subnet AZ-1
10.0.11.0/24

Private Subnet AZ-2
10.0.12.0/24
```

Deploy:

* Application EC2

---

# 🛣️ Route Tables

## Public Route Table

Create a public route table and associate it with both public subnets.

Required route:

```text
Destination       Target

10.0.0.0/16       local
0.0.0.0/0         Internet Gateway
```

The public route table provides internet connectivity to public resources.

---

## Private Route Tables

Create private route tables for the private subnets.

Private subnet traffic destined for the internet must go through a NAT Gateway.

Example:

```text
Private RT - AZ1

Destination       Target

10.0.0.0/16       local
0.0.0.0/0         NAT Gateway AZ1
```

```text
Private RT - AZ2

Destination       Target

10.0.0.0/16       local
0.0.0.0/0         NAT Gateway AZ2
```

---

# 🌍 Internet Gateway

Create and attach an **Internet Gateway** to the VPC.

The Internet Gateway should provide internet connectivity for resources in the public subnets.

Traffic flow:

```text
Internet
   |
Internet Gateway
   |
Public Route Table
   |
Public Subnet
   |
Web EC2
```

---

# 🚪 NAT Gateway

Deploy a NAT Gateway in each public subnet.

```text
NAT Gateway AZ-1
NAT Gateway AZ-2
```

Each NAT Gateway should have an Elastic IP.

Private EC2 instances should use the NAT Gateway for outbound internet access.

Traffic flow:

```text
Private EC2
     |
Private Route Table
     |
NAT Gateway
     |
Public Route Table
     |
Internet Gateway
     |
Internet
```

The private EC2 instances must **not have a direct route to the Internet Gateway**.

---

# 💻 EC2 Instances

Deploy EC2 instances across both Availability Zones.

## Web Tier

Deploy:

```text
Web EC2 - AZ1
Web EC2 - AZ2
```

These instances are located in public subnets.

They should be able to:

* Receive internet traffic.
* Access the internet.
* Communicate with the application tier as required.

---

## Application Tier

Deploy:

```text
App EC2 - AZ1
App EC2 - AZ2
```

These instances are located in private subnets.

They should:

* Not have public IP addresses.
* Not be directly accessible from the internet.
* Have outbound internet access through NAT Gateway.
* Be accessible only through the appropriate internal/application traffic path.

---

# 🔐 Network ACLs

Configure Network ACLs for the subnet layers.

The NACL configuration should demonstrate:

* Inbound traffic control.
* Outbound traffic control.
* Stateless behavior.
* Appropriate rules for required application traffic.
* Blocking of unnecessary traffic.

Design the NACL rules carefully so that legitimate traffic is allowed while unnecessary traffic is restricted.

---

# 🔄 Required Traffic Flows

Your final architecture should support the following traffic flows.

### 1. Internet → Web EC2

```text
Internet
   ↓
Internet Gateway
   ↓
Public Route Table
   ↓
Public Subnet
   ↓
Web EC2
```

---

### 2. Private EC2 → Internet

```text
Private EC2
   ↓
Private Route Table
   ↓
NAT Gateway
   ↓
Public Route Table
   ↓
Internet Gateway
   ↓
Internet
```

---

### 3. Internet → Private EC2

This traffic should **not be directly possible**.

```text
Internet
   X
Private EC2
```

---

### 4. Private EC2 → Internal Resources

Private EC2 instances should be able to communicate with other required resources inside the VPC according to the architecture and security requirements.

---

# 🧪 Validation Requirements

After deployment, verify the following.

## Public EC2

From the public EC2:

```bash
curl https://www.google.com
```

Expected:

```text
Internet access should work
```

---

## Private EC2

From the private EC2:

```bash
curl https://www.google.com
```

Expected:

```text
Internet access should work through NAT Gateway
```

---

## Internet Access to Private EC2

Attempt to directly access the private EC2 from the internet.

Expected:

```text
Connection should not be possible
```

---

## Route Validation

Verify:

```text
Public Subnet
    ↓
Internet Gateway
```

and:

```text
Private Subnet
    ↓
NAT Gateway
    ↓
Internet Gateway
```

---

# 📋 Expected AWS Resources

Your final environment should contain approximately:

```text
1 × VPC

2 × Availability Zones

2 × Public Subnets
2 × Private Subnets

1 × Internet Gateway

2 × Public Route Table associations
2 × Private Route Table associations

2 × NAT Gateways
2 × Elastic IPs

2 × Web EC2 instances
2 × Application EC2 instances

NACL configuration for subnet traffic
```

---

# 🧩 Phase 1 — Manual Implementation

Create the complete infrastructure manually using the AWS Console.

Focus on understanding:

* CIDR calculation
* Subnet placement
* Route table associations
* Internet Gateway routing
* NAT Gateway routing
* Public vs private EC2
* NACL behavior
* Multi-AZ design

Do not use Terraform in this phase.

---

# 🏗️ Phase 2 — Terraform Implementation

After successfully completing the manual implementation, recreate the same infrastructure using Terraform.

Suggested Terraform structure:

```text
aws-3tier-network/
│
├── README.md
│
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── vpc.tf
├── subnets.tf
├── route_tables.tf
├── internet_gateway.tf
├── nat_gateway.tf
├── nacl.tf
├── ec2.tf
├── outputs.tf
│
└── modules/
```

---

# 🎯 Skills You Should Gain

By completing this project, you should be able to explain:

* What makes a subnet public or private.
* How an Internet Gateway works.
* How NAT Gateway provides outbound connectivity.
* Why NAT Gateway must be deployed in a public subnet.
* How route tables control traffic.
* How public and private routing differ.
* How NACLs control subnet-level traffic.
* Why NACLs are stateless.
* How EC2 instances communicate across subnets.
* How to design a Multi-AZ architecture.
* How to convert an AWS architecture into Terraform.

---

# 🚀 Challenge

Once the basic architecture is working, extend the project with:

1. Application Load Balancer.
2. Auto Scaling Group.
3. Security Groups.
4. Bastion host or SSM-based private EC2 access.
5. CloudWatch monitoring.
6. Terraform modules.
7. Terraform remote state using S3.
8. CI/CD pipeline for Terraform.
9. Infrastructure validation using Terraform plan.
10. Multi-environment deployment:

```text
dev
staging
production
```

---

## Final Goal

The final implementation should demonstrate that you can take a **high-level production requirement**, design the AWS network architecture, implement it manually, validate the traffic flows, and then reproduce the complete infrastructure using **Terraform**.
