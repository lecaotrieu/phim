package com.movie.core.repository;

import com.movie.core.entity.CityEntity;
import com.movie.core.entity.EmployeeEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CityRepository extends JpaRepository<CityEntity, Long> {
    List<CityEntity> findCityEntitiesByCountry_Id(Long id);
    CityEntity findOneByEmployees(List<EmployeeEntity> employees);
    CityEntity findOneByCode(String code);
}
