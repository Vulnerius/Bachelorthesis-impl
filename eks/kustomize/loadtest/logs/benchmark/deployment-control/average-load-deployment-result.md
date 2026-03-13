# Benchmark test

baseline test:
    constant arrival rate of 1200 RPS per Service for 30 minutes and parallelism 2
    preAllocatedVUs: 75
    maxVUs: 400

    export default function () {
        
        group('shop', function () {
            const resShop = http.get('http://shop-service.thesis.svc.cluster.local/shop');
            
            const versionMatch = resShop.body.match(/version:\s*([^\s]+)/);
            const version = versionMatch ? versionMatch[1] : 'unknown';
            
            shop_versionCounter.add(1, { version: version });
            
            shop_versionRate.add(1, { version: version });
            
            check(resShop, {
                'shop service response status is 200': (r) => r.status === 200,
                [`shop version stable`]: () => version === 'stable',
                [`shop version canary`]: () => version === 'canary',
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
                [`transaction version stable`]: () => version === 'stable',
                [`transaction version canary`]: () => version === 'canary',
            });
        })
    }

Average-Load-Test of 5 runs Canary:

    http_reqs: 2399.85/s
    error_rate: 0.00%

    shop-service:
        RPS: 1199.92
        http_req_duration:
            p(90)=2.22ms
            p(95)=3.71ms
            p(99)=13.86ms
    transaction-service:
        RPS: 1199.92
        http_req_duration:
            p(90)=2.12ms   
            p(95)=3.38ms
            p(99)=16.26ms

Average-Load-Test of 5 runs Rolling:

    http_reqs: 2399.86/s
    error_rate: 0.00%

    shop-service:
        RPS: 1199.92/s
        http_req_duration:
            p(90)=2.47ms
            p(95)=4.58ms
            p(99)=38.46ms
    transaction-service:
        RPS: 1199.91/s 
        http_req_duration:
            p(90)=2.34ms   
            p(95)=4.35ms
            p(99)=41.52ms

Canary-Deployment
Run 1: 11.03. 12:04 - 12:39

    error_rate: 0.00%
    shop-service:
        p(99)=8.31ms
    transaction-service:
        p(99)=7.51ms
POD 1:

    http_reqs: 1199.906483/s

    shop-service:
        RPS: 599.953241
        http_req_duration:
            p(90)=1.88
            p(95)=3.49
    transaction-service:
        RPS: 599.953241
        http_req_duration:
            p(90)=1.81ms   
            p(95)=3.06ms
[Average-Load-Test-30m-1_1](avg-load-30m/canary/avg-load-canary-1_1.log)

POD 2:

    http_reqs: 1199.867167/s

    shop-service:
        RPS: 599.933584
        http_req_duration:
            p(90)=1.85
            p(95)=3.07
    transaction-service:
        RPS: 599.933584
        http_req_duration:
            p(90)=1.78ms   
            p(95)=2.77ms
[Average-Load-Test-30m-1_2](avg-load-30m/canary/avg-load-canary-1_2.log)

Run 2: 11.03. 13:19 - 13:52

    error_rate: 0.00%
    shop-service:
        p(99)=15.5ms
    transaction-service:
        p(99)=32.6ms
POD 1:

    http_reqs: 1199.917282/s

    shop-service:
        RPS: 599.958641
        http_req_duration:
            p(90)=1.9ms
            p(95)=2.95ms
    transaction-service:
        RPS: 599.958641
        http_req_duration:
            p(90)=1.88ms   
            p(95)=2.93ms
[Average-Load-Test-30m-2_1](avg-load-30m/canary/avg-load-canary-2_1.log)

POD 2:

    http_reqs: 1199.927483/s

    shop-service:
        RPS: 599.963742
        http_req_duration:
            p(90)=1.92ms
            p(95)=2.99ms
    transaction-service:
        RPS: 599.963742
        http_req_duration:
            p(90)=1.9ms   
            p(95)=2.84ms
[Average-Load-Test-30m-2_2](avg-load-30m/canary/avg-load-canary-2_2.log)

Run 3: 11.03. 14:35 - 15:05

    error_rate: 0.00%
    shop-service:
        p(99)=13.9ms
    transaction-service:
        p(99)=11.7ms
