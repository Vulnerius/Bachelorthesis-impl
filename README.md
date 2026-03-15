Bachelorthesis-zdd-k8s
============================== 

[![Build and Push Microservices](https://github.com/Vulnerius/Bachelorthesis-impl/actions/workflows/ci.yaml/badge.svg)](https://github.com/Vulnerius/Bachelorthesis-impl/actions/workflows/ci.yaml)

## Forschungsfrage

    Wie verringern SLO gesteuerte Canary Releases den Error Budget Verbrauch im Vergleich zu Rolling Updates?

## Szenario

    Rolling Updates haben keine Form der analytischen Überprüfung im Hinblick auf SLO-Verletzungen, deshalb wurde mithilfe vom Grafana Alertmanager die Überwachung des Deployments realisiert.   
    Für Canary Releases wurde mithilfe von Analysistemplates ein vergleichbares Szenario, im Hinblick auf Überprüfungsintervalle und Messmetrik erstellt. Da der Vorteil von Canary Releases gegenüber Rolling Updates jedoch darin besteht, 
    eine dedizierte Analyse der neuen Softwareversion vorzunehmen, wurde ein weiteres Szenario analysiert, das mithilfe von AnalysisTemplates speziell die SLO-Verletzungen der Canary Version überprüft.  

Zur Durchführung und den Testszenarien geht es [hier](eks/kustomize/overlays/Testszenarien.md)

## Tech-Stack:
- EKS / K8s + Helm [K8s](https://about.gitlab.com/images/applications/apps/eks.png) - v1.35
- K6 [K6](https://grafana.com/media/docs/k6/GrafanaLogo_k6_orange_icon.svg) - 1.3.0
- Prometheus [Prometheus](https://img.icons8.com/color/1200/prometheus-app.jpg) - v0.89.0
- Grafana [Grafana](https://img.icons8.com/external-tal-revivo-color-tal-revivo/1200/external-data-visualization-and-monitoring-with-support-for-graphite-and-influxdb-logo-color-tal-revivo.jpg)
- Argo Rollouts [Argo Rollouts](https://miro.medium.com/v2/resize:fit:1246/1%2AZJ10oT9u3uqJVT-Rkyb0bQ.png) - v1.8.4
- Kotlin / Ktor [Ktor](https://blog.jetbrains.com/wp-content/uploads/2018/11/kotlin-Ktor.png) - 2.3.0 / v3.4.0
- Cilium [Cilium](https://avatars.githubusercontent.com/u/21054566?s=280&v=4) - 1.18.6

## Architecture

[SysArchBaEKSCluster](docs-without-code/sys-arch.jpg)

## Cost-Overview
Datum,Uhrzeit,Betrag,Differenz zum Vorwert
07.03.,08:33,132.86$,-
07.03.,23:21,124.36$,-8.50$
08.03.,12:47,118.66$,-5.70$
09.03.,01:47,112.44$,-6.22$
09.03.,11:12,106.10$,-6.34$
09.03.,23:27,100.00$,-6.10$
11.03.,13:46,80.00$,-20.00$
12.03.,09:43,73.68$,-6.32$
12.03.,15:29,67.63$,-6.05$
13.03.,09:27,60.00$,-7.63$
13.03.,12:13,56.73$,-3.27$
14.03.,08:25,51.43$,-5.30$
14.03.,14:25,43.33$,-8.10$
14.03.,18:00,40.00$,-3.33$
14.03.,19:52,39.74$,-0.26$
15.03.,04:19,34.91$,-4.83$
15.03.,12:01,30.63$,-4.28$

### Cost Analyze by Service
[aws-cost-overview](docs-without-code/aws-cost-overview.png)