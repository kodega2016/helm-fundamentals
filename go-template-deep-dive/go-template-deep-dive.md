# Go Template Deep Dive

<!--toc:start-->

- [Go Template Deep Dive](#go-template-deep-dive)
  - [Introduction](#introduction)
  - [Conditional statement with if else](#conditional-statement-with-if-else)
  - [Variables in template](#variables-in-template)
  - [Using range to iterate over list](#using-range-to-iterate-over-list)
  - [Using range to iterate over map](#using-range-to-iterate-over-map)

## Introduction

We will explore the Go templating system in depth, covering
advanced features and techniques to create dynamic and flexible
templates.

So we can create a list of items with the following template:

```go
list: {{list 1 2 3}}
skill: {{list "flutter" "docker" "kubernetes" | toYaml | nindent 2}}

```

And dictonary with:

```go
my-dict: {{dict "name" "Khadga" "age" 28 "role" "Softare Engineer" "skills" (dict "flutter" "10" "golang" "6") | toYaml | nindent 2}}
```

We can define helpers functions to make our templates more
readable and reusable.

```go
{{- define "myHelper" -}}
  {{- /* Your helper logic here */ -}}
{{- end -}}
{{- template "myHelper" . -}}
```

Then we can use that helper in our main template.

```yaml
{ { include "myHelper" . } }
```

## Conditional statement with if else

We can have conditional statement with the following tempate.

```yaml
replicas: {{ if eq .Values.env "production" -}}5{{- else -}}1{{- end }}
```

## Variables in template

We can define variable in template using `$` operator.

```yaml
{{- $fullName := printf "%s-%s" .Release.Name .Chart.Name -}}
name: {{ $fullName | trunc 63 | trimSuffix "-" }}
```

To use the default value,we can use the `default` function.

```yaml
{{- .Values.customName |  default $fullName| trunc 63 | trimSuffix "-" }}
```

## Using range to iterate over list
To iterate over the list of values, we can use range.

```yaml
{{- range $idx,$svc:=(.Values.services | default list) }}
```

Then we can access `$idx` and `$svc` in the template,the `.` scope
is altered by the range operator so we need to use `$` for the top
level context.

```yaml
metadata:
  name: {{include "templating-deep-dive.fullname" $}}-svc-{{$idx}}
  labels:
    {{- include "templating-deep-dive.labelSelectors" $ | nindent 4}}
```

## Using range to iterate over map

We also can iterate over map and access its properties.
```yaml
services:
  svc1:
    type: ClusterIP
    port: 80
    targetPort: 80

  svc2:
    type: NodePort
    port: 80
    targetPort: 80
```

```yaml
{{- range $key,$svc:=(.Values.services | default list) }}
metadata:
  name: {{include "templating-deep-dive.fullname" $}}-{{$key}}
{{- end}}


## Understanding the `.` operator


The `.` operator is used to get the values from its context.So
if we are into global context then the . will return global 
values.

```yaml
.Values.Name
```

But if we are in the context of the dict,then we get the value
of that key-pair.

```yaml
.type
.port
```

If we want to access the global context value,then we can use `$`.
