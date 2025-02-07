package com.project.traplaner.mapper;


import com.project.traplaner.entity.Favorite;
import com.project.traplaner.mypage.dto.response.FavoriteListResponseDTO;
import com.project.traplaner.travelBoard.dto.PageDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface FavoriteMapper {


    List<FavoriteListResponseDTO> favorite_List(@Param("memberId") int memberId, @Param("page") PageDTO page);

    // 10/28 by jhjeong
    void save(Favorite favorite);

    int getTotal(PageDTO page, int memberId);
}

