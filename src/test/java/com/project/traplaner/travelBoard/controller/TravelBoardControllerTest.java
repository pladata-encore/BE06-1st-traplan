package com.project.traplaner.travelBoard.controller;

import com.project.traplaner.entity.TravelBoard;
import com.project.traplaner.mapper.TravelBoardMapper;
import com.project.traplaner.travelBoard.dto.TravelBoardDetailResponseDTO;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;


@SpringBootTest
class TravelBoardControllerTest {

    @Autowired
    TravelBoardMapper  travelBoardMapper;

}