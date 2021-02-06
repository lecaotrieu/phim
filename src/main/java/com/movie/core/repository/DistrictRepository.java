package com.movie.core.repository;

import com.movie.core.entity.DistrictEntity;
import com.movie.core.entity.EmployeeEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DistrictRepository extends JpaRepository<DistrictEntity, Long> {
    List<DistrictEntity> findDistrictEntitiesByCity_Id(Long id);
    DistrictEntity findOneByEmployees(List<EmployeeEntity> employees);
    DistrictEntity findOneByCode(String code);
}
