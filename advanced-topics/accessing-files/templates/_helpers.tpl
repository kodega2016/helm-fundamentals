{{- define "accessing-files.fullname" }}
  {{- $name:= default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
  {{- if contains $name .Release.Name -}}
    {{- $name | trunc 63 | trimSuffix "-" -}}
  {{- else -}}
    {{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
  {{- end -}}
{{- end }}
