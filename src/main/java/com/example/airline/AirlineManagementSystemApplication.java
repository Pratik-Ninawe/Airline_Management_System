package com.example.airline;

import org.springframework.boot.SpringApplication;
<<<<<<< HEAD
import org.springframework.boot.actuate.autoconfigure.web.server.ManagementContextAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
=======
import org.springframework.boot.autoconfigure.SpringBootApplication;
>>>>>>> 4ca9d0872d5e5fbc58a92a044ff565671cd3c713

@SpringBootApplication
public class AirlineManagementSystemApplication  {
	public static void main(String[] args) {
		SpringApplication.run(AirlineManagementSystemApplication.class, args);
	}
<<<<<<< HEAD
	@Configuration
	@Import(ManagementContextAutoConfiguration.class)
	static class ActuatorConfig {
		// This ensures Actuator endpoints are registered
	}
=======
>>>>>>> 4ca9d0872d5e5fbc58a92a044ff565671cd3c713
}