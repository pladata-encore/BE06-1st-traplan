package com.project.traplaner.member.dto;

import com.project.traplaner.main.dto.MainTravelDto;
import com.project.traplaner.main.dto.TopThreeFavoriteTravelDto;
import lombok.Builder;
import lombok.Getter;
import lombok.ToString;
import org.eclipse.jdt.internal.compiler.batch.Main;

import java.util.List;

@Getter @ToString @Builder
public class LoginUserResponseDTO {
    private int id;
    private String nickName;
    private String email;
    private String loginMethod;
    private String profile;

}