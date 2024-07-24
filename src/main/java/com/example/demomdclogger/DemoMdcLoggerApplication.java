package com.example.demomdclogger;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
public class DemoMdcLoggerApplication {
    private static final Logger logger = LoggerFactory.getLogger(DemoMdcLoggerApplication.class);

    public static void main(String[] args) {
        SpringApplication.run(DemoMdcLoggerApplication.class, args);
    }

    @RestController
    public class MyController {

        @GetMapping("/")
        public String hello() {
            logger.debug("Handling request to '/'");
            return "Hello, World!";
        }
    }

}
