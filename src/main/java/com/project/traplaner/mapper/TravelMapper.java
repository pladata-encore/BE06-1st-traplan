package com.project.traplaner.mapper;

import com.project.traplaner.entity.Journey;
import com.project.traplaner.entity.Travel;
import com.project.traplaner.travelplan.dto.TableStatusDto;
import com.project.traplaner.entity.TravelBoard;
import com.project.traplaner.main.dto.MainTravelDto;
import com.project.traplaner.main.dto.TopThreeFavoriteTravelDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TravelMapper {

    void saveTravel(Travel travel);
    void save(Travel travel);

    Travel fineOne(int memberId);

    void postJourney(Journey journey);
    List<Travel> findAll(int memberId);

    List<TopThreeFavoriteTravelDto> findTopThree();

    void updateJourney(Journey journey);
    List<MainTravelDto> findByEmail(String email);

    int getNextTravelId();
}
