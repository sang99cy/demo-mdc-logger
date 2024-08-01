package com.example.demomdclogger;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@SpringBootApplication
public class DemoMdcLoggerApplication {

    @Autowired
    ApiService apiService;
    private static final Logger logger = LoggerFactory.getLogger(DemoMdcLoggerApplication.class);

    public static void main(String[] args) {
        SpringApplication.run(DemoMdcLoggerApplication.class, args);
    }

    @RestController
    public class MyController {

        @GetMapping("/")
        public String hello() {
            logger.debug("Handling request to '/'");
            String s =  apiService.callApi("http://ace-test-log:7800/demolog4j/v1/demo");
            return s;
        }
    }

}
