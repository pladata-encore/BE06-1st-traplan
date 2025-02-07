package com.project.traplaner.member.controller;

import com.project.traplaner.entity.Member;

import com.project.traplaner.main.dto.TopThreeFavoriteTravelDto;
import com.project.traplaner.member.dto.LoginRequestDto;
import com.project.traplaner.member.dto.LoginUserResponseDTO;
import com.project.traplaner.member.service.LoginResult;

import com.project.traplaner.member.service.MemberService;
import com.project.traplaner.member.dto.SignUpRequestDto;
import com.project.traplaner.util.FileUtils;
import com.project.traplaner.util.MailSenderService;
import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/members")
@Slf4j
@RequiredArgsConstructor
public class MemberController {

    private final MailSenderService mailSenderService;
    @Value("${file.upload.root-path}")
    private String rootPath;

    private final MemberService memberService;

    //비밀 번호 변경 양식 열기
    @GetMapping("/pw-change")
    public String pwChange() {
        return "member/pw-change";
    }
    //비밀번호 변경로직
    @PostMapping("pw-change")
    public String pwChange(@RequestParam("email") String email,
                           @RequestParam("password") String password)
    {
        memberService.changePassword(email,password);
        log.info(email);
        log.info("변경 비밀번호: {}", password);
        return "redirect:/members/sign-in";
    }


    // 회원가입 양식 열기
    @GetMapping("/sign-up")
    public String join() {
        return "member/sign-up";
    }

    // 회원 가입 요청
    @PostMapping("/sign-up")
    public String sing_up(SignUpRequestDto dto) {
        dto.setLoginMethod(Member.LoginMethod.COMMON);
        System.out.println(dto.getLoginMethod().toString());

        // s:파일 업로드 ----------------------
//        String savePath = FileUtils.uploadFile(dto.getProfileImage(), rootPathProfile);
        String savePath = FileUtils.uploadFile(dto.getProfileImage(), rootPath);

//        log.info("rootPathProfile: {}", rootPathProfile);
        log.info("rootPathProfile: {}", rootPath);
        log.info("signup(): savePath {}", savePath);
        // e:파일 업로드 -------------------------

        memberService.join(dto, savePath);

        return "member/sign-in";
    }

    // 이메일, 닉네임 중복 검사
    @PostMapping("/duplicateTest")
    @ResponseBody
    public ResponseEntity<?> check(@RequestBody Map<String, Object> params) {

        System.out.println("=====================================");

        log.info("type: {}", params.get("type"));
        log.info("keyword: {}", params.get("keyword"));

        boolean flag = memberService.duplicateTest((String) params.get("type"), (String) params.get("keyword"));
        return ResponseEntity.ok()
                .body(flag);
    }

    @GetMapping("/sign-in")
    public String index() {
        return "member/sign-in";
    }

    //로그인 요청
    @PostMapping("/sign-in")
    public String signIn(LoginRequestDto dto,
                         RedirectAttributes ra,
                         HttpServletResponse response,
                         HttpServletRequest request) {
        log.info("/member/sign-in: POST, dto: {}", dto);
        LoginResult result = memberService.authenticate(dto, request.getSession(), response);
        ra.addFlashAttribute("result", result);
        if (result == LoginResult.SUCCESS) { // 로그인 성공
            // 세션으로 로그인을 유지
            // 서비스에게 세션 객체와 이메일을 전달.
            memberService.maintainLoginState(request.getSession(), dto.getEmail());
            return "redirect:/";
        }
        return "redirect:/members/sign-in"; // 로그인 실패 시
    }

    @Value("${sns.kakao.Client-Id}")
    private String kakaoClientId;
    @Value("${sns.kakao.logout-redirect}")
    private String kakaoLogoutRedirectUri;

    //    @Value("${sns.naver.Client-Id}")
//    private  String naverClientId;
//    @Value("${sns.naver.logout-redirect}")
//    private String naverLogoutRedirectUri;
//
    //네이버 로그인 화면 요청
    @GetMapping("/naver-sign-in")
    public void naverSignIn() {

        System.out.println("[dbg] naver-sign-in 진입!!!");
        log.info("naver-sing-in 진입");

    }


    // 로그아웃 요청 처리
    @GetMapping("/sign-out")
    public String signOut(HttpSession session,
                          HttpServletRequest request,
                          HttpServletResponse response) {

        // sns 로그인 상태인지를 확인
        LoginUserResponseDTO dto
                = (LoginUserResponseDTO) session.getAttribute("login");



        if (dto.getLoginMethod().equals("KAKAO")) {
            log.info("카카오 로그인 한 사람 로그아웃!");
            memberService.kakaoLogout(dto, session);

            String reqUri = "https://kauth.kakao.com/oauth/logout";
            reqUri += "?client_id=" + kakaoClientId;
            reqUri += "&logout_redirect_uri=" + kakaoLogoutRedirectUri;

            return "redirect:" + reqUri;

        }
//        else if (dto.getLoginMethod().equals("NAVER")) {
//            memberService.naverLogout(dto, session);
//
//            String reqUri = "https://kauth.naver.com/oauth/logout";
//            reqUri += "?client_id=" + naverClientKey;
//            reqUri += "&logout_redirect_uri=" + naverLogoutRedirectUri;
//            return "redirect:" + reqUri;
//        }

        // 세션에서 로그인 정보 기록 삭제
        session.removeAttribute("login");

        // 세션 전체 무효화 (초기화)
        session.invalidate();


        return "redirect:/";
    }
    @PostMapping("/email")
    @ResponseBody
    public ResponseEntity<?> mailCheck(@RequestBody String email) {
        log.info("이메일 인증 요청 들어옴!: {}", email);
        try {
            String authNum = mailSenderService.joinMail(email);
            return ResponseEntity.ok().body(authNum);
        } catch (MessagingException e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

}