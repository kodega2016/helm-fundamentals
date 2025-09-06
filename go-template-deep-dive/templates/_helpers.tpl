{{- define "templating-deep-dive.fullname" -}}
{{$fullName:=printf "%s-%s" .Release.Name .Chart.Name }}
{{- .Values.customName |  default $fullName| trunc 63 | trimSuffix "-" }}
{{- end -}}
{{- define "templating-deep-dive.labelSelectors" -}}
app: {{.Chart.Name}}
release: {{.Release.Name}}
managedBy: {{.Release.Service}}
{{- end -}}
