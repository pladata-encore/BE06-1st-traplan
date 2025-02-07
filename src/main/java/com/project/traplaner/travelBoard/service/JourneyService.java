package com.project.traplaner.travelBoard.service;

import com.project.traplaner.mapper.TravelBoardMapper;
import com.project.traplaner.travelBoard.dto.JourneyResponseDTO;
import com.project.traplaner.travelBoard.dto.PageDTO;
import com.project.traplaner.travelBoard.dto.TravelBoardDetailResponseDTO;
import com.project.traplaner.travelBoard.dto.TravelBoardListResponseDTO;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
@Getter
public class JourneyService {

    private final TravelBoardMapper travelBoardMapper;

    public List<JourneyResponseDTO> getJourney(int id) {
        return travelBoardMapper.journeys(id);
    }

}
