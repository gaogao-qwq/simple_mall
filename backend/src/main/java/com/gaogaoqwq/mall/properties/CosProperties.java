package com.gaogaoqwq.mall.properties;

import org.springframework.boot.context.properties.ConfigurationProperties;

import lombok.Data;

@Data
@ConfigurationProperties(prefix = "cos.properties")
public class CosProperties {

    private String secretId;

    private String secretKey;

    private String region;

    private String bucketName;

}
