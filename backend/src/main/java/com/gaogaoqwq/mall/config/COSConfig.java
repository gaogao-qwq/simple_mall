package com.gaogaoqwq.mall.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.qcloud.cos.COSClient;
import com.qcloud.cos.ClientConfig;
import com.qcloud.cos.auth.BasicCOSCredentials;
import com.qcloud.cos.auth.COSCredentials;
import com.qcloud.cos.region.Region;
import com.gaogaoqwq.mall.properties.CosProperties;

import lombok.RequiredArgsConstructor;

@Configuration
@RequiredArgsConstructor
public class COSConfig {

    final CosProperties cosProperties;

    @Bean
    public COSClient getCOSClient() {
        COSCredentials credentials = new BasicCOSCredentials(
                cosProperties.getSecretId(), cosProperties.getSecretKey());
        Region region = new Region(cosProperties.getRegion());
        ClientConfig clientConfig = new ClientConfig(region);
        return new COSClient(credentials, clientConfig);
    }

    @Bean
    public String getCOSBucketName() {
        return cosProperties.getBucketName();
    }

}
