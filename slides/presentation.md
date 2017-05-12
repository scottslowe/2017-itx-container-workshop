name: title
layout: true
class: middle, left
background-image: url(bg-title-slide.png)

---
name: divider
layout: true
class: middle, left
background-image: url(bg-divider-slide.png)

---
name: default
layout: true
class: top, left
background-image: url(bg-content-slide.png)

---
name: opening
template: title

# Deploying Containers to the Cloud

.white[_A review of some options and considerations for container deployments in public cloud environments_]

---
name: speaker-intro

## About me

* Husband, father, Jeeper, all-around geek
* Blogger (12 years at http://blog.scottlowe.org)
* Author (7 books so far, 2 more in the works)
* Speaker (Interop, VMworld, DevOps Networking Forum, OpenStack Summit, local meetups)
* Podcaster (The Full Stack Journey podcast)
* Employee at VMware, Inc., working on NSX and Cross-Cloud Services

---
name: agenda

## About this session

* Intended to provide high-level view of public cloud deployment options for containers
* **NOT** intended to cover all possible options or variations
* Will cover these scenarios, followed by a live demo of each:
    - Docker Swarm on AWS
    - AWS Elastic Container Service (ECS)
    - Kubernetes on AWS
    - Google Container Engine (GKE; runs Kubernetes)

---
name: housekeeping

## Before we start

* A PDF version of these slides will be available after the event
* There&rsquo;s a GitHub repository that contains files to allow you to replicate all demos (https://github.com/lowescott/2017-itx-container-workshop)
* Please exercise common courtesy (silence mobile devices, step outside if you need to take a call, etc.)

---
name: prerequisites
template: divider

# Prerequisites

---
template: default

## Before you deploy containers to the cloud&#8230;are you prepared?

* Do you have policies and a process for reproducible builds?
* Is your organization ready for containers and container orchestration?
* Have you addressed how you&rsquo;ll secure containers and container images?

---
## Guaranteeing reproducible builds

* Controlled sources for all packages
* No use of `:latest` for building Docker images (specific versions)
* Clear understanding of how base layers are built (be sure to review base layer&rsquo;s `Dockerfile` to understand dependencies)
* Official images are not exempt from review&#8212;see official MariaDB image `Dockerfile` for an example

---
template: divider

# Reproducible builds: Live demo

.white[**Tools:** Docker Hub, GitHub]

---
## Organizational readiness

* Who will own container images?
* Does your staff have the skills to support container orchestration frameworks?
* How&rsquo;s the interaction between your developers and your operations team(s)?
* Are your developers ready for microservices?
* This isn&rsquo;t just a technology issue&#8212;you also need to address organizational/cultural issues

---
## Container security

* Everything mentioned earlier about reproducible builds also applies here
* Most orchestration frameworks haven&rsquo;t yet defined mature mechanisms for providing network-based security controls for containers
* What about auditing and compliance? Ensuring consistent security policy between public cloud workloads and on-premises workloads?

---
template: divider

# TL;DR: There&rsquo;s a pretty fair amount of non-technical work that needs to be done before you start deploying containers to the cloud.

---
name: swarm-ec2-divider
template: divider

# Option 1: Docker Swarm on AWS EC2

---
## Swarm on EC2: Overview

* This illustrates a scenario where you&rsquo;re manually deploying/managing the container orchestration framework
* Leverages EC2 instances with Docker CE and Swarm mode
* Uses &ldquo;standard&rdquo; Docker concepts (containers, services, networks) and tools (like `docker-compose`)

---
## Swarm on EC2: Pros & cons

* **Pro:** Doesn&rsquo;t leverage any cloud-specific features
* **Con:** Lacks strong integration to cloud-specific features
* **Pro:** Theoretically possible to port or extend to any cloud provider with minimal changes
* **Pro:** Can use &ldquo;standard&rdquo; Docker concepts and tools
* **Con:** &ldquo;Locked in&rdquo; to Docker's tools, runtime, and images
* **Con:** User/consumer responsible for managing the orchestration framework

---
template: divider

# Swarm on EC2: Live demo

.white[**Tools:** Terraform, Ansible, Ubuntu Linux, Docker]

---
name: ecs-divider
template: divider

# Option 2: AWS Elastic Container Service (ECS)

---
## ECS: Overview

* This an example of leveraging a provider-supplied orchestration framework
* ECS leverages EC2 instances w/ an ECS Agent installed
* Key building blocks are task definitions, tasks (containers) and services (declarative deployments of containers)

---
## ECS: Pros & cons

* **Pro:** Doesn&rsquo;t require you (the consumer) to manage the orchestration framework; that&rsquo;s handled by AWS
* **Con:** Proprietary and specific to AWS
* **Con:** &ldquo;Locked in&rdquo; to AWS
* **Pro:** Tightly integrated with and leverages AWS-specific functionality

---
template: divider

# ECS: Live demo

.white[**Tools:** CloudFormation, Amazon RDS, Amazon Linux]

---
name: k8s-divider
template: divider

# Option 3: Kubernetes on AWS

---
## Kubernetes on AWS: Overview

* Another example of manually deploying and managing a container orchestration framework
* Uses Kubernetes on AWS
* Shows the use of a tool called `kops` to help automate the deployment of the Kubernetes cluster
* Key Kubernetes building blocks are pods (workload units), services (exposed endpoints for groups of pods), and deployments (declarative definitions of pods)

---
## Kubernetes on AWS: Pros & cons

* **Con:** User/consumer responsible for deploying and managing the orchestration framework
* **Pro:** More (potential) flexibility than a provider-managed orchestration framework
* **Pro:** Theoretically possible to port or extend to another cloud provider with minimal changes
* **Con:** Works differently than &ldquo;standard&rdquo; Docker tools and uses different concepts

---
template: divider

# Kubernetes on AWS: Live demo

.white[**Tools:** `kops`, Kubernetes, YAML definitions]

---
name: gke-divider
template: divider

# Option 4: Google Container Engine (GKE)

---
## GKE: Overview

* A bit of a unique case
* It&rsquo;s Kubernetes, but hosted on Google Cloud and managed by Google
* Same provider-agnostic building blocks (because it&rsquo;s Kubernetes), but without the user/consumer needing to manage the framework

---
## GKE: Pros & cons

* **Pro:** User/consumer doesn&rsquo;t need to manage the orchestration framework (like ECS)
* **Pro:** Not necessarily tightly tied to Google because Kubernetes can run on other providers
* **Con:** Works differently than &ldquo;standard&rdquo; Docker tools and uses different concepts
* **Pro:** Can easily leverage Google Cloud features/services, if so desired

---
template: divider

# GKE: Live demo

.white[**Tools:** GKE (Kubernetes), YAML definitions]

---
## Summary

.small[
* Provider-managed orchestration frameworks offload the management burden
* Consumer-managed frameworks offer more (potential) flexibility
* All options leverage Docker to some extent (some more than others)
* Kubernetes has both provider-managed and consumer-managed options, and supports multiple cloud platforms
* Docker Swarm has only consumer-managed options but does support multiple cloud platforms
]

---
template: divider

# Questions & answers

.white[What questions do you have?]

---
name: closing
template: title

# Thank you!

.white[
.large[**Scott Lowe**]  
Blog: http://blog.scottlowe.org/  
Twitter: https://twitter.com/scott_lowe  
GitHub: https://github.com/lowescott  
Life: Colossians 3:17
]
