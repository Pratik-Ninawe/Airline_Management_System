package com.example.airline;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.actuate.autoconfigure.web.server.ManagementContextAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

@SpringBootApplication
public class AirlineManagementSystemApplication  {
	public static void main(String[] args) {
		SpringApplication.run(AirlineManagementSystemApplication.class, args);
	}
	@Configuration
	@Import(ManagementContextAutoConfiguration.class)
	static class ActuatorConfig {
		// This ensures Actuator endpoints are registered
	}
}