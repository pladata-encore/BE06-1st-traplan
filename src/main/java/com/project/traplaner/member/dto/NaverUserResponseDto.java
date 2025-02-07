package com.project.traplaner.member.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.Email;
import lombok.*;
import org.apache.tomcat.util.http.parser.Authorization;

import java.time.LocalDateTime;
import java.util.Properties;


@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class NaverUserResponseDto {


    @JsonProperty("resultcode")
    private String resultCode;

    @JsonProperty("message")
    private String message;

    @JsonProperty("response")
    private NaverUserDetail naverUserDetail;

    @Getter
    @Setter
    @ToString
    @NoArgsConstructor
    @AllArgsConstructor
    public static class NaverUserDetail {
        private String id;
        private String nickName;
        private String profileImage;
        private String age;
        private String gender;
        private String email;
        private String mobile;
        private String mobileE164;
        private String name;
        private String birthDay;
        private String birthYear;
    }


/*
    // "id": "32742776",
    @JsonProperty("id")
    private String id;

    // "nickname": "OpenAPI",
    @JsonProperty("nickname")
    private String nickName;

    // "profile_image": "https://ssl.pstatic.net/static/pwe/address/nodata_33x33.gif",
    @JsonProperty("profile_image")
    private String profileImage;

    // "age": "40-49",
    @JsonProperty("age")
    private String age;

    // "gender": "F",
    @JsonProperty("gender")
    private String gender;

    // "email": "openapi@naver.com",
    @JsonProperty("email")
    private String email;

    // "mobile": "010-0000-0000"
    @JsonProperty("mobile")
    private String mobile;

    // "mobile": "010-0000-0000"
    @JsonProperty("mobile_e164")
    private String mobileE164;

    // "name": "오픈 API",
    @JsonProperty("name")
    private String name;

    // "birthday": "10-01",
    @JsonProperty("birthday")
    private String birthDay;

    // "birthyear": "1900",
    @JsonProperty("birthyear")
    private String birthYear;

*/
}

//GET v1/nid/me HTTP/1.1
//Host: openapi.naver.com
//User-Agent: curl/7.43.0
//Accept: */*
//Content-Type: application/xml
//Authorization: Bearer {네이버 로그인 인증 후 받은 접근 토큰 값}
//응답 예시
//{
//  "resultcode": "00",
//  "message": "success",
//  "response": {
//    "email": "openapi@naver.com",
//    "nickname": "OpenAPI",
//    "profile_image": "https://ssl.pstatic.net/static/pwe/address/nodata_33x33.gif",
//    "age": "40-49",
//    "gender": "F",
//    "id": "32742776",
//    "name": "오픈 API",
//    "birthday": "10-01",
//    "birthyear": "1900",
//    "mobile": "010-0000-0000"
//  }
