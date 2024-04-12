package com.gaogaoqwq.mall.service.impl;

import java.util.concurrent.TimeUnit;

import org.springframework.stereotype.Service;

import com.gaogaoqwq.mall.config.MinioConfig;
import com.gaogaoqwq.mall.service.OSSService;

import io.minio.GetObjectArgs;
import io.minio.GetPresignedObjectUrlArgs;
import io.minio.http.Method;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MinioServiceImpl implements OSSService {

    final private MinioConfig minioConfig;

    @Override
    public Boolean doesObjectExist(String key) {
        try {
            minioConfig.getMinioClient().getObject(
                    GetObjectArgs.builder()
                            .bucket(minioConfig.getBucketName())
                            .object(key)
                            .build());
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    public String getObjectUrl(String key) {
        try {
            return minioConfig.getMinioClient()
                    .getPresignedObjectUrl(GetPresignedObjectUrlArgs.builder()
                            .method(Method.GET)
                            .bucket(minioConfig.getBucketName())
                            .object(key)
                            .expiry(1, TimeUnit.DAYS)
                            .build());
        } catch (Exception e) {
            e.printStackTrace();
            return String.valueOf("");
        }
    }

}
