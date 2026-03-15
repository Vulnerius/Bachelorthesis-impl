# Testszenario Ablauf

start in kustomize-directory: apply loadtest/deployment-ANY
wait 1 min (2-3 dots in grafana k6 dashboard) - apply overlays dir respectively
change to testcase subdir respectively
export jsons & logs

from kustomize: delete loadtest/deployment-ANY
apply overlays/control-group

5 min cooldown --> Restart

## A
### CANARY:
kubectl apply -k overlays/control-group

k apply -k loadtest/deployment-bm/

Kubectl apply -k overlays/error-rate/1-percent/canary

kubectl get rollout shop-service-rollout -n thesis -o json > 5-shop.json

kubectl get rollout transaction-service-rollout -n thesis -o json > 5-transaction.json

kubectl get analysisrun -n thesis -o json > 5-analysis.json

kubectl get events -n thesis --sort-by='.lastTimestamp' -o custom-columns=LASTSEEN:.lastTimestamp,FIRSTSEEN:.firstTimestamp,TYPE:.type,REASON:.reason,OBJECT:.involvedObject.name,MESSAGE:.message > 5-events.txt

kubectl get events -n thesis -o json > 1-events-full.json

kubectl logs -n thesis-load-test …-1-… > 5-events.txt
kubectl logs -n thesis-load-test …-2-… >> 5-events.txt


### ROLLING:
kubectl apply -k overlays/control-group

k apply -k loadtest/deployment-rolling/

kubectl apply -k overlays/error-rate/1-percent/rolling

kubectl get events -n thesis -o json > 5-events-full.json

kubectl get events -n thesis --sort-by='.lastTimestamp' -o custom-columns=LASTSEEN:.lastTimestamp,FIRSTSEEN:.firstTimestamp,TYPE:.type,REASON:.reason,OBJECT:.involvedObject.name,MESSAGE:.message > 5-events.txt

kubectl get events -n thesis -o json > 1-events-full.json

## B:
### CANARY:
kubectl apply -k overlays/control-group

k apply -k loadtest/deployment-bm/

Kubectl apply -k overlays/latency/40ms/canary-global

kubectl get rollout shop-service-rollout -n thesis -o json > 1-shop.json

kubectl get rollout transaction-service-rollout -n thesis -o json > 1-transaction.json

kubectl get analysisrun -n thesis -o json > 1-analysis.json

kubectl get events -n thesis --sort-by='.lastTimestamp' -o custom-columns=LASTSEEN:.lastTimestamp,FIRSTSEEN:.firstTimestamp,TYPE:.type,REASON:.reason,OBJECT:.involvedObject.name,MESSAGE:.message > 1-events.txt

kubectl get events -n thesis -o json > 1-events-full.json

kubectl logs -n thesis-load-test …-1-… > k6.log
kubectl logs -n thesis-load-test …-2-… >> k6.log


### ROLLING:
kubectl apply -k overlays/control-group

k apply -k loadtest/deployment-rolling/

kubectl apply -k overlays/error-rate/1-percent/rolling

kubectl get events -n thesis -o json > 5-events-full.json

kubectl get events -n thesis --sort-by='.lastTimestamp' -o custom-columns=LASTSEEN:.lastTimestamp,FIRSTSEEN:.firstTimestamp,TYPE:.type,REASON:.reason,OBJECT:.involvedObject.name,MESSAGE:.message > 5-events.txt

kubectl logs -n thesis-load-test …-1-… > k6.log
kubectl logs -n thesis-load-test …-2-… >> k6.log