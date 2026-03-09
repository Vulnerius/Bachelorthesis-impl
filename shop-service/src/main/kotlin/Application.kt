package dev.vulnerius

import io.ktor.server.application.*

fun main(args: Array<String>) {
    io.ktor.server.netty.EngineMain.main(args)
}

fun Application.module() {
    configureMonitoring()
    configureRouting()
}

val VERSION = System.getenv("VERSION") ?: "stable"
val PAYMENT_SERVICE_URL = System.getenv("PAYMENT_SERVICE_URL") ?: "http://transaction-service:8080/pay/simulate"
val ERROR_RATE = System.getenv("ERROR_RATE")?.toDoubleOrNull() ?: 0.0
val LATENCY = System.getenv("LATENCY")?.toDoubleOrNull() ?: 0.0
