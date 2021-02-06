package com.movie.core.repository;

import com.movie.core.entity.DirectorEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface DirectorRepository extends JpaRepository<DirectorEntity, Long> {
    @Query("select d from DirectorEntity d where (lower(d.name) like %?1% or lower(d.code) like %?2%)")
    List<DirectorEntity> findAllByNameOrCode(String name, String code, Pageable pageable);

    @Query("select count(d.id) from DirectorEntity d where (lower(d.name) like %?1% or lower(d.code) like %?2%)")
    long countAllByNameOrCode(String name, String code);
}
