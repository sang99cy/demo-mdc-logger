package com.example.demomdclogger;

import io.prometheus.client.exemplars.tracer.otel_agent.OpenTelemetryAgentSpanContextSupplier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
@Configuration
public class PrometheusExemplarSamplerConfiguration {
    @Bean
    public OpenTelemetryAgentSpanContextSupplier openTelemetryAgentSpanContextSupplier() {
        // OpenTelemetryAgentSpanContextSupplier is from the opentelemetry agent jar, without using the agent will cause class not found error when running.
        return new OpenTelemetryAgentSpanContextSupplier();
    }
}
