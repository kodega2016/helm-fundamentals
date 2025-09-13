# Accessing the files

<!--toc:start-->

- [Accessing the files](#accessing-the-files)
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
