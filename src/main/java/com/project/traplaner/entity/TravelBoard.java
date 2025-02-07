package com.project.traplaner.entity;

import lombok.*;
import lombok.extern.slf4j.Slf4j;

import java.time.LocalDateTime;

/*
   1. 여행 목록 게시판 Entity 클래스
   2. 작성자: 정재훈
   3. 테이블 생성 SQL:
    CREATE TABLE `tbl_travel_board` (
    `id`        int        NOT NULL,
    `travel_id` int        NOT NULL,
    `member_nick_name`  varchar(30)   NOT NULL,
    `write_date`        datetime      NOT NULL,
    `content`           varchar(1000) NOT NULL
    );
 */

@Getter @Setter
@ToString @EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Slf4j
public class TravelBoard {
    private int id;
    private int travelId;
    private String memberNickName;
    private LocalDateTime writeDate;
    private String content;
}
