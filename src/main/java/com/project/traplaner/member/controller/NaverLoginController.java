package com.project.traplaner.member.controller;

import com.project.traplaner.member.service.NaverService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.Map;

@Controller
@Slf4j
@RequiredArgsConstructor
public class NaverLoginController {

    @Value("${sns.naver.client-id}")
    private String naverClientId;

    @Value("${sns.naver.redirect-uri}")
    private String naverRedirectUri;

    @Value("${sns.naver.client-secret}")
    private String naverClientSecret;

    private final NaverService naverService;

    /**
     * @param resValue   1) code: 토큰 발급용 1회용 코드
     *                   2) state: CORS 를 방지하기 위한 임의의 토큰
     * @param grant_type 1) 발급:'authorization_code'
     *                   2) 갱신:'refresh_token'
     *                   3) 삭제: 'delete'
     * @return public NaverLoginVo requestNaverLoginAccessToken(Map<String, String> resValue, String grant_type){
     * final String uri = UriComponentsBuilder
     * .fromUriString("https://nid.naver.com")
     * .path("/oauth2.0/token")
     * .queryParam("grant_type", grant_type)
     * .queryParam("client_id", this.client_id)
     * .queryParam("client_secret", this.client_secret)
     * .queryParam("code", resValue.get("code"))
     * .queryParam("state", resValue.get("state"))
     * .queryParam("refresh_token", resValue.get("refresh_token")) // Access_token 갱신시 사용
     * .build()
     * .encode()
     * .toUriString();
     * <p>
     * return webClient
     * .get()
     * .uri(uri)
     * .retrieve()
     * .bodyToMono(NaverLoginVo.class)
     * .block();
     * }
     * @description Naver 로그인을 위하여 Access_token을 발급받음
     */
    @GetMapping("/naver/login")
    public String naverLogin() {

        System.out.println("[dbg] naverLogin 진입!!");
        // 네이버 로그인 연동 URL
        // 요청 URL: https://nid.naver.com/oauth2.0/authorize?
        // 요청 변수 정보
        // response_type=code&
        // client_id=CLIENT_ID&
        // state=STATE_STRING&
        // redirect_uri=CALLBACK_URL
        String uri = "https://nid.naver.com/oauth2.0/authorize";
        uri += "?response_type=code";
        uri += "&client_id=" + naverClientId;
        uri += "&state=NAVER_STATE_STRING";
        uri += "&redirect_uri=" + naverRedirectUri; //localhost:8181/oauth/naver

        log.info("uri: ", uri);
        System.out.println("uri = " + uri);
        return "redirect:" + uri;
    }

    // 약속된 redirect uri로 인가코드가 수신된다.
    @GetMapping("/oauth/naver")
    public String authCodeNaver(@RequestParam String code,
                                @RequestParam String state,
                                HttpSession session) {

        log.info("RequestParam(code): ", code);
        System.out.println("[dbg] code" + code + ", state: " + state);

        // Server to Server 통신: traplaner <-> naver
//        apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
//        apiURL += "client_id=" + clientId;
//        apiURL += "&client_secret=" + clientSecret;
//        apiURL += "&redirect_uri=" + redirectURI;
//        apiURL += "&code=" + code;
//        apiURL += "&state=" + state;
        Map<String, String> params = new HashMap<>();
        params.put("clientId", naverClientId);
        params.put("clientSecret", naverClientSecret);
        params.put("redirect", naverRedirectUri);
        params.put("code", code);
        params.put("state", state);

        System.out.println("[dbg] ===========Params============");
        System.out.println("[dbg] clientId: " + naverClientId);
        System.out.println("[dbg] clientSecret: " + naverClientSecret);
        System.out.println("[dbg] redirect: " + naverRedirectUri);
        System.out.println("[dbg] code: " + code);
        System.out.println("[dbg] state: " + state);
        System.out.println("====================================");

        naverService.login(params, session);

        return "redirect:/";
    }


}
