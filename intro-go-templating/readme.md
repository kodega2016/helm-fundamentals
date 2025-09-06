# Exploring Go Template for Helm Chart

<!--toc:start-->

- [Exploring Go Template for Helm Chart](#exploring-go-template-for-helm-chart)
  - [Introduction](#introduction)
  - [Function in template'](#function-in-template)

## Introduction

We can remove the white space that came from the go template using the `-`
before the comment.

```yaml
{{- /* this is a golang comment */}}
test: {{.Values.app_name}}
labels:
    app: {{.Chart.Name}}
    description: {{.Chart.Description}}
```

The values can be declared as the following.

```yaml
name: helm for beginner
```

We can preview the template file using the following command.

```bash
helm template .
```

To lint the configuration files,we can run the following command.

```bash
helm lint .
```

## Function in template'

In go template, we can pass the function and arguments in following
pattern.

```tmpl
name: {{upper .Release.Name}}
description: {{replace " " "-" .Chart.Description}}
```

Here, the upper and replace are the functions which takes number of
arguments.

We can also pipe the result of one function to another usign `|` symbol.

```yaml
name: {{replace " " "-" .Release.Name| upper}}
```

It will first replace the " " with "-" and change the words to
uppercase.
