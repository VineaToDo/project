package com.version1.service;

import com.version1.entity.DictItems;

public interface DictItemsService {

    boolean deleteById(int id);

    void saveDictItem(DictItems dictItems);

}
