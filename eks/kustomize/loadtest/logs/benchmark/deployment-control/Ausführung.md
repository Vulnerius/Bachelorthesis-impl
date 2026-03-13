# Ablauf

## Threshold Benchmark während des Deployments

Da während des Deployments die Latenzen und ggf. die Fehlerquote beeinflusst sein kann, werden die Ergebnisse dieser Testläufe mit den Ergebnissen der stable Version verglichen,
um mögliche Auswirkungen des Deployments auf die Service-Performance zu identifizieren.
Es erfolgen 5 Testdurchläufe mit 1200 RPS pro Service über einen Zeitraum von 30 Minuten, während des Canary- und des Rolling Deployments.
Erfasst werden die folgenden Metriken:
- Request-Latenz (P90)
- Request-Latenz (P95)
- Request-Latenz (P99)
- Fehlerquote (Error Rate)
Diese Testergebnisse werden für die P90- P95- und P99-Latenz sowie die Fehlerquote während des Deployments gemittelt und mit den Werten aus dem aktiven Betrieb verglichen.

Die Fehlerrate und die Latenz-Perzentile p(90) und p(95) werden aus der Zusammenfassung der K6-Testruns abgelesen.
Die Zusammenfassung der K6-Testergebnisse enthält keine Werte für die p99-Latenz, daher wird dieser Wert im Anschluss an den Test aus dem Grafana Dashboard abgelesen.

Die Ergebnisse der 5 Testläufe werden analysiert und die gemittelten Werte für die P90- P95- und P99-Latenz sowie die Fehlerquote festgestellt.

Folgend erfolgt die Definition der Service Level Objectives (SLOs) für den jeweiligen Service basierend auf den analysierten Latenz-Perzentilen und der Fehlerquote.
Aus diesen SLOs werden dementsprechend der Alertmanager für das Rolling-Deployment und das Analysis-Template für den Canary Release erstellt,
um die Einhaltung der definierten SLOs während des Deployment-Prozesses zu überwachen und bei der Überschreitung Benachrichtigungen zu verfassen, bzw. das Canary Release abzubrechen. 

Weiter geht es zur [Definition der Service Level Objective](../../k6-benchmark-SLO.md)