package com.project.traplaner.entity;

import lombok.*;


@Getter
@Setter
@NoArgsConstructor
@ToString
@AllArgsConstructor
@Builder
public class Favorite {
    private int id;
    private int memberId;
    private int travelBoardId;
}