package com.project.traplaner.config;

import com.project.traplaner.interceptor.AfterLoginInterceptor;
import com.project.traplaner.interceptor.TravelBoardInterceptor;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

// 내가 만든 인터셉터들을 스프링 컨텍스트에 등록하는 설정 파일
@Configuration
@RequiredArgsConstructor
public class InterceptorConfig implements WebMvcConfigurer {

    private final AfterLoginInterceptor afterLoginInterceptor;
    private final TravelBoardInterceptor travelBoardInterceptor;
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry
                .addInterceptor(afterLoginInterceptor) // 어떤 인터셉터 등록?
                .addPathPatterns("/members/sign-in", "/members/sign-up"); // 언제 동작?
        registry
                .addInterceptor(travelBoardInterceptor)
                .addPathPatterns("/my-page/*","/travelplan");
    }
}


