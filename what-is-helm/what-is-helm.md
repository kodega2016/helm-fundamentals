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
  - [Uninstalling a chart](#uninstalling-a-chart)
  - [Cleaning up the kubernetes resources](#cleaning-up-the-kubernetes-resources)
  - [Setting custom values via CLI(--set)](#setting-custom-values-via-cli-set)
  - [Setting custom values via file(yaml)](#setting-custom-values-via-fileyaml)
  - [Upgrading Helm Release(setting new values)](#upgrading-helm-releasesetting-new-values)
  - [Upgrading the chart version](#upgrading-the-chart-version)
  - [Rollback to a previous version](#rollback-to-a-previous-version)
  - [Helm Upgrade Configuration](#helm-upgrade-configuration)
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

To get the default username and password for the wordpress application we can check
the default values of the chart available in the artifact hub.

For wordpress the default username is user and password is generated randomly
generated and stored in the kubernetes secret.

so we can get the password using the following command:

```bash
kubectl get secret local-wp-wordpress \
  -o jsonpath="{.data.wordpress-password}" | base64 --decode
```

We can view the values from the release using the following command:

```bash
helm get values <release-name>
helm get values <release-name> --all # to view all values including default
```

To get the metadata information about the release we can use the following command:

```bash
helm get metadata <release-name>
helm get metadata my-wordpress
```

## Uninstalling a chart

We can uninstall a chart using the following command:

```bash
helm uninstall <release-name>
helm uninstall my-wordpress
```

It will remove all the resources except persistent volume claims created by the chart.

So we do manually delete the persistent volume claims using the following command:

```bash
kubectl delete pvc <pvc-name>
```

## Cleaning up the kubernetes resources

The helm uninstall command does not delete the persistent volume claims created by
the chart.So we need to manually delete the persistent volume claims using the following
command:

```bash
kubectl delete pvc --all # make sure you are in the correct namespace
```

In our wordpress example,after re-installing the chart we can see that new pods
connect to the old database and the data is still intact.

## Setting custom values via CLI(--set)

We can override the default values of the chart using the --set flag
in the helm install command.

```bash
helm install <release-name> <repo-name>/<chart-name> --set key1=value1,key2=value2
```

```bash
helm install local-wp bitnami/wordpress \
  --set "mariadb.auth.rootPassword=super_secret" \
  --set "mariadb.auth.password=app_password"
```

Now, we can get the values from the release using the following command:

```bash
helm get values <release-name>
helm get values local-wp
```

## Setting custom values via file(yaml)

We can also verride the default values of the chart using a custom
yaml configuration file.

We are going to use exising password from the secrets, so first lets
create a secret with the following command:

```bash
kubectl create secret generic custom-wp-credentials \
  --from-literal=wordpress-password=super_secret
```

Now we need to create a custom values.yaml file with the following content:

```yaml
wordpressUsername: kodega
existingSecret: custom-wp-credentials
replicaCount: 3
```

After that we can install the chart using the following command:

```bash
helm install local-wp bitnami/wordpress -f values.yaml
```

This will use the existing secret for the wordpress password and set it into
the deployment.

## Upgrading Helm Release(setting new values)

We can also upgrade the release version by setting new values and apply
the changes using the following command:

```bash
helm upgrade <release-name> <repo-name>/<chart-name> --set key1=value1,key2=value2
```

```bash
helm upgrade -f custom-values.yaml \
  --reuse-values local-wp bitnami/wordpress \
  --version 23.1.20
```

We also can get the history of the release using the following command:

```bash
helm history <release-name>
helm history local-wp
```

To get the value of a specific revision we can use the following command:

```bash
helm get values <release-name> --revision <revision-number>
helm get values local-wp --revision 1
```

## Upgrading the chart version

we can also upgrade the chart version using the following command:

```bash
helm upgrade <release-name> <repo-name>/<chart-name> --version <chart-version>
helm upgrade local-wp bitnami/wordpress --version 23.1.20
```

## Rollback to a previous version

Lets explore the rollback feature of helm.

First of all lets update the release with invalid image tag so that the pods
will go into crashloopbackoff state.

```bash
helm upgrade --reuse-values -f customer-values.yaml local-wp bitnami/wordpress \
  --set image.tag=invalid-tag
  --version 23.1.20
```

After some time we can see that the pods are in crashloopbackoff state.

Now, we can list the history of the release using the following command:

```bash
helm history local-wp
```

Now, we can rollback to the previous version using the following command:

```bash
helm rollback <release-name> <revision-number>
helm rollback local-wp 2
```

## Helm Upgrade Configuration

We can also provide different configuration options while upgrading the release.

```bash
helm upgrade --help
helm upgrade <release-name> <repo-name>/<chart-name> \
  --set key1=value1,key2=value2 \
  --version <chart-version> \
  --reuse-values \
  -f <custom-values.yaml> \
  --atomic \ # if the upgrade fails, it will rollback to the previous version
  --cleanup-on-fail \ # if the upgrade fails, it will delete the new resources created
  --debug \ # to enable debug mode
```
