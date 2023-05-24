# Azure landing zones Terraform - Level 1

[![GitHub Super-Linter](https://github.com/benyboy84/azure-tf-enterprise/actions/workflows/build/badge.svg)](https://github.com/marketplace/actions/super-linter)

## Overview

To address enterprise complexity, we recommend isolating and decomposing a complex environment in multiple state files.

The main concern with state files is related to security, as a Terraform state file might contain credentials, security tokens, keys etc. It is reasonable that state files corresponding to different levels of privileges are stored separately.

Another concern with state file, which calls for segregation, is the speed of innovation: When someone is conducting a change for a resource in a given state file, no-one else can change the state file at the same time, so having a limited number of state files can hinder the testing or integration processes in the enterprise.

Finally since DevOps is building in teams, we want to unlock autonomy of teams yet delegating some functions (application teams will not re-invent the networking layers but build on it). It will mean the capability to read a state file to do rich composition but without the possibility to alter the state file from other teams.

![Levels Hierarchy - Cloud Adoption Framework for Terraform landing zones.](https://github.com/benyboy84/azure-tf-enterprise/blob/ft_management_groups/docs/media/Levels%20Hierarchy%20_%20Cloud%20Adoption%20Framework%20for%20Terraform%20landing%20zones.png)

### Level 1: Core platform governance

* The **Azure landing zone** (management groups, policies) this would include the core ALZ (formerly called enterprise-scale) capabilities with the related custom management group structures, subscriptions, policies configuration... 

This is currently split logically into the following capabilities (*links to further information on the Wiki*):

| Scope |
| :--- |
| [Management group]() |
| Service Principale and Role based Access |
| Poliicies and Policies Assignments |
