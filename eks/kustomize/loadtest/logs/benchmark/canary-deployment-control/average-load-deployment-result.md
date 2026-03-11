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

Grafana-Dashboard-Results über alle Test-Runs:

    shop-service:
        http_req_duration:
            p(95)=
            p(99)=
    transaction-service:
        http_req_duration:
            p(95)=
            p(99)=

Average-Load-Test of 5 runs Canary:

    http_reqs:
    error_rate: 0.00%

    shop-service:
        RPS: 
        http_req_duration:
            p(90)=
            p(95)=
            p(99)=
    transaction-service:
        RPS: 
        http_req_duration:
            p(90)=   
            p(95)=
            p(99)=

Average-Load-Test of 5 runs Rolling:

    http_reqs:
    error_rate: 0.00%

    shop-service:
        RPS: 
        http_req_duration:
            p(90)=
            p(95)=
            p(99)=
    transaction-service:
        RPS: 
        http_req_duration:
            p(90)=   
            p(95)=
            p(99)=

Run 1: 11.03. 12:04 - 12:39

    error_rate: 0.00%
    shop-service:
        p(99)=
    transaction-service:
        p(99)=
POD 1:

    http_reqs: 

    shop-service:
        RPS: 
        http_req_duration:
            p(90)=
            p(95)=
    transaction-service:
        RPS: 
        http_req_duration:
            p(90)=   
            p(95)=
[Average-Load-Test-30m-1_1](avg-load-30m/avg-load-1_1.log)
POD 2:

    http_reqs: 

    shop-service:
        RPS: 
        http_req_duration:
            p(90)=
            p(95)=
    transaction-service:
        RPS: 
        http_req_duration:
            p(90)=   
            p(95)=
[Average-Load-Test-30m-1_2](avg-load-30m/avg-load-1_2.log)

Run 2: 10.03. 19:54 - 20:28

    error_rate: 0.00%
    shop-service:
        p(99)=
    transaction-service:
        p(99)=
POD 1:

    http_reqs: 

    shop-service:
        RPS: 
        http_req_duration:
            p(90)=
            p(95)=
    transaction-service:
        RPS: 
        http_req_duration:
            p(90)=   
            p(95)=
[Average-Load-Test-30m-2_1](avg-load-30m/avg-load-2_1.log)
POD 2:

    http_reqs: 1199.996678/s

    shop-service:
        RPS: 599.998339
        http_req_duration:
            p(90)=1.52ms
            p(95)=1.97ms
    transaction-service:
        RPS: 599.998339
        http_req_duration:
            p(90)=1.48ms   
            p(95)=1.84ms
[Average-Load-Test-30m-2_2](avg-load-30m/avg-load-2_2.log)

Run 3: 10.03. 20:31 - 21:05

    error_rate: 0.00%
    shop-service:
        p(99)=
    transaction-service:
        p(99)=
POD 1:

    http_reqs: 1199.999257/s

    shop-service:
        RPS: 1
        http_req_duration:
            p(90)=1.5ms
            p(95)=1.97ms
    transaction-service:
        RPS: 599.999629
        http_req_duration:
            p(90)=1.47ms   
            p(95)=1.82ms
[Average-Load-Test-30m-3_1](avg-load-30m/avg-load-3_1.log)
POD 2:

    http_reqs: 1199.998331/s

    shop-service:
        RPS: 599.999166
        http_req_duration:
            p(90)=1.51ms
            p(95)=2.01ms
    transaction-service:
        RPS: 599.999166
        http_req_duration:
            p(90)=1.47ms   
            p(95)=1.85ms
[Average-Load-Test-30m-3_2](avg-load-30m/avg-load-3_2.log)
Run 4: 10.03. 21:10 - 21:45

    error_rate: 0.00%
    shop-service:
        p(99)=
    transaction-service:
        p(99)=
POD 1:

    shop-service:
        RPS: 
        http_req_duration:
            p(90)=
            p(95)=
    transaction-service:
        RPS: 
        http_req_duration:
            p(90)=   
            p(95)=
[Average-Load-Test-30m-4_1](avg-load-30m/avg-load-4_1.log)
POD 2:

    shop-service:
        RPS: 
        http_req_duration:
            p(90)=
            p(95)=
    transaction-service:
        RPS: 
        http_req_duration:
            p(90)=   
            p(95)=
[Average-Load-Test-30m-4_2](avg-load-30m/avg-load-4_2.log)

Run 5: 10.03. 21:47 - 22:22

    error_rate: 0.00%
    shop-service:
        p(99)=
    transaction-service:
        p(99)=
POD 1:

    shop-service:
        RPS: 
        http_req_duration:
            p(90)=
            p(95)=
    transaction-service:
        RPS: 
        http_req_duration:
            p(90)=   
            p(95)=
