package finch.nginx.dev.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.ServiceInstance;
import org.springframework.cloud.client.discovery.DiscoveryClient;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.client.loadbalancer.LoadBalancerClient;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

@EnableDiscoveryClient
@SpringBootApplication
@RestController
public class App {
    public static void main(String[] args) {
        SpringApplication.run(App.class, args);
    }

    @Autowired
    private LoadBalancerClient loadBalancer;

    @Autowired
    private DiscoveryClient discoveryClient;

    @RequestMapping(value = "/", method = GET, produces = "application/json")
    public ServiceInstance index() {
        return discoveryClient.getLocalServiceInstance();
    }

    @RequestMapping(value = "/health", method = GET, produces = "application/json")
    public ServiceInstance health() {
        return discoveryClient.getLocalServiceInstance();
    }

}
