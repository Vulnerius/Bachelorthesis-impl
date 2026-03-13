# SLO Definition based on Benchmark test

## SLO Allgemeingültig

Allgemeingültige Definition:
1. Gemessen werden die Indikatoren mit 1200 RPS pro Service über einen Zeitraum von 30 Minuten.

Error-Rate: 
  Metrik-Typ: Fehlerquote
  Messpunkt: k6_http_req_failed
  Metrik: Verhältnis der fehlgeschlagenen HTTP-Anfragen zu den gesamten HTTP-Anfragen
  Aggregation: rollierende Summe über zehn Minute
  Filter: Alle Anfragen pro Service mit Fehlerstatuscode (5xx)

Latenz:
  Metrik-Typ: Latenz
  Messpunkt: k6_http_req_duration
  Metrik: Zeit von der HTTP-GET Anfrage bis zum Erhalt der Antwort
  Aggregation: 90. 95. und 99. Perzentil über zehn Minute
  Filter: Alle erfolgreichen Anfragen pro Service (2xx)

## SLO Microservice spezifisch

Basierend auf den Ergebnissen des Benchmark Tests, können wir folgenden Service Level Objectives für die App definieren:
1. **Error-Rate**: Die Verfügbarkeit des jeweiligen Dienstes beträgt 99%.
2. **Latenz**:
   - shop-service:
     - 90% der Anfragen werden innerhalb von 8 ms beantwortet
     - 95% der Anfragen werden innerhalb von 20 ms beantwortet
     - 99% der Anfragen werden innerhalb von 150 ms beantwortet
   - transaction-service:
     - 90% der Anfragen werden innerhalb von 8 ms beantwortet
     - 95% der Anfragen werden innerhalb von 20 ms beantwortet
     - 99% der Anfragen werden innerhalb von 150 ms beantwortet

## Error Budget

Das Error Budget für die Fehlerquote beträgt 1%, (maximal 1% der HTTP-Anfragen dürfen fehlschlagen)

Das Error Budget für die Latenz ist so definiert, 
 dass 10% der Anfragen über 8ms, 5% der Anfragen über 20ms und 1% der Anfragen über 150ms Antwortzeit betragen dürfen.

## Bedeutung

Diese Definitionen gelten für jeden Microservice und definieren das Error Budget. Zur Einhaltung des Error-Budgets werden
der Grafana Alertmanager für das Rolling Update, sowie das AnalysisTemplate für die Canary Releases geringere Zeitabstände überwachen.
Weiter zum [Grafana Alertmanager](../../../../docs-without-code/grafana-alertmanager.md) und zum [AnalysisTemplate](TODO)
