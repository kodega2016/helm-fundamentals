# Go Template Deep Dive

<!--toc:start-->

- [Go Template Deep Dive](#go-template-deep-dive)
  - [Introduction](#introduction)
  <!--toc:end-->

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
