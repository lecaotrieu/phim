package com.movie.core.repository;

import com.movie.core.entity.FilmTypeEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface FilmTypeRepository extends JpaRepository<FilmTypeEntity, Long> {
    @Query("select ft from FilmTypeEntity ft where (lower(ft.name) like %?1% or lower(ft.code) like %?2%)")
    List<FilmTypeEntity> findAllByNameOrCode(String search, String search1, Pageable pageable);

    @Query("select count(ft.id) from FilmTypeEntity ft where (lower(ft.name) like %?1% or lower(ft.code) like %?2%)")
    long countAllByNameOrCode(String name, String code);
}
