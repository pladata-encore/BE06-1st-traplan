package com.project.traplaner.entity;

import lombok.*;
import java.time.LocalDateTime;

@Getter @ToString
@Setter
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class Travel {

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
