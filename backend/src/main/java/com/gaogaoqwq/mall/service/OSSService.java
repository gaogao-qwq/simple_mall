package com.gaogaoqwq.mall.service;

public interface OSSService {

    public Boolean doesObjectExist(String key);

    public String getObjectUrl(String key);

}
