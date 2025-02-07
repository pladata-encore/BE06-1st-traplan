package com.project.traplaner.member.dto;

import com.project.traplaner.entity.Member;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
@ToString
@Builder
public class NaverSignUpRequestDto {

    @NotBlank
    @Size(min=4)
    private String nickName;

    @NotBlank
    @Size(min=10)
    private String password;

    @NotBlank
    @Email
    private String email;

    private Member.LoginMethod loginMethod;

    // 프로필 사진 파일
    private MultipartFile profileImg;

    public Member toEntity(PasswordEncoder encoder, String savePath) {
        return Member.builder()
                .nickName(nickName)
                .password(encoder.encode(password))
                .email(email)
                .profileImg(savePath)
                .loginMethod(loginMethod)
                .build();
    }

}
