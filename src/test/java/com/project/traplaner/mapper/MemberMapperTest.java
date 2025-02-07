package com.project.traplaner.mapper;

import com.project.traplaner.entity.Favorite;
import com.project.traplaner.entity.Member;
import com.project.traplaner.entity.Travel;
import com.project.traplaner.entity.TravelBoard;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

import static com.project.traplaner.entity.Member.*;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@Transactional
@Rollback(false)
class MemberMapperTest {

    @Autowired
    MemberMapper memberMapper;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Autowired
    TravelMapper travelMapper;

    @Autowired
    TravelBoardMapper travelBoardMapper;

    @Autowired
    FavoriteMapper favoriteMapper;

    @Test
    @DisplayName("Test DB 테이블 데이터 생성")
    void makeTestTableData() {

        int subscriberCount = 100;
        int randomPara = subscriberCount - 1;
        int favoriteCount = subscriberCount;
        int randomFavoritePara = (subscriberCount / 10) - 1;

        for (int i = 1; i <= subscriberCount; i++) {
            Member m = builder()
                    .nickName("테스트" + i)
                    .email("test" + i + "@abc.net")
                    .password(passwordEncoder.encode("1234@qwer"))
                    .loginMethod(LoginMethod.COMMON)
                    .profileImg("47a3e6ea4e1d4377ab87d07c85e1b124.png")
                    .build();
            boolean b = memberMapper.save(m);
        }

        for (int i = 1; i <= subscriberCount; i++) {
            int randNum = (int) (Math.random() * randomPara) + 1;
            int tmpMemberId = randNum;
            int tmpMemberNickNameId = randNum;

            LocalDateTime tmpStartDate = LocalDateTime.now();
            LocalDateTime tmpEndDate = LocalDateTime.now().plusDays(3);
            LocalDateTime tmpUpdatedDate =
                    LocalDateTime.now().plusDays(3 + (int) (Math.random() * randomPara) + 1);

            String fileName = String.format("0425d9dc324e4d2a822b8ac905123b%02d.jpg", (int) (Math.random() * 9) + 1);

            Travel travel = Travel.builder()
                    .memberId(tmpMemberId)
                    .title("여행-" + i)
                    .startDate(tmpStartDate)
                    .endDate(tmpEndDate)
                    .updatedAt(tmpUpdatedDate)
                    .share(true)
//                    .travelImg("\\0425d9dc324e4d2a822b8ac905123b9"
//                            + (int) (Math.random() * 9) + 1
//                            +"1.jpg")
                    .travelImg(fileName)
                    .build();
            travelMapper.save(travel);

            TravelBoard travelBoard = TravelBoard.builder()
                    .travelId(i)
                    .memberNickName("테스트" + tmpMemberNickNameId)
                    .writeDate(tmpEndDate)
                    .content("여행-" + i + " 좋았음. !!!!!!!!!!!!")
                    .build();
            travelBoardMapper.save(travelBoard);
        }

        for (int i = 1; i <= favoriteCount; i++) {
            int tmpFavoriteMemberId = (int) (Math.random() * randomFavoritePara) + 1;
            int tmpFavoriteTravelBoardId = (int) (Math.random() * randomFavoritePara) + 1;
            Favorite favorite = Favorite.builder()
                    .memberId(tmpFavoriteMemberId)
                    .travelBoardId(tmpFavoriteTravelBoardId)
                    .build();

            favoriteMapper.save(favorite);
        }

    }
}