{{- define "templating-deep-dive.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "templating-deep-dive.labelSelectors" -}}
app: {{.Chart.Name}}
release: {{.Release.Name}}
{{- end -}}
