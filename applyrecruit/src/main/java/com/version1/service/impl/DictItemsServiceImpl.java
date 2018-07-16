package com.version1.service.impl;

import com.version1.entity.Dict;
import com.version1.entity.DictItems;
import com.version1.repository.DictItemsRepository;
import com.version1.repository.DictRepository;
import com.version1.service.DictItemsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @ClassName DictItemsServiceImpl
 * @Description TODO
 * @Date 2018/5/23 1:38
 * @Version 1.0
 */
@Service
@Transactional
public class DictItemsServiceImpl implements DictItemsService {

    @Autowired
    private DictRepository dictRepository;

    @Autowired
    private DictItemsRepository dictItemsRepository;

    @Override
    @Transactional
    @Modifying
    @CacheEvict(allEntries = true)
    public boolean deleteById(int id) {
        try {
//            DictItems dictItems = dictItemsRepository.findOne(id);
//            dictItemsRepository.delete(dictItems);
            dictItemsRepository.deleteById(id);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    @Transactional
    @Modifying
    @CacheEvict(allEntries = true)
    public void saveDictItem(DictItems dictItems) {
        try {
            Dict dict = dictRepository.findOne(dictItems.getPid());
            if(dictItems.getId() != null){
                DictItems dictItemsOld = dictItemsRepository.findOne(dictItems.getId());
                dictItemsOld.setValue(dictItems.getValue());
                dictItemsRepository.saveAndFlush(dictItemsOld);
            }else{
                dictItems.setDict(dict);
                dictItemsRepository.saveAndFlush(dictItems);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
