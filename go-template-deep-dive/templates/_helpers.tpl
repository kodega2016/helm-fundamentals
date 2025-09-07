{{- define "templating-deep-dive.fullname" -}}
{{$fullName:=printf "%s-%s" .Release.Name .Chart.Name }}
{{- .Values.customName |  default $fullName| trunc 63 | trimSuffix "-" }}
{{- end -}}

{{- define "templating-deep-dive.labelSelectors" -}}
app: {{.Chart.Name}}
release: {{.Release.Name}}
managedBy: {{.Release.Service}}
{{- end -}}

{{- define "templating-deep-dive.service" -}}
{{- $sanitizePort:=int .port -}}
{{- if or (lt $sanitizePort 1) (gt $sanitizePort 65535) -}}
{{- fail "errors:port must be between 1 and 65535" -}}
{{- end -}}

{{- $sanitizePort:=int .port -}}
{{- if or (lt $sanitizePort 1) (gt $sanitizePort 65535) -}}
{{- fail "errors:port must be between 1 and 65535" -}}
{{- end -}}

{{- $allowedServiceTypes:=list "ClusterIP" "NodePort" -}}

{{- if not (has .type $allowedServiceTypes) -}}
{{- fail (printf "errors:invalid service type %s,service type must be one of %s" .type (join "," $allowedServiceTypes)) -}}
{{- end -}}

{{- end -}}