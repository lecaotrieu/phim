package com.movie.core.repository;

import com.movie.core.entity.CountryEntity;
import com.movie.core.entity.EmployeeEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CountryRepository extends JpaRepository<CountryEntity, Long> {
    CountryEntity findOneByCode(String code);
    CountryEntity findOneByEmployees(List<EmployeeEntity> employees);
}
