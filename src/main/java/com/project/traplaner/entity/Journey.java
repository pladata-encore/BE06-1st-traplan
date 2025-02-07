package com.project.traplaner.entity;

import lombok.*;

import java.time.LocalDateTime;

/*
    CREATE TABLE `tbl_journey` (
            `id`        int        NOT NULL  auto_increment primary key,
            `travel_id`        int        NULL,
            `journey_name`        varchar(100)        NOT NULL,
            `accommodation_name`        varchar(255)        NOT NULL,
            `accommodation_road_address_name`        varchar(255)        NOT NULL,
            `start_time`        datetime        NOT NULL,
            `end_time`        datetime        NOT NULL,
            `create_time`        datetime        NOT NULL,
            `update_time`        datetime        NULL,
            `google_map_location_pin_information`        varchar(50)        NOT NULL,
            `reservation_confirm_image_path`        varchar(500)        NULL,
            `share`        BOOLEAN        NOT NULL,
            `place_type`        ENUM('LODGING', 'RESTAURANT', 'LOCATION', 'ETC')        NOT NULL
    );
 */

@Getter
@Setter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Journey {

    private int id;
    private int travelId;
    private String journeyName;
    private String accommodationName;
    private String accommodationRoadAddressName;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private String googleMapLocationPinInformation;
    private String reservationConfirmImagePath;
    private boolean share;
    private PlaceType placeType;
    private String journeyImg;
    private int budget;

    @Getter @ToString @AllArgsConstructor
    public enum PlaceType {
        LODGING("숙박시설", 1),
        RESTAURANT("휴게음식점", 2),
        LOCATION("관광지", 3),
        ETC("기타",4);

        private String type;
        private int value;
    }
}