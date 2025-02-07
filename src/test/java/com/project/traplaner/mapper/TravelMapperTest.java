package com.project.traplaner.mapper;

import com.project.traplaner.main.dto.MainTravelDto;
import com.project.traplaner.main.dto.TopThreeFavoriteTravelDto;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@Transactional
@Rollback(false)
class TravelMapperTest {

    @Autowired
    TravelMapper travelMapper;

    @Test
    @DisplayName("TOP3 좋아요 여행 검색")
    void findTopThreeFavoriteTravel() {
        // given
        List<TopThreeFavoriteTravelDto> topThree = travelMapper.findTopThree();

        // when

        // then
        assertNotNull(topThree);
    }

    @Test
    @DisplayName("이메일로 가입자 작성 Travel 검색")
    void findByEmailTest() {
        // given
        String email = "test8@gamil.com";

        // when
        List<MainTravelDto> mainTravelDtoList
                = travelMapper.findByEmail("test8@gmail.com");

        // then
        assertNotNull(mainTravelDtoList);
    }


}