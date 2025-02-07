package com.project.traplaner.mypage.controller;

import com.project.traplaner.member.dto.LoginUserResponseDTO;
import com.project.traplaner.member.service.MemberService;
import com.project.traplaner.mypage.dto.ModifyMemberInfoDTO;
import com.project.traplaner.mypage.dto.response.TravelListResponseDTO;
import com.project.traplaner.mypage.service.MyPageBoardService;
import com.project.traplaner.travelBoard.dto.PageDTO;
import com.project.traplaner.travelplan.service.TravelService;
import com.project.traplaner.util.FileUtils;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MyPageController {

    private final MyPageBoardService myPageBoardService;
    private final MemberService memberService;
    private final TravelService travelService;

    // 마이페이지 메인 (달력 있는 곳)
    // 달력에 일정 띄워주는 작업 해야댐
    // 계정관리 페이지 작성 필요
    @GetMapping("/my-page/{member_id}")
    public String myPage(@PathVariable int member_id, Model model) {

        List<TravelListResponseDTO> dtoList = myPageBoardService.getList(member_id);
        model.addAttribute("dtoList", dtoList);

        return "member/my-page";
    }

    // 마이 페이지 내 게시물
    // db연동 아직 x
    @GetMapping("/my-page/mytravelboard/{nickName}")
    public String myBoard(@PathVariable String nickName, Model model,
                          @ModelAttribute("s") PageDTO page) {

        Map<String, Object> map = myPageBoardService.findBoardAll(nickName, page);

        model.addAttribute("dtoList", map.get("boardAll"));
        model.addAttribute("maker", map.get("pm"));

        return "member/my-board";
    }


    // 마이페이지 나의 여행
    @GetMapping("/my-page/mytravel/{member_id}")
    public String myTravel(@PathVariable int member_id, Model model,
                           @ModelAttribute("s") PageDTO page) {
        System.out.println("컨트롤ㄹ러러러러");

        Map<String, Object> map = myPageBoardService.findAll(member_id, page);

        model.addAttribute("list", map.get("travels"));
        model.addAttribute("maker", map.get("pm"));

        return "member/my-plan";
    }


    @GetMapping("/tempMain")
    public String tempMain() {

        return "old-main";
    }

    @PostMapping("/my-page/shareIs/{boardId}")
    @ResponseBody
    public ResponseEntity<?> shareIs(@PathVariable int boardId) {
        myPageBoardService.updateShare(boardId);

        return ResponseEntity.ok().body("success");
    }

    @PostMapping("/my-page/delete/{boardId}/{memberId}")
    @ResponseBody
    public ResponseEntity<?> deleteBoard(@PathVariable int boardId,
                                         @PathVariable int memberId,
                                         Model model,
                                         HttpSession session) {

        List<TravelListResponseDTO> dtoList = myPageBoardService.getList(memberId);

        model.addAttribute("list", dtoList);

        myPageBoardService.deleteBoard(boardId, session);

        return ResponseEntity.ok().body("success");
    }

    @GetMapping("/my-page/favorite/{memberId}")
    public String favorite(@PathVariable int memberId,
                           @ModelAttribute("s") PageDTO page,
                           Model model) {
        Map<String, Object> map = myPageBoardService.favorite(memberId, page);

        model.addAttribute("list", map.get("favorite") );
        model.addAttribute("maker", map.get("pm"));

        return "member/favorite";
    }

    @GetMapping("/my-page/pwChange")
    public String pwChange() {


        return "member/my-pw-change";
    }

    @PostMapping("/my-page/changeConfirm")
    public ResponseEntity<?> changeConfirm(@Validated @RequestBody ModifyMemberInfoDTO dto) {

        boolean b = memberService.updateInfo(dto);


        if (b) {
            return ResponseEntity.ok().body("success");
        } else {
            return ResponseEntity.ok().body("fail");
        }


    }


    @PostMapping("/my-page/nickNameChk/{newNick}")
    public ResponseEntity<?> nickNameChk(@PathVariable String newNick) {
        String type = "nickname";

        boolean b = memberService.duplicateTest(type, newNick);
        System.out.println(b);
        if (!b) {
            return ResponseEntity.ok().body("success");
        } else {
            return ResponseEntity.badRequest().body("fail");
        }

    }

    @GetMapping("my-page/board-info/{travelNo}")
    public String boardInfo(@PathVariable int travelNo, Model model) {
        Map<String, Object> travel = myPageBoardService.travel(travelNo);

        model.addAttribute("travel",travel.get("travels"));
        model.addAttribute("journey",travel.get("journeys"));

        return "member/my-board-info";
    }

    @Value("${file.upload.root-path}")
    private String rootPath;

    @PostMapping("/my-page/insert-board")
    public String insertTravelJourney(@RequestParam int travelId,
                                      @RequestParam MultipartFile travelImg,
                                      @RequestParam List<MultipartFile> journeyImage,
                                      @RequestParam String content,
                                      @RequestParam List<Integer> journeyId,
                                      RedirectAttributes ra,
                                      HttpSession session) {



        LoginUserResponseDTO login = (LoginUserResponseDTO) session.getAttribute("login");
        String nickName = login.getNickName();
        int id = login.getId();


        String savePath = FileUtils.uploadFile(travelImg, rootPath);

        myPageBoardService.updateTravelImg(travelId, savePath);
        myPageBoardService.createBoard(travelId, nickName, LocalDate.now(), content);


        for (int i = 0, j = journeyId.size(); i < j; i++ ) {
            String save = FileUtils.uploadFile(journeyImage.get(i), rootPath);
            myPageBoardService.updateJourneyImg(journeyId.get(i), save);
        }

        travelService.refreshLoginUserTravel(login.getEmail(), session);

        ra.addFlashAttribute("msg", "새로운 여행이 등록되었습니다!");


        return "redirect:/my-page/mytravel/" + id;
    }


}



