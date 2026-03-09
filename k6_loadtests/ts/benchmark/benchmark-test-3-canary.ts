//@ts-ignore
import http from 'k6/http';
//@ts-ignore
import { check, sleep, group } from 'k6';
//@ts-ignore
import { Counter, Rate } from 'k6/metrics';


const shop_versionCounter = new Counter('shop_version_count');
const shop_versionRate = new Rate('shop_version_distribution');
const transaction_versionCounter = new Counter('transaction_version_count');
const transaction_versionRate = new Rate('transaction_version_distribution');

export const options = {
    scenarios: {
        baseline_load: {
            executor: 'constant-arrival-rate',
            rate: 1200,
            timeUnit: '1s',
            preAllocatedVUs: 75,
            maxVUs: 800,
            duration: "5m"
        },
    }
};

export default function () {

    group('shop', function () {
        const resShop = http.get('http://shop-service.thesis.svc.cluster.local/shop');

        const versionMatch = resShop.body.match(/version:\s*([^\s]+)/);
        const version = versionMatch ? versionMatch[1] : 'unknown';

        shop_versionCounter.add(1, { version: version });

        shop_versionRate.add(1, { version: version });

        check(resShop, {
            'shop service response status is 200': (r) => r.status === 200,
            'version detected': (r) => version !== 'unknown',
        });
    })

    group('transaction', function () {
        const resTrans = http.get('http://transaction-service.thesis.svc.cluster.local/pay');

        const versionMatch = resTrans.body.match(/version:\s*([^\s]+)/);
        const version = versionMatch ? versionMatch[1] : 'unknown';

        transaction_versionCounter.add(1, { version: version });

        transaction_versionRate.add(1, { version: version });

        check(resTrans, {
            'transaction service response status is 200': (r) => r.status === 200,
            'version detected': (r) => version !== 'unknown',
        });
    })

    sleep(0.3);
}