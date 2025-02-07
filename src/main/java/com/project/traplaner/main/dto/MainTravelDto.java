package com.project.traplaner.main.dto;

import lombok.*;

import java.time.LocalDateTime;

@Getter @Setter @ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MainTravelDto {

    private int id;
    private int memberId;
    private String title;
    private boolean isDomestic;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private boolean share;
    private String travelImg;
}
