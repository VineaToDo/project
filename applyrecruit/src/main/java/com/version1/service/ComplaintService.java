package com.version1.service;

import com.version1.VO.QueryComplaint;
import com.version1.entity.Complaint;
import com.version1.entity.UserInfo;
import org.springframework.data.domain.Page;

public interface ComplaintService {

    Page<Complaint> findByQueryComplaint(QueryComplaint queryComplaint);

    boolean informPosition(int positionId, UserInfo userInfo, String reason);

}
