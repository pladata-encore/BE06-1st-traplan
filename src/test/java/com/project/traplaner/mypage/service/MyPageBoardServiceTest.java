package com.project.traplaner.mypage.service;

import com.project.traplaner.entity.Travel;
import com.project.traplaner.mapper.MyPageBoardMapper;
import jakarta.validation.constraints.AssertTrue;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest

class MyPageBoardServiceTest {


    @Autowired
    MyPageBoardMapper  myPageBoardMapper;


    @Test
    @DisplayName("member_id가 2인 회원의 여행을 검색하면  '마루의 여행기'라는 제목을 가진 여행이 나올 것")
    void selectTest() throws ParseException {

        SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
        // given
        List<Travel> travel = myPageBoardMapper.selectTravelById(2);
        // when
       // String title = travel.getTitle();

        // then
//        System.out.println(travel.getId());
//        System.out.println(travel.getTitle());
//        System.out.println(travel.getCreatedAt().toString());
//        System.out.println(travel.getMemberId());
//        System.out.println(travel.getStartDate() + "~" + travel.getEndDate());
//
//        Date start = fmt.parse(travel.getStartDate().toString());
//        Date end = fmt.parse(travel.getEndDate().toString());

       // System.out.println(fmt.format(start) + " ~ " + fmt.format(end));


//        assertEquals();
    }


//    @Test
//    @DisplayName("delete test")
//    void deleteTest() {
//        // given
//        int id = 1;
//        int memberId = 2;
//        // when
//        myPageBoardMapper.deleteTravelByMemberOrder(id,memberId);
//
//        List<Travel> travel = myPageBoardMapper.selectTravelById(2);
//        // then
//        assertEquals(1, travel.size());
//    }


}