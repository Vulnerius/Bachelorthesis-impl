# Benchmark test

baseline test: 
    [Average-Load-Test-30m-Ergebnisse](average-load-deployment-result.md)

Average Load-Test Metrics during Deployment:

    http_reqs: 2399.85/s
    error_rate: 0.00% (15 out of 4319846)

    shop-service:
        RPS: 1199.92
        http_req_duration:
            p(90)=2.35ms
            p(95)=4.15ms
            p(99)=26.16ms
    transaction-service:
        RPS: 1199.92
        http_req_duration:
            p(90)=2.23ms   
            p(95)=3.86ms
            p(99)=28.89ms

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
