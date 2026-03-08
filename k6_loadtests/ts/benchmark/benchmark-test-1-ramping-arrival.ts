// @ts-ignore
import http from 'k6/http';
// @ts-ignore
import {check, sleep} from 'k6';

export const options = {
    scenarios: {
        baseline_load: {
            executor: 'ramping-arrival-rate',
            startRate: 10,
            timeUnit: '1s',
            preAllocatedVUs: 50,
            maxVUs: 100,
            stages: [
                {duration: '5m', target: 150},
                {duration: '15m', target: 150},
                {duration: '2m', target: 0}
            ],
        },
    },
    thresholds: {
        http_req_failed: ['rate<0.01'],
        http_req_duration: ['p(95)<500'],
        http_reqs: ['rate>100']
    }
};

export default function () {
    // shop
    const resShop = http.get('http://shop-service.thesis.svc.cluster.local/shop');
    check(resShop, {'shop service response status is 200': (r) => r.status === 200});
    // transaction
    const resTrans = http.get('http://transaction-service.thesis.svc.cluster.local/pay');
    check(resTrans, {'transaction service response status is 200': (r) => r.status === 200});
}