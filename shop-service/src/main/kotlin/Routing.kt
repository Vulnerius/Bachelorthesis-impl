package dev.vulnerius

import io.ktor.client.HttpClient
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.client.engine.cio.CIO
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.client.plugins.contentnegotiation.*
import io.ktor.http.ContentType
import io.ktor.http.HttpStatusCode
import io.ktor.serialization.kotlinx.json.json
import io.ktor.server.plugins.statuspages.StatusPages
import io.ktor.server.response.*
import io.ktor.server.routing.*
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import kotlin.random.Random

fun Application.configureRouting() {
    install(io.ktor.server.plugins.contentnegotiation.ContentNegotiation) { json() }

    install(StatusPages) {
        exception<Throwable> { call, cause ->
            call.respondText(text = "500: $cause", status = HttpStatusCode.InternalServerError)
        }
    }

    routing {
        get("/") {
            call.respondText("Bachelorthesis 2026 Shop-Service")
        }

        get("/shop") {
            if(ERROR_RATE > 0 && Random.nextDouble() < ERROR_RATE) {
                call.respond(HttpStatusCode.InternalServerError, "Simulated shop error")
                return@get
            }

            if(LATENCY > 0) {
                Thread.sleep((LATENCY * 1000).toLong())
            }

            call.respond(HttpStatusCode.OK, "Welcome to the shop! Browse our products.")
        }

        post("/shop/checkout") {
            val testOrder = CheckoutRequest(
                user_id = "user-${System.currentTimeMillis()}",
                order_id = "order-${System.currentTimeMillis()}",
                amount = 29.99,
                currency = "EUR"
            )
            try {
                val response = postPayRequest(PAYMENT_SERVICE_URL, testOrder)
                if (response.status == HttpStatusCode.Created) {
                    call.respond(HttpStatusCode.OK, "Order processed")
                } else {
                    call.respond(response.status, "Payment service returned ${response.status}")
                }
            } catch (e: Exception) {
                log.error(e.message)
                call.respond(HttpStatusCode.ServiceUnavailable, "Payment service unreachable")
            }
        }
    }
}

val client = HttpClient(CIO) {
    install(ContentNegotiation) {
        json(Json {
            ignoreUnknownKeys = true
            prettyPrint = true
        })
    }
}

suspend fun postPayRequest(url: String, order: CheckoutRequest): HttpResponse {
    return client.post(url) {
        contentType(ContentType.Application.Json)
        setBody(order)
    }
}

@Serializable
data class CheckoutRequest(
    val user_id: String,
    val order_id: String,
    val amount: Double,
    val currency: String
)

