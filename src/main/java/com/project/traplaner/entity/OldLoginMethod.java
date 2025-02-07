package com.project.traplaner.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
@AllArgsConstructor
public enum OldLoginMethod {

    KAKAO("KAKAO", 1),
    NAVER("NAVER", 2),
    COMMON("COMMON", 3);


    private String type;
    private int value;

}
