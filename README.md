# DevOps Infrastructure & Configuration Management Automation

## Overview

This project is a practical DevOps automation and Infrastructure as Code (IaC) project that combines **Terraform, AWS, Ansible, Linux, Docker, Nginx, Jenkins, and Git**.

The project demonstrates how cloud infrastructure can be provisioned with Terraform and subsequently configured, secured, monitored, and deployed using Ansible automation.

It is designed as a reusable DevOps laboratory and portfolio project demonstrating infrastructure provisioning, configuration management, application deployment, system administration, and security automation.

---

## Project Objectives

The main objectives of this project are to:

- Provision AWS infrastructure using Terraform.
- Automate Linux server configuration using Ansible.
- Manage remote servers through SSH and Ansible.
- Automate package installation and system updates.
- Configure users and access permissions.
- Deploy and configure web servers.
- Automate Nginx and Apache-based applications.
- Deploy Docker workloads.
- Automate Jenkins installation and configuration.
- Perform system monitoring and security checks.
- Demonstrate Infrastructure as Code principles.
- Maintain infrastructure configuration in Git.
- Apply secure DevOps practices by keeping credentials and private keys outside the repository.

---

## Technologies & Tools

| Technology | Purpose |
|---|---|
| AWS | Cloud infrastructure |
| Terraform | Infrastructure as Code |
| Ansible | Configuration management and automation |
| Linux | Server operating system and administration |
| SSH | Secure remote server access |
| Docker | Containerization |
| Nginx | Web server and reverse proxy |
| Apache | Web server deployment |
| Jenkins | CI/CD automation |
| Git | Version control |
| GitHub | Source code management |
| YAML | Ansible configuration |
| Bash | System and automation scripting |

---

## High-Level Architecture

```text
                    ┌──────────────────────┐
                    │       GitHub         │
                    │  Source Repository   │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │      Terraform       │
                    │ Infrastructure as    │
                    │       Code           │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │        AWS           │
                    │                      │
                    │   EC2 Infrastructure │
                    └──────────┬───────────┘
                               │
                         SSH / Ansible
                               │
                               ▼
                    ┌──────────────────────┐
                    │       Ansible        │
                    │ Configuration Mgmt   │
                    └──────────┬───────────┘
                               │
             ┌─────────────────┼─────────────────┐
             ▼                 ▼                 ▼
        Linux Server       Web Server        Docker
             │                 │                 │
             ▼                 ▼                 ▼
        Users/Packages    Nginx/Apache       Containers
        Security/Updates  Applications        Services
