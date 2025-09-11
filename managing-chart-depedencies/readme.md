# Managing Chart Dependencies

- [Managing Chart Dependencies](#managing-chart-dependencies)
  - [Introduction](#introduction)
  - [Sent value from parent chart to subchart](#sent-value-from-parent-chart-to-subchart)
  - [Global Values](#global-values)
  - [Including Names from subchart to parent chart](#including-names-from-subchart-to-parent-chart)

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

So after running the dependency update or build command we can see there
is a `charts/` directory created in the chart directory with the
dependencies and a `Chart.lock` file created with the dependencies
information.

If we remove the files in the `charts/` directory and then we can re-add
them using the `helm dependency build` command.

It will download the dependencies with the versions specified in the
`Chart.lock` file.

We can list the dependencies using the following command.

```bash
helm dependency list
```

## Sent value from parent chart to subchart

We can send values from the parent chart to the subchart using the
`values.yaml` file of the parent chart.

For example if we have a subchart named `demo-subchart` and we want to
pass the value `customValue` to the subchart we can do it like this.

```yaml
demo-subchart:
  customValue: "This value is sent from the parent chart"
```

## Global Values

We also can define global values that can be accessed by all the subcharts
using the `global` key in the `values.yaml` file of the parent chart.

```yaml
global:
  defaultStorageClass: my-custom-storage-class
```

And it the templates of the subchart we can access the global value like this.

```yaml
{{ .Values.global.defaultStorageClass }}
```

## Including Names from subchart to parent chart

We can include the names from the subchart to the parent chart using the
`include` function in the templates of the parent chart.

```yaml
{{ include "demo-subchart.fullname" . }}
```

Here, the context `.` is passed to the subchart so that it can access the values from the parent chart as well as its own values.

We can override the name of the subchart using the `nameOverride` key in the `values.yaml` file of the subchart.

```yaml
nameOverride: "This is from the subchart"
```
