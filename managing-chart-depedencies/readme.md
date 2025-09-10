# Managing Chart Dependencies

- [Managing Chart Dependencies](#managing-chart-dependencies)
  - [Introduction](#introduction)

## Introduction

We can have dependencies in our helm charts for example we have
a web application that needs a database, so we can have a dependency
on a database chart in our web application chart.

similarly we can have multiple dependencies in our chart.
Those dependencies is defined in the `Chart.yaml` file.

```yaml
dependencies:
    - name: mysql
        version: 1.6.9
        repository: https://charts.bitnami.com/bitnami
```

The subcahrts are placed in the `charts/` directory of the parent chart.

We can list the dependencies of a chart using the following command.

```bash
helm dependency list <chart-directory>
```

To update the dependencies of a chart,we need to update the `Chart.yaml`
file and then run the following command to download the dependencies
and place them in the `charts/` directory.

```bash
helm dependency update <chart-directory>
```

It will update the `Chart.lock` file with the updated dependencies.

Another commnand is to build the dependencies from the `Chart.yaml`
file and place them in the `charts/` directory.

```bash
helm dependency build <chart-directory>
```

It will build the dependencies and place them in the `charts/` directory.