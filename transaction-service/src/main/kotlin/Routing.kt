package dev.vulnerius

import io.ktor.http.*
import io.ktor.serialization.kotlinx.json.*
import io.ktor.server.application.*
import io.ktor.server.plugins.contentnegotiation.*
import io.ktor.server.plugins.statuspages.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import kotlinx.serialization.Serializable
import kotlin.random.Random

fun Application.configureRouting() {
    install(StatusPages) {
        exception<Throwable> { call, cause ->
            call.respondText(text = "500: $cause", status = HttpStatusCode.InternalServerError)
        }
    }

    install(ContentNegotiation) { json() }

    routing {
        get("/") {
            call.respondText("Bachelorthesis 2026 Transaction-Service")
        }

        post("/pay") {
            if(ERROR_RATE > 0 && Random.nextDouble() < ERROR_RATE) {
                call.respond(HttpStatusCode.InternalServerError, "Simulated error")
                return@post
            }

            if(LATENCY > 0) {
                Thread.sleep((LATENCY * 1000).toLong())
            }

            val paymentRequest = call.receive<PaymentRequest>()

            call.respond(HttpStatusCode.Created, "Payment processed for ${paymentRequest.user_id} and order ${paymentRequest.order_id}")
        }
    }
}

@Serializable
data class PaymentRequest(
    val user_id: String,
    val order_id: String,
    val amount: Double,
    val currency: String
)
