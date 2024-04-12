package com.gaogaoqwq.mall.properties;

import org.springframework.boot.context.properties.ConfigurationProperties;

import lombok.Data;

@Data
@ConfigurationProperties(prefix = "minio.properties")
public class MinioClientProperties {

    private String accessKey;

    private String secretKey;

    private String bucketName;

    private String endPoint;

}