[Average-Load-Test-30m-5_1](avg-load-30m/avg-load-5_1.log)
POD 2:

    shop-service:
        RPS: 
        http_req_duration:
            p(90)=
            p(95)=
    transaction-service:
        RPS: 
        http_req_duration:
            p(90)=   
            p(95)=
[Average-Load-Test-30m-5_2](avg-load-30m/avg-load-5_2.log)

Average-Load-Test of 5 runs Rolling:

Run 1: 10.03. 19:02 - 19:35

    error_rate: 0.00%
    shop-service:
        p(99)=
    transaction-service:
        p(99)=
POD 1:

    http_reqs: 1199.999795/s

    shop-service:
        RPS: 599.999897/s
        http_req_duration:
            p(90)=1.55ms
            p(95)=2.09ms
    transaction-service:
        RPS: 599.999897
        http_req_duration:
            p(90)=1.51ms   
            p(95)=1.95ms
[Average-Load-Test-30m-1_1](avg-load-30m/avg-load-1_1.log)
POD 2:

    http_reqs: 1199.99449/s

    shop-service:
        RPS: 599.997245
        http_req_duration:
            p(90)=1.54ms
            p(95)=2.03ms
    transaction-service:
        RPS: 599.997245
        http_req_duration:
            p(90)=1.51ms   
            p(95)=1.94ms
[Average-Load-Test-30m-1_2](avg-load-30m/avg-load-1_2.log)

Run 2: 10.03. 19:54 - 20:28

    error_rate: 0.00%
    shop-service:
        p(99)=
    transaction-service:
        p(99)=
POD 1:

    http_reqs: 1199.99933/s

    shop-service:
        RPS: 599.999665
        http_req_duration:
            p(90)=1.53ms
            p(95)=2.05ms
    transaction-service:
        RPS: 599.999665
        http_req_duration:
            p(90)=1.47ms   
            p(95)=1.83ms
[Average-Load-Test-30m-2_1](avg-load-30m/avg-load-2_1.log)
POD 2:

    http_reqs: 1199.996678/s

    shop-service:
        RPS: 599.998339
        http_req_duration:
            p(90)=1.52ms
            p(95)=1.97ms
    transaction-service:
        RPS: 599.998339
        http_req_duration:
            p(90)=1.48ms   
            p(95)=1.84ms
[Average-Load-Test-30m-2_2](avg-load-30m/avg-load-2_2.log)

Run 3: 10.03. 20:31 - 21:05

    error_rate: 0.00%
    shop-service:
        p(99)=
    transaction-service:
        p(99)=
POD 1:

    http_reqs: 1199.999257/s

    shop-service:
        RPS: 1
        http_req_duration:
            p(90)=1.5ms
            p(95)=1.97ms
    transaction-service:
        RPS: 599.999629
        http_req_duration:
            p(90)=1.47ms   
            p(95)=1.82ms
[Average-Load-Test-30m-3_1](avg-load-30m/avg-load-3_1.log)
POD 2:

    http_reqs: 1199.998331/s

    shop-service:
        RPS: 599.999166
        http_req_duration:
            p(90)=1.51ms
            p(95)=2.01ms
    transaction-service:
        RPS: 599.999166
        http_req_duration:
            p(90)=1.47ms   
            p(95)=1.85ms
[Average-Load-Test-30m-3_2](avg-load-30m/avg-load-3_2.log)
Run 4: 10.03. 21:10 - 21:45

    error_rate: 0.00%
    shop-service:
        p(99)=
    transaction-service:
        p(99)=
POD 1:

    shop-service:
        RPS: 
        http_req_duration:
            p(90)=
            p(95)=
    transaction-service:
        RPS: 
        http_req_duration:
            p(90)=   
            p(95)=
[Average-Load-Test-30m-4_1](avg-load-30m/avg-load-4_1.log)
POD 2:

    shop-service:
        RPS: 
        http_req_duration:
            p(90)=
            p(95)=
    transaction-service:
        RPS: 
        http_req_duration:
            p(90)=   
            p(95)=
[Average-Load-Test-30m-4_2](avg-load-30m/avg-load-4_2.log)

Run 5: 10.03. 21:47 - 22:22

    error_rate: 0.00%
    shop-service:
        p(99)=
    transaction-service:
        p(99)=
POD 1:

    shop-service:
        RPS: 
        http_req_duration:
            p(90)=
            p(95)=
    transaction-service:
        RPS: 
        http_req_duration:
            p(90)=   
            p(95)=
[Average-Load-Test-30m-5_1](avg-load-30m/avg-load-5_1.log)
POD 2:

    shop-service:
        RPS: 
        http_req_duration:
            p(90)=
            p(95)=
    transaction-service:
        RPS: 
        http_req_duration:
            p(90)=   
            p(95)=
[Average-Load-Test-30m-5_2](avg-load-30m/avg-load-5_2.log)
