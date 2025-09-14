# Accessing the files

<!--toc:start-->

- [Accessing the files](#accessing-the-files)
  - [Accessing files using Glob](#accessing-files-using-glob)
  - [Helm Hooks](#helm-hooks)
  - [Handling Hooks Failures](#handling-hooks-failures)
  <!--toc:end-->

We can acess the files in the `files` directory using
the `.Files.Get` function.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-configmap
data:
  application.properties: |-
{ { .Files.Get "files/application.properties" | indent 4 } }
```

## Accessing files using Glob

We can also use the `.Files.Glob` function to access multiple files
in a directory.

```yaml
{{ - $files := .Files.Glob "files/*.properties" -}}
{{- range $path, $file := $files -}}
{{ $path }}: |-
{{ $file.Data | indent 4 }}
{{- end -}}
```

## Helm Hooks

We have several helm hooks that we can use to run tasks at different stages.
They are:

- pre-install/post-install
- pre-delete/post-delete
- pre-upgrade/post-upgrade
- pre-rollback/post-rollback
- test

Hooks are defined in the metadata of a resource using the `helm.sh/hook` annotation.

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: "{{ .Release.Name }}-my-job"
  annotations:
    "helm.sh/hook": post-install,post-upgrade
    "helm.sh/hook-weight": "0"
    "helm.sh/hook-delete-policy": hook-succeeded
spec:
  template:
    spec:
      containers:
        - name: my-job
          image: busybox
          command: ["sh", "-c", "echo Hello, Kubernetes! && sleep 30"]
      restartPolicy: Never
```

Here, the job will run after the chart is installed or upgraded.
The `helm.sh/hook-weight` annotation is used to specify the order in which
the hooks are executed. Lower weights are executed first.

The `helm.sh/hook-delete-policy` annotation is used to specify when the hook
resource are deleted.The default value is `before-hook-creation`, which means
that the hook resource will be deleted before a new hook resource is created.

## Handling Hooks Failures

Currently,if a hook fails during installation or upgrade, the entire Helm
release will be reverted to its previous state. This means that any
resources created by the hook will be deleted, and the release will be
rolled back to the last successful state.

For the case of `post-upgrade` hooks, if the hook fails, the resources
will be left in their current state, and the release will be rolled back.

If we want to rollback the release even if the hook fails,we can
use the following command.

```bash
helm upgrade --atomic <release-name> <chart>
```
