package com.movie.core.repository;

import com.movie.core.entity.CommuneEntity;
import com.movie.core.entity.EmployeeEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CommuneRepository extends JpaRepository<CommuneEntity, Long> {
    List<CommuneEntity> findCommuneEntitiesByDistrict_Id(Long id);
    CommuneEntity findOneByCode(String code);
    CommuneEntity findOneByEmployees(List<EmployeeEntity> employees);
}
