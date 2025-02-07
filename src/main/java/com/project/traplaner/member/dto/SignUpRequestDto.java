package com.project.traplaner.member.dto;

import com.project.traplaner.entity.Member;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
@ToString
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SignUpRequestDto {

    @NotBlank
    @Email
    private String email;

    @NotBlank
    private String password;

    @NotBlank
    @Size(min = 2, max = 6)
    private String nickName;

    private MultipartFile profileImage;

    private Member.LoginMethod loginMethod;


    public Member toEntity(PasswordEncoder encoder, String savePath) {
        return Member.builder()
                .email(email)
                .password(encoder.encode(password))
                .nickName(nickName)
                .loginMethod(loginMethod)
                .profileImg(savePath)
                .build();
    }
}

