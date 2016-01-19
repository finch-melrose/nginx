package finch.nginx.dev.service;


import com.ecwid.consul.v1.ConsulClient;
import com.ecwid.consul.v1.agent.AgentClient;
import com.ecwid.consul.v1.agent.AgentConsulClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.ServiceInstance;
import org.springframework.cloud.client.discovery.DiscoveryClient;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.client.loadbalancer.LoadBalancerClient;
import org.springframework.cloud.consul.ConsulProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.PreDestroy;
import java.io.IOException;
import java.util.List;

import static java.util.stream.Collectors.toList;
import static org.springframework.web.bind.annotation.RequestMethod.GET;

@EnableDiscoveryClient
@SpringBootApplication
@RestController
public class App {
    public static void main(String[] args) throws IOException {
        SpringApplication.run(App.class, args);
    }

    @Autowired
    private LoadBalancerClient loadBalancer;

    @Autowired
    private DiscoveryClient discoveryClient;

    @Autowired
    private ConsulProperties consulProperties;

    @Autowired
    private ConsulClient consulClient;

    @Value("${spring.cloud.consul.discovery.instanceId}")
    private String instanceId;

    @RequestMapping(value = "/", method = GET, produces = "application/json")
    public List<List<ServiceInstance>> index() {
        return discoveryClient.getServices().stream().map(n -> discoveryClient.getInstances(n)).collect(toList());
    }

    @RequestMapping(value = "/health", method = GET, produces = "application/json")
    public ServiceInstance health() {
        return discoveryClient.getLocalServiceInstance();
    }

    @PreDestroy
    public void deregister() {
        System.out.println("App.deregister");
        consulClient.agentServiceDeregister(instanceId);
    }
}
