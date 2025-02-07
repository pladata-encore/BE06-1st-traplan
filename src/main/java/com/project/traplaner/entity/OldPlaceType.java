package com.project.traplaner.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
@AllArgsConstructor
public enum OldPlaceType {

    LODGING("숙박시설", 1),
    RESTAURANT("휴게음식점", 2),
    LOCATION("관광지", 3),
    ETC("기타",4);


    private String type;
    private int value;

}