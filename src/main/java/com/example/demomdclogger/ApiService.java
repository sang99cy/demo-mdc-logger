package com.example.demomdclogger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class ApiService {

    @Autowired
    private RestTemplate restTemplate;

    public String callApi(String url) {
        return restTemplate.getForObject(url, String.class);
    }
}
