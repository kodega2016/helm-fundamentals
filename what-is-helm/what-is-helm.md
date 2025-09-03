# What is Helm?

<!--toc:start-->

- [What is Helm?](#what-is-helm)
  - [Introduction](#introduction)
  - [Why we need Helm?](#why-we-need-helm)
  - [Benifits of using Helm](#benifits-of-using-helm)
  - [Helm vs Kustomize](#helm-vs-kustomize)
  <!--toc:end-->

## Introduction

Helm is a package manager for kubernetes that simplifies the deployment and management
of the applications on kubernetes clusters, It allows user to define,install and
upgrade the application with pre-configured templates called charts.

It is like apt for debian or yum for redhat based systems.

## Why we need Helm?

- Managing complex application can be challenging,we need to write and manage multiple
  yaml files for deploying applications on kubernetes clusters.

- updating applications can be difficult, we need to manually update the yaml files
  and apply them to the cluster, there may be syntax errors or misconfigurations.

- Environment configuration overload, managing different configurations for
  different environments can be challenging,so we need to maintain multiple
  yaml files for different environments. So with helm we can easily manage
  different configurations for different environments.

- Also version controlling,taking history of changes and rollbacks can be
  difficult, with helm we can easily manage versions of our applications
  and rollbacks to previous versions if needed.

- With helm we can easily package multiple manifest into a single package called
  chart,and can deploy the application with a single command.

- Also we can automate the testing with the helm hooks and helm cli.

## Benifits of using Helm

**_Simplified Deployment Process:_**
It make sure to easily deploy all the components of an application with a single
command.

**_Consistency Across Multiple Environment_**
It ensure that deployments are consistent across different environments,and also
allows to override default values for different environments.

**_Efficient Release Management_**
We can perform upgrade and rollback with ease like single command.

**_Enhanced Collaboration_**
We can get access to a wide range of pre-configured charts from the
helm repositories,which can be easily shared and reused across teams.

**_Versioned Deployment_**
We also can manage different versions of our applications and rollbacks to previous
versions if needed.

## Helm vs Kustomize

Helm is a package manager for kubernetes that allows users to define,install and
upgrade applications using pre-configured templates called charts.

Whereas Kustomize is a tool for customizing kubernetes configurations without
managing templates so that we can create and manage different configurations
for different environments.

Helm is more suitable for managing complex applications with multiple components
and dependencies,whereas Kustomize is more suitable for managing simple applications
across different environments.
