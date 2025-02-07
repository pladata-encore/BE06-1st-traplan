package com.project.traplaner.member.service;

import com.project.traplaner.entity.Member;
import com.project.traplaner.member.dto.NaverSignUpRequestDto;
import com.project.traplaner.member.dto.NaverUserResponseDto;
import com.project.traplaner.member.dto.SignUpRequestDto;
import jakarta.mail.Header;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.angus.mail.imap.SortTerm;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@RequiredArgsConstructor
@Service
@Slf4j
public class NaverService {

    private final MemberService memberService;

    public void login(Map<String, String> params, HttpSession session) {


        System.out.println("[dbg] login() : client_id " + params.get("clientId"));

        String accessToken = getNaverAccessToken(params);

        System.out.println("[dbg] login(): accessToken = " + accessToken);

        session.setAttribute("access_token", accessToken);

        // 발급받은 accessToken으로 사용자 정보 가져오기
        NaverUserResponseDto naverUser = getNaverUserInfo(accessToken);

        // 이제 네이버 인증 서버와의 연결은 더 필요하지 않습니다.
        // 문서에도 나와있었지만, 자체 로그인 처리 완료는 우리 서비스에서 마무리 지어 줘야 합니다.
        // 사이트 회원가입 시키기

        if (!memberService.duplicateTest("email", naverUser.getNaverUserDetail().getEmail())) {

            // 한번도 회원 가입한 적이 없다면, 회원 가입 수행
            memberService.join(SignUpRequestDto.builder()
                            .email(naverUser.getNaverUserDetail().getEmail())
                            .password(UUID.randomUUID().toString())
                            .loginMethod(Member.LoginMethod.NAVER)
                            .build(),naverUser.getNaverUserDetail().getProfileImage());
        }
        memberService.maintainLoginState(session, naverUser.getNaverUserDetail().getId());
    }

    private NaverUserResponseDto getNaverUserInfo(String accessToken) {

        // apiURL: https://openapi.naver.com/v1/nid/me
        String requestUri = "https://openapi.naver.com/v1/nid/me";

        // 요청헤더
        //GET v1/nid/me HTTP/1.1
        //Host: openapi.naver.com
        //User-Agent: curl/7.43.0
        //Accept: */*
        //Content-Type: application/xml
        //Authorization: Bearer {네이버 로그인 인증 후 받은 접근 토큰 값}
        // Authorization: Bearer AAAAOLtP40eH6P5S4Z4FpFl77n3FD5I+W3ost3oDZq/nbcS+7MAYXwXbT3Y7Ib3dnvcqHkcK0e5/rw6ajF7S/QlJAgUukpp1OGkG0vzi16hcRNYX6RcQ6kPxB0oAvqfUPJiJw==

        System.out.println("[dbg] getNaverUserInfo(): accessToken = " + accessToken);

        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "Bearer " + accessToken);
        headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        // 요청 보내기
        RestTemplate template = new RestTemplate();
        ResponseEntity<NaverUserResponseDto> responseEntity = template.exchange(
                requestUri,
                HttpMethod.POST,
                new HttpEntity<>(headers),
                NaverUserResponseDto.class
        );

//        ResponseEntity<String> responseEntity = template.exchange(
//                requestUri,
//                HttpMethod.POST,
//                new HttpEntity<>(headers),
//                String.class
//        );
//        System.out.println("responseEntity = " + responseEntity);

        NaverUserResponseDto userInfo = responseEntity.getBody();

        System.out.println("[dbg] getNaverUserInfo(): userInfo = " + userInfo);
        System.out.println("[dbg] getNaverUserInfo(): userInfo.email" + userInfo.getNaverUserDetail().getEmail());


        return userInfo;
    }

    private String getNaverAccessToken(Map<String, String> requestParam) {

        // Server to Server 통신: traplaner <-> naver
        // 참고URL: https://developers.naver.com/docs/login/api/api.md
//        apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
//        apiURL += "client_id=" + clientId;
//        apiURL += "&client_secret=" + clientSecret;
//        apiURL += "&redirect_uri=" + redirectURI;
//        apiURL += "&code=" + code;
//        apiURL += "&state=" + state;

        // 요청 URI
        String requestUri
                = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";

        // 요청헤더 설정
        HttpHeaders headers = new org.springframework.http.HttpHeaders();
        // key=value&key=value의 형태임
        headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

/*
        NaverLoginController.java 코드
        -------------------------------------------
        params.put("clientId", naverClientId);
        params.put("clientSecret", naverClientSecret);
        params.put("redirect", naverRedirectUri);
        params.put("code", code);
        params.put("state", state);
*/
        // 요청바디에 파라미터 세팅
        MultiValueMap<String, String > params = new LinkedMultiValueMap<>();
        System.out.println("[dbg] getAccessToken: requestParam = " + requestParam.get("clientId"));
        params.add("client_id", requestParam.get("clientId"));
        params.add("client_secret", requestParam.get("clientSecret"));
        params.add("redirect_uri", requestParam.get("redirect"));
        params.add("code", requestParam.get("code"));
        params.add("state", requestParam.get("state"));

        // 네이버 인증 서버로 Post 요청 보내기
        RestTemplate template = new RestTemplate();

        // 헤더 정보와 파라미터를 하나로 묶기
        HttpEntity<Object> requestEntity = new HttpEntity<>(params, headers);

        /*
        - RestTemplate객체가 REST API 통신을 위한 API인데 (자바스크립트 fetch역할)
                - 서버에 통신을 보내면서 응답을 받을 수 있는 메서드가 exchange
        param1: 요청 URL - requestUri
        param2: 요청 방식 (get, post, put, patch, delete...) - HttpMethod.POST
        param3: 요청 헤더와 요청 바디 정보 - HttpEntity로 포장해서 줘야 함 - requestEntity
        param4: 응답결과(JSON)를 어떤 타입으로 받아낼 것인지 (ex: DTO로 받을건지 Map으로 받을건지) - Map.class
         */

        ResponseEntity<Map> responseEntity
                = template.exchange(requestUri, HttpMethod.POST, requestEntity, Map.class);

        // 응답 데이터에서 JSON 추출
        Map<String, Object> responseJson = responseEntity.getBody();
        System.out.println("[dbg] reponseJson = " + responseJson);
        System.out.println("======================================");

        String naverAccessToken = (String) responseJson.get("access_token");

        return naverAccessToken;
    }
}