POD 1:

    http_reqs: 1199.917761/s

    shop-service:
        RPS: 599.95888
        http_req_duration:
            p(90)=2.78ms
            p(95)=4.96ms
    transaction-service:
        RPS: 599.95888
        http_req_duration:
            p(90)=2.54ms   
            p(95)=4.33ms
[Average-Load-Test-30m-3_1](avg-load-30m/canary/avg-load-canary-3_1.log)

POD 2:

    http_reqs: 1199.944561/s

    shop-service:
        RPS: 599.97228
        http_req_duration:
            p(90)=2.64ms
            p(95)=4.64ms
    transaction-service:
        RPS: 599.97228
        http_req_duration:
            p(90)=2.47ms   
            p(95)=4.08ms
[Average-Load-Test-30m-3_2](avg-load-30m/canary/avg-load-canary-3_2.log)

Run 4: 11.03. 15:49 - 16:21

    error_rate: 0.00%
    shop-service:
        p(99)=17.1ms
    transaction-service:
        p(99)=18.8ms
POD 1:

    http_reqs: 1199.906419/s

    shop-service:
        RPS: 599.953209
        http_req_duration:
            p(90)=2.63ms
            p(95)=4.26ms
    transaction-service:
        RPS: 599.953209
        http_req_duration:
            p(90)=2.47ms   
            p(95)=3.86ms
[Average-Load-Test-30m-4_1](avg-load-30m/canary/avg-load-canary-4_2.log)

POD 2:

    http_reqs: 1199.874694/s

    shop-service:
        RPS: 599.937347
        http_req_duration:
            p(90)=2.63ms
            p(95)=4.33ms
    transaction-service:
        RPS: 599.937347
        http_req_duration:
            p(90)=2.51ms   
            p(95)=4.02ms
[Average-Load-Test-30m-4_2](avg-load-30m/canary/avg-load-canary-4_1.log)

Run 5: 11.03. 17:02 - 17:35

    error_rate: 0.00%
    shop-service:
        p(99)=15.1ms
    transaction-service:
        p(99)=10.7ms
POD 1:

    http_reqs: 1199.95766/s

    shop-service:
        RPS: 599.97883
        http_req_duration:
            p(90)=1.99ms
            p(95)=3.2ms
    transaction-service:
        RPS: 599.97883
        http_req_duration:
            p(90)=1.91ms   
            p(95)=2.91ms
[Average-Load-Test-30m-5_1](avg-load-30m/canary/avg-load-canary-5_1.log)

POD 2:

    http_reqs: 1199.95236/s

    shop-service:
        RPS: 599.97618
        http_req_duration:
            p(90)=1.99ms
            p(95)=3.23ms
    transaction-service:
        RPS: 599.97618
        http_req_duration:
            p(90)=1.92ms   
            p(95)=2.95ms
[Average-Load-Test-30m-5_2](avg-load-30m/canary/avg-load-canary-5_2.log)

Rolling:
Run 1: 11.03. 12:43 - 13:18

    error_rate: 0.00%
    shop-service:
        p(99)=27.8ms
    transaction-service:
        p(99)=25.6ms
POD 1:

    http_reqs: 1199.934459/s

    shop-service:
        RPS: 599.967229
        http_req_duration:
            p(90)=2.12ms
            p(95)=3.71ms
    transaction-service:
        RPS: 599.967229
        http_req_duration:
            p(90)=1.96ms   
            p(95)=3.29ms
[Average-Load-Test-30m-1_1](avg-load-30m/rolling/avg-load-roll-1_1.log)

POD 2:

    http_reqs: 1199.913525/s

    shop-service:
        RPS: 599.956762
        http_req_duration:
            p(90)=2.1ms
            p(95)=3.65ms
    transaction-service:
        RPS: 599.956762
        http_req_duration:
            p(90)=1.96ms   
            p(95)=3.26ms
[Average-Load-Test-30m-1_2](avg-load-30m/rolling/avg-load-roll-1_2.log)

Run 2: 11.03. 14:02 - 14:33:30

    error_rate: 0.00%
    shop-service:
        p(99)=29.4ms
    transaction-service:
        p(99)=26.5ms
POD 1:

    http_reqs: 1199.977492/s

    shop-service:
        RPS: 599.988746
        http_req_duration:
            p(90)=2.03ms
            p(95)=3.64ms
    transaction-service:
        RPS: 599.988746
        http_req_duration:
            p(90)=2.03ms   
            p(95)=3.63ms
