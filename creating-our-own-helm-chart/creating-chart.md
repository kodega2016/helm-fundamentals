# Creating Our Own Chart

<!--toc:start-->

- [Creating Our Own Chart](#creating-our-own-chart)
  - [Creating our first helm chart](#creating-our-first-helm-chart)
  - [Packaging our helm chart](#packaging-our-helm-chart)

We can also create our own helm chart so that we have more control over the resources
that are created.

The content of a helm chart is stored in a directory with the following structure:

- Chart.yaml: contains metadata about the chart such as name,api version,app version,description
  etc.

- Values.yaml: contains the default values for the chart such as replica count,image
  repository,image tag,service type etc.

- Readme.md: contains information about the chart such as how to install it,how to
  use it etc.

- templates/: contains the Kubernetes resource templates that will be rendered using
  the values from Values.yaml and any overrides provided during installation.

- charts/: contains any dependencies that the chart may have.

The templates directory contains the kubernetes resource templates as well as
the unit tests for the chart.

There is also a helpers.tpl file that contains helper functions that can be used
to simplify the templates.

```mychart/
  Chart.yaml
  values.yaml
  README.md
  templates/
    Notes.txt
    deployment.yaml
    service.yaml
    _helpers.tpl
    tests/
      test-connection.yaml
  charts/
```

## Creating our first helm chart

After creating a directory called nginx and creating required files, we can check
the chart using the command:

```shell
# preview the chart
helm template nginx
```

To lint the chart for any errors, we can use the command:

```shell
helm lint nginx
```

To install the chart, we can use the command:

```shell
helm install local-nginx nginx
```

It will create a deployment and a service.

## Packaging our helm chart

We can package our chart configuration using the following command.

```bash
helm package nginx
```

It will create a tar file with name ngix-0.1.0.tgz.We can install
that chart using that folder with the following command.

```bash
helm install nginx.0.1.0.tgz
```
