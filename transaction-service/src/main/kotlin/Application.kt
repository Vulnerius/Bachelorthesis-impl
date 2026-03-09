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
val ERROR_RATE = System.getenv("ERROR_RATE")?.toDoubleOrNull() ?: 0.0
val LATENCY = System.getenv("LATENCY")?.toDoubleOrNull() ?: 0.0
