package com.project.traplaner.main;

import com.project.traplaner.main.dto.TopThreeFavoriteTravelDto;
import com.project.traplaner.mapper.TravelMapper;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
@RequiredArgsConstructor
@Slf4j
public class MainController {

    private final TravelMapper travelMapper;

    @GetMapping("/")
    public String mainPage(HttpSession session, Model model) {

        log.info("main page 요청 들어옴!");

        if (session.getAttribute("login") != null) {
            log.info("로그인 중인 사용자");

            // Top 3 Favorite, 10/28, by jhjeong
            List<TopThreeFavoriteTravelDto> topThreeFavoriteTravelDtoList = travelMapper.findTopThree();
            System.out.println("--------------------------------------------------");
            System.out.println(topThreeFavoriteTravelDtoList.toString());
            System.out.println("--------------------------------------------------");
            model.addAttribute("topThree", topThreeFavoriteTravelDtoList);
        }

        return "index";
    }
}
