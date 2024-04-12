package com.gaogaoqwq.mall.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.gaogaoqwq.mall.properties.MinioClientProperties;

import io.minio.MinioClient;
import lombok.RequiredArgsConstructor;

@Configuration
@RequiredArgsConstructor
public class MinioConfig {

    final MinioClientProperties minioProperties;

    @Bean
    public MinioClient getMinioClient() {
        return MinioClient.builder()
                .endpoint(minioProperties.getEndPoint())
                .credentials(minioProperties.getAccessKey(), minioProperties.getSecretKey())
                .build();
    }

    @Bean
    public String getBucketName() {
        return minioProperties.getBucketName();
    }
}
