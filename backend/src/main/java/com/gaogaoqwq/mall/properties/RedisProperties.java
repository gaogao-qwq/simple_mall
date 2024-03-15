package com.gaogaoqwq.mall.properties;

import org.springframework.boot.context.properties.ConfigurationProperties;

import lombok.Data;

@Data
@ConfigurationProperties(prefix = "redis.properties")
public class RedisProperties {

    private String hostname;

    private int port;

}
