package com.version1.service;

import java.io.Serializable;

public interface BaseService<T extends Serializable> {

    T findOne(String id);

}
