# What is Helm?

<!--toc:start-->

- [What is Helm?](#what-is-helm)
  - [Introduction](#introduction)
  - [Why we need Helm?](#why-we-need-helm)
  - [Benifits of using Helm](#benifits-of-using-helm)
  - [Helm vs Kustomize](#helm-vs-kustomize)
  - [Helm Architecture](#helm-architecture)
  - [Managing Helm Charts with cli](#managing-helm-charts-with-cli)
  - [Installing a chart](#installing-a-chart)
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

## Helm Architecture

**_Helm CLI_**
It is the command line interface for helm that allows users to interact with
the kubernetes cluster and manage the applications.It uses kubectl under the hood
to communicate with the kubernetes cluster.

We can use helm cli to perform various operations like installing,upgrading,
releasing and rolling back applications.

It renders the templates and generates the kubernetes manifest files
and then applies them to the kubernetes cluster using kubectl.

**_Helm Chart_**
It is a package format for the heml applications that contains all the necessary
configurations and templates required to deploy an application on kubernetes cluster.

It contains:

- Chart.yaml: It contains the metadata information about the chart like name,
  version,description etc.

- Values.yaml: It contains the default configuration values for the chart such as
  replicas

- Templates/: It contains the kubernetes manifest templates that are used to
  generate the kubernetes manifest files.

- Charts/: It contains the dependencies charts required by the main chart.

- templates/\_helpers.tpl: It contains the helper templates that can be used
  across the chart.

Charts can be simple like single deployment or complex like multi-tier
applications with multiple components and dependencies.

**_Release_**
Each running instance of the chart is called a release, we can have multiple
instances of the same chart running on the same kubernetes cluster.

The release is versioned,so we can easily manage different versions of the
applications and rollbacks to previous versions if needed.

## Managing Helm Charts with cli

We can use helm cli to manage the helm charts and releases.To
add the helm repository we can use the following command:

```bash
helm repo add <repo-name> <repo-url>
# install bitnami repo
helm repo add bitnami https://charts.bitnami.com/bitnami
```

To view the available charts in the repository we can use the following command:

```bash
helm repo list
```

To update the local cache of the charts we can use the following command:

```bash
helm repo update
```

We can search the helm charts in the repository using the following command:

```bash
helm search repo <chart-name>
helm search repo mysql
```

We can view the index of the chart using the following command:

```bash
helm show chart <repo-name>/<chart-name>
helm show chart bitnami/mysql
```

The tag is also used for searching the chart:

To list all the versions of a chart we can use the following command:

```bash
helm search repo <chart-name> --versions
```

To view the default values of a chart we can use the following command:

```bash
helm show values <repo-name>/<chart-name>
```

To remove the repository we can use the following command:

```bash
helm repo remove <repo-name>
helm repo remove bitnami
```

## Installing a chart

We can install a chart using the following command:

```bash
helm install <release-name> <repo-name>/<chart-name>
```

So, we are going to install wordpress chart from bitnami repository:

```bash
helm install my-wordpress bitnami/wordpress
```

To install the specific version of the chart we can use the following command:

```bash
helm install <release-name> <repo-name>/<chart-name> --version <chart-version>
helm install local-wp bitnami/wordpress --version 23.1.20
```

It will create a new release named my-wordpress and deploy the wordpress
application on the kubernetes cluster.
