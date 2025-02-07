package com.project.traplaner.main.dto;

import lombok.*;

@Getter @Setter @ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TopThreeFavoriteTravelDto {

        private int id;               // 여행 ID
        private int memberId;         // 회원 ID
        private String memberNickName; // 회원 닉네임
        private String title;          // 여행 제목
        private String travelImg;      // 여행 이미지 URL
        private Integer likeCount;     // 좋아요 수
        private String content;        // 여행 게시판 내용

}

