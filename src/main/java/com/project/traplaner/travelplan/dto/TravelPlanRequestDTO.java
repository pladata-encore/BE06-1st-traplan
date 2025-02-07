package com.project.traplaner.travelplan.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.project.traplaner.entity.Journey;
import com.project.traplaner.entity.Travel;
import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Setter
@Getter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class TravelPlanRequestDTO {

    private TravelInfo travel;

    @Setter @Getter @ToString
    public static class TravelInfo {

        @JsonProperty("title")
        private String title;
        @JsonProperty("startDate")
        private String startDate;
        @JsonProperty("endDate")
        private String endDate;

        public Travel toEntity(int memberId) {
            OffsetDateTime startOffsetDateTime = OffsetDateTime.parse(startDate);
            OffsetDateTime endOffsetDateTime = OffsetDateTime.parse(endDate);
            return Travel.builder()
                    .memberId(memberId)
                    .title(title)
                    .startDate(startOffsetDateTime.toLocalDateTime())
                    .endDate(endOffsetDateTime.toLocalDateTime())
                    .build();
        }
    }

    List<JourneyInfo> journeys;

    @Getter @Setter @ToString
    @JsonIgnoreProperties("reservation")
    public static class JourneyInfo {
        @JsonProperty("id")
        private int journeyId;
        @JsonProperty("day")
        private int day;
        @JsonProperty("date")
        private String date;
        @JsonProperty("location")
        private String location;
        @JsonProperty("title")
        private String journeyName;
        @JsonProperty("address")
        private String accommodationRoadAddressName;
        @JsonProperty("startTime")
        private String startTime;
        @JsonProperty("endTime")
        private String endTime;
        @JsonProperty("locationId")
        private String googleMapLocationPinInformation;
        private MultipartFile reservationConfirmImagePath;
        @JsonProperty("budget")
        private int budget;
        public Journey toEntity(int travelId, String filePath) {
            // 날짜 문자열을 OffsetDateTime으로 파싱 후 LocalDate로 변환
            OffsetDateTime offsetDateTime = OffsetDateTime.parse(date);
            LocalDate localDate = offsetDateTime.toLocalDate();
            // 시간 문자열을 LocalTime으로 파싱
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
            LocalTime localStartTime = LocalTime.parse(startTime, timeFormatter);
            LocalTime localEndTime = LocalTime.parse(endTime, timeFormatter);
            // LocalDate와 LocalTime을 결합하여 LocalDateTime 생성
            LocalDateTime s = LocalDateTime.of(localDate, localStartTime);
            LocalDateTime e = LocalDateTime.of(localDate, localEndTime);
            return Journey.builder()
                    .travelId(travelId)
                    .journeyName(journeyName)
                    .accommodationName(location)
                    .accommodationRoadAddressName(accommodationRoadAddressName)
                    .startTime(s)
                    .endTime(e)
                    .googleMapLocationPinInformation(googleMapLocationPinInformation)
                    .reservationConfirmImagePath(filePath)
                    .budget(budget)
                    .build();
        }
        public Journey toEntity(int travelId) {
            // 날짜 문자열을 OffsetDateTime으로 파싱 후 LocalDate로 변환
            OffsetDateTime offsetDateTime = OffsetDateTime.parse(date);
            LocalDate localDate = offsetDateTime.toLocalDate();
            // 시간 문자열을 LocalTime으로 파싱
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
            LocalTime localStartTime = LocalTime.parse(startTime, timeFormatter);
            LocalTime localEndTime = LocalTime.parse(endTime, timeFormatter);
            // LocalDate와 LocalTime을 결합하여 LocalDateTime 생성
            LocalDateTime s = LocalDateTime.of(localDate, localStartTime);
            LocalDateTime e = LocalDateTime.of(localDate, localEndTime);
            return Journey.builder()
                    .travelId(travelId)
                    .journeyName(journeyName)
                    .accommodationRoadAddressName(accommodationRoadAddressName)
                    .accommodationName(location)
                    .startTime(s)
                    .endTime(e)
                    .googleMapLocationPinInformation(googleMapLocationPinInformation)
                    .budget(budget)
                    .build();
        }
    }


}
