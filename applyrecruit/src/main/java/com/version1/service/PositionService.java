package com.version1.service;

import com.version1.VO.QueryPositionVO;
import com.version1.entity.Position;
import org.springframework.data.domain.Page;

import java.util.List;

public interface PositionService {
    
    /**
     * @Description 根据已封装的查询对象参数，对职位列表进行分页排序查询
     * @Date 0:58 2018/5/15
     * @Param [queryParamVO]
     * @return org.springframework.data.domain.Page<com.version1.entity.Position>
     */
    Page<Position> findByQueryPosition(QueryPositionVO queryPositionVO);

//    Page<Position> findByQueryPosition(QueryPositionVO queryPositionVO);
//    Page<Position> findAllOrderBy(QueryPositionVO queryPositionVO);

    List<Position> findTopPositions();

    boolean downAllPast();

    void increaseHit(int id);

    int updateOrNewPosition(Position position);

    boolean publish(String ids);

    boolean offline(String ids);

    boolean delete(String ids);

    int lock(int id);

}