[Average-Load-Test-30m-2_1](avg-load-30m/rolling/avg-load-roll-2_1.log)

POD 2:

    http_reqs: 1199.915251/s

    shop-service:
        RPS: 599.957625
        http_req_duration:
            p(90)=2.09ms
            p(95)=3.7ms
    transaction-service:
        RPS: 599.957625
        http_req_duration:
            p(90)=2.05ms   
            p(95)=3.52ms
[Average-Load-Test-30m-2_2](avg-load-30m/rolling/avg-load-roll-2_2.log)

Run 3: 11.03. 15:13 - 15:48

    error_rate: 0.00% (15 out of 4.319.422)
    shop-service:
        p(99)=70.7ms
    transaction-service:
        p(99)=76.4ms
POD 1:

    error_rate: 0.00% (6 out of 2159662)
    http_reqs: 1199.81055/s

    shop-service:
        error_rate: 0.00% (2 out of 1079832)
        RPS: 599.905831
        http_req_duration:
            p(90)=3.75ms
            p(95)=7.36ms
    transaction-service:
        error_rate: 0.00% (4 out of 1079830)
        RPS: 599.90472
        http_req_duration:
            p(90)=3.44ms   
            p(95)=6.92ms
[Average-Load-Test-30m-3_1](avg-load-30m/rolling/avg-load-roll-3_1.log)

POD 2:

    error_rate: 0.00% (9 out of 2159760)
    http_reqs: 1199.86529/s

    shop-service:
        RPS: 599.934312
        http_req_duration:
            p(90)=3.81ms
            p(95)=7.53ms
    transaction-service:
        RPS: 599.930978
        http_req_duration:
            p(90)=3.59ms   
            p(95)=7.67ms
[Average-Load-Test-30m-3_2](avg-load-30m/rolling/avg-load-roll-3_2.log)

Run 4: 11.03. 16:27 - 17:01

    error_rate: 0.00%
    shop-service:
        p(99)=33.1ms
    transaction-service:
        p(99)=33.6ms
POD 1:

    http_reqs: 1199.930802/s

    shop-service:
        RPS: 599.965401
        http_req_duration:
            p(90)=2.62ms
            p(95)=4.96ms
    transaction-service:
        RPS: 599.965401
        http_req_duration:
            p(90)=2.41ms   
            p(95)=4.48ms
[Average-Load-Test-30m-4_1](avg-load-30m/rolling/avg-load-roll-4_1.log)

POD 2:

    http_reqs: 1199.896433/s

    shop-service:
        RPS: 599.948216
        http_req_duration:
            p(90)=2.64ms
            p(95)=5.15ms
    transaction-service:
        RPS: 599.948216
        http_req_duration:
            p(90)=2.41ms   
            p(95)=4.4ms
[Average-Load-Test-30m-4_2](avg-load-30m/rolling/avg-load-roll-4_2.log)

Run 5: 11.03. 17:37 - 18:10

    error_rate: 0.00%
    shop-service:
        p(99)=31.3ms
    transaction-service:
        p(99)=44.5ms
POD 1:

    http_reqs: 1199.971589/s

    shop-service:
        RPS: 599.985794
        http_req_duration:
            p(90)=1.75ms
            p(95)=3.03ms
    transaction-service:
        RPS: 599.985794
        http_req_duration:
            p(90)=1.76ms   
            p(95)=3.09ms
[Average-Load-Test-30m-5_1](avg-load-30m/rolling/avg-load-roll-5_1.log)

POD 2:

    http_reqs: 1199.938525/s

    shop-service:
        RPS: 599.969262
        http_req_duration:
            p(90)=1.81
            p(95)=3.07
    transaction-service:
        RPS: 599.969262
        http_req_duration:
            p(90)=1.79ms   
            p(95)=3.25ms
[Average-Load-Test-30m-5_2](avg-load-30m/avg-load-5_2.log)

Grafana-Dashboard-Results über alle Test-Runs (Canary + Rolling):

    shop-service:
        http_req_duration:
            p(95)=5.64ms
            p(99)=25.7ms
    transaction-service:
        http_req_duration:
            p(95)=6.15ms
            p(99)=28.2ms
