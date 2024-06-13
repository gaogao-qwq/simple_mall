package com.gaogaoqwq.mall.service.impl;

import org.springframework.stereotype.Service;

import com.gaogaoqwq.mall.config.COSConfig;
import com.gaogaoqwq.mall.service.OSSService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class COSServiceImpl implements OSSService {

    final COSConfig cosConfig;

    @Override
    public Boolean doesObjectExist(String key) {
        return cosConfig.getCOSClient()
                .doesObjectExist(cosConfig.getCOSBucketName(), key);
    }

    public String getObjectUrl(String key) {
        return cosConfig.getCOSClient()
                .getObjectUrl(cosConfig.getCOSBucketName(), key)
                .toString();
    }

    @Override
    public String getObjectUploadUrl(String key) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'getObjectUploadUrl'");
    }

}
