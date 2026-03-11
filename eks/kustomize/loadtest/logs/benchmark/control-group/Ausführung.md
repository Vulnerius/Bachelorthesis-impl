# Ablauf

## Threshold Benchmark Test

Im aktiven Betrieb der stable Version werden die Thresholds mittels Average-Load-Test erfasst,
die der jeweilige Service unter einer Last von 1200 RPS (Requests per Second) erreicht.
Diese Werte dienen als Referenz für die Erstellung der Service Level Obejctives des Systems.

Durchgeführt werden 5 Testläufe mit 1200 RPS je Service, über einen Zeitraum von 30 Minuten.
Erfasst werden die folgenden Metriken:
- Request-Latenz (P90)
- Request-Latenz (P95)
- Request-Latenz (P99)
- Fehlerquote (Error Rate)

Die Fehlerrate und die Latenz-Perzentile p(90) und p(95) werden aus der Zusammenfassung der K6-Testruns abgelesen.
Aus der Zusammenfassung der K6-Testergebnisse wird die p99-Latenz nicht angegeben, daher wird dieser Wert im Anschluss an den Test aus dem Grafana Dashboard abgelesen.

Die Ergebnisse der 5 Testläufe werden analysiert und die gemittelten Werte für die P90- P95- und P99-Latenz sowie die Fehlerquote festgestellt.

Es folgt die [Ermittlung der Latenz und Fehlerquote während des Deployments](../canary-deployment-control/Ausführung.md)
