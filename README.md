# Hybrid Cloud Network with Site-to-Site VPN (AWS + StrongSwan)

This project demonstrates the design and implementation of a secure **hybrid cloud architecture** by connecting an **on-premises Ubuntu Server** to an **AWS Virtual Private Cloud (VPC)** using **Site-to-Site (S2S) VPN** with **StrongSwan**.

It simulates a real-world enterprise setup involving secure private EC2 instances, NAT gateways, and fully automated Terraform infrastructure provisioning.

---

## 🎯 Project Goals

- Establish a **secure VPN tunnel** between an on-premises environment and AWS.
- Deploy a **private EC2 instance** in AWS that is only accessible from on-prem.
- Enable **bidirectional communication** between the two environments.
- Automate all infrastructure provisioning using **Terraform**.

---

## 🧱 Architecture Overview

```text
On-Prem (Ubuntu VM)
  ↕ Site-to-Site VPN (IPSec - StrongSwan)
AWS VPC
 ├── Public Subnet (NAT Gateway only)
 └── Private Subnet (EC2 instance, no public IP)

VPN Gateway (VGW) ⇄ Customer Gateway (CGW)

