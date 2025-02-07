package com.project.traplaner.entity;

/*
-- 회원 관리 테이블
CREATE TABLE `tbl_member` (
        `id`        int        NOT NULL        COMMENT 'NOT NULL',
        `nick_name`        varchar(30)        NOT NULL,
        `profile_img`        varchar(500)        NULL,
        `login_method`        ENUM('KAKAO','NAVER', 'COMMON')        NOT NULL,
        `password`        varchar(50)        NOT NULL,
        `email`        varchar(200)        NOT NULL
);
 */


import lombok.*;

@Getter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Member {
    private int id;
    private String nickName;
    private String profileImg;
    private String password;
    private String email;

    private LoginMethod loginMethod;

    @Getter @ToString @AllArgsConstructor
    public enum LoginMethod {
        KAKAO("KAKAO", 1),
        NAVER("NAVER", 2),
        COMMON("COMMON", 3);

        private String type;
        private int value;
    }

}