# Go Template Deep Dive

<!--toc:start-->

- [Go Template Deep Dive](#go-template-deep-dive)
  - [Introduction](#introduction)
  - [Conditional statement with if else](#conditional-statement-with-if-else)
  - [Variables in template](#variables-in-template)
  - [Using range to iterate over list](#using-range-to-iterate-over-list)

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
