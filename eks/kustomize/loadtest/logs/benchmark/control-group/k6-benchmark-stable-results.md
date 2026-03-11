# Benchmark test

baseline test: 
    [Average-Load-Test-30m-Ergebnisse](average-load-test-stable-result.md)

Average-Load-Test of 5 runs:

    error_rate: 0.00% 
    http_reqs: 2.399,99/s

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
