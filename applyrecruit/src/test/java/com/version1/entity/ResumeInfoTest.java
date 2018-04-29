package com.version1.entity;

import com.version1.VO.EducationVO;
import com.version1.commons.utils.ReflectFieldUtil;
import com.version1.repository.ResumeRepository;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import static org.junit.Assert.*;

@RunWith(SpringRunner.class)
@SpringBootTest
@Slf4j
public class ResumeInfoTest {

    @Autowired
    private ResumeRepository resumeRepository;

    @Test
    public void JsonTest(){
//        ResumeVO resumeInfo = resumeRepository.findOne(1);
//        resumeInfo.setJsonInfo("{\"age\": 12, \"sex\": 0, \"name\": \"vinea\"}");
//        ResumeVO resumeInfo1 = resumeRepository.save(resumeInfo);
//        ResumeVO resumeInfo1 = resumeRepository.findByJsonInfoName();
//        log.info(resumeInfo1.toString());

//        System.out.println(resumeInfo.getJsonInfo());

//        ResumeInfo resumeInfo = new ResumeInfo();
//        log.info(resumeInfo.getClass().getName());


    }

    @Test
    public void ReflectTest() throws ParseException {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM");
        ResumeInfo resumeInfo = resumeRepository.findOne(4);

        EducationVO educationVO = new EducationVO();
//        {"major": "软件工程", "degree": 1, "school": "长沙理工大学", "single": 1, "endDate": "2018-04", "beginDate": "2017-07"}
        educationVO.setId(1);
        educationVO.setMajor("软件工程2");
        educationVO.setDegree(6);
        educationVO.setSchool("长沙理工大学");
        educationVO.setSingle(1);
        educationVO.setBeginDate(dateFormat.parse("2015-10"));
        educationVO.setEndDate(dateFormat.parse("2018-10"));


        ReflectFieldUtil.test(resumeInfo,"Education", educationVO);
        ResumeInfo resumeInfoNew = resumeRepository.save(resumeInfo);
        log.info(resumeInfoNew.getEducation());
    }


}