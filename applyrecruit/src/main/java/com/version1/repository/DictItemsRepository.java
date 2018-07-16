package com.version1.repository;

import com.version1.entity.DictItems;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface DictItemsRepository extends JpaRepository<DictItems,Integer> {


    @Modifying
    @Query("delete from DictItems c where c.id = ?1")
    void deleteById(Integer id);

}
