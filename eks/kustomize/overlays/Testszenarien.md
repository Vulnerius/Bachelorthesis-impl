# Testszenarien

Es wird getestet, wieviel Einsparung des Error Budgets das Canary Release mit AnalysisTemplate gegenüber einem Rolling Update
mit Grafana Alertmanager erreicht.
Der K6-Lasttest wird eine +|- Minute Sekunden vor dem Start der jeweiligen Deployment-Strategie ausgeführt.
Für jeden Versuchsablauf wird der Transaction Microservices mit dem entsprechenden Fehler versehen, damit in der Analyse erfasst werden kann, ob der injizierte Fehler ausschlaggebend war oder ob ein infrastrukturelles Problem vorgelegen hat. ([siehe Rolling Deployment Versuch 3](../loadtest/logs/benchmark/deployment-control/average-load-deployment-result.md) )
Jeder Versuchsablauf wird fünf mal durchgeführt. Dabei wird die Zeit vom Start des Deployments bis zur Detektion des Fehlers für beide Deployment Strategien erfasst und anschließend gemittelt. 
Für das Canary Release und das Rolling Update wird die Zeit bis zur Fehlererkennung und anschließend die Zeit bis zur Wiederherstellung des stabilen Zustands gemessen. 
Es werden folgende Testszenarien definiert.

## Testszenario A - Injizierte Fehlerrate
Mittels Umgebungsvariable wird der prozentuale Anteil an Fehlermeldungen gesteuert, den die k6-abgefragten Endpunkte erhalten.

Im ersten Versuchsdurchlauf wird die Fehlerrate auf 1% gesetzt. Dies befindet sich innerhalb der definierten Service Level Objectives 
und führt somit statistisch genau zum Verbrauch des Error Budgets, allerdings nicht zur Überschreitung. Es wird geprüft, inwiefern beide Analyse-Tools dennoch darauf reagiert.

Im zweiten Versuchsdurchlauf wird die Fehlerrate auf 5% gesetzt.

## Testszenario B - simulierte Latenzsteigerung

Obwohl das 90. und 99. Perzentil als SLO beschrieben wurden, wird für das Testszenario das 95. Perzentil als Maßstab gewählt.

Im Versuchslauf wird die doppelte Latenz zum SLO eingefügt.