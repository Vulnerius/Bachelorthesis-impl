# Benchmark test

baseline test:
    constant arrival rate of 1200 RPS per Service for 30 minutes and parallelism 2
    preAllocatedVUs: 300
    maxVUs: 800

    function () {
        group('shop', function () {
            const resShop = http.get('http://shop-service.thesis.svc.cluster.local/shop');
            check(resShop, {
                'shop service response status is 200': (r) => r.status === 200 ,
                'shop version is stable': resShop.body.toString().includes("version: stable")
            });
        })
        
        group('transaction', function () {
            const resTrans = http.get('http://transaction-service.thesis.svc.cluster.local/pay');
            check(resTrans,{
                'transaction service response status is 200': (r) => r.status === 200,
                'transaction version is stable': (res) => res.body.toString().includes("version: stable")
            });
        })
        sleep(.3)
    }

Average-Load-Test of 5 runs:

    http_reqs: 2.399,99/s
    error_rate: 0.00%

    shop-service:
        RPS: 1.200,00
        http_req_duration:
            p(90)=1,51ms
            p(95)=1,99ms
            p(99)=4,73ms
    transaction-service:
        RPS: 1.200,00
        http_req_duration:
            p(90)=1,47ms   
            p(95)=1,85ms
            p(99)=4,07ms

Run 1: 10.03. 19:02 - 19:35
    
    error_rate: 0.00%
    shop-service:
        p(99)=5.44ms
    transaction-service:
        p(99)=4.82ms
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
        p(99)=4.93ms
    transaction-service:
        p(99)=4.03ms
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
        p(99)=4.34ms
    transaction-service:
        p(99)=3.72ms
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
        p(99)=4.68ms
    transaction-service:
        p(99)=4.10ms
POD 1:

    http_reqs: 1199.999168/s

    shop-service:
        RPS: 599.999584
        http_req_duration:
            p(90)=1.49ms
            p(95)=1.96ms
    transaction-service:
        RPS: 599.999584
        http_req_duration:
            p(90)=1.44ms   
            p(95)=1.82ms
[Average-Load-Test-30m-4_1](avg-load-30m/avg-load-4_1.log)

POD 2:

    http_reqs: 1199.998825/s

    shop-service:
        RPS: 599.999413
        http_req_duration:
            p(90)=1.49ms
            p(95)=1.96ms
    transaction-service:
        RPS: 599.999413
        http_req_duration:
            p(90)=1.45ms   
            p(95)=1.8ms
[Average-Load-Test-30m-4_2](avg-load-30m/avg-load-4_2.log)

Run 5: 10.03. 21:47 - 22:22

    error_rate: 0.00%
    shop-service:
        p(99)=4.25ms
    transaction-service:
        p(99)=3.70ms
POD 1:

    http_reqs: 1199.999706/s

    shop-service:
        RPS: 599.999853
        http_req_duration:
            p(90)=1.46ms
            p(95)=1.94ms
    transaction-service:
        RPS: 599.999853
        http_req_duration:
            p(90)=1.44ms   
            p(95)=1.85ms
[Average-Load-Test-30m-5_1](avg-load-30m/avg-load-5_1.log)

POD 2:

    http_reqs: 1199.985164/s    

    shop-service:
        RPS: 599.992582
        http_req_duration:
            p(90)=1.46ms
            p(95)=1.89ms
    transaction-service:
        RPS: 599.992582
        http_req_duration:
            p(90)=1.44ms   
            p(95)=1.8ms
[Average-Load-Test-30m-5_2](avg-load-30m/avg-load-5_2.log)

Grafana-Dashboard-Results über alle Test-Runs:

    shop-service:
        http_req_duration:
            p(95)=1.73ms
            p(99)=4.88ms
    transaction-service:
        http_req_duration:
            p(95)=1.67ms
            p(99)=4.20ms
