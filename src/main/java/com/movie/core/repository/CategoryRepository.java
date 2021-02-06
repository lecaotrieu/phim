package com.movie.core.repository;

import com.movie.core.entity.CategoryEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CategoryRepository extends JpaRepository<CategoryEntity, Long> {
    @Query("select c from CategoryEntity c where (lower(c.name) like %?1% or lower(c.code) like %?2%)")
    List<CategoryEntity> findAllByNameOrCode(String name, String code, Pageable pageable);

    @Query("select count(c.id) from CategoryEntity c where (lower(c.name) like %?1% or lower(c.code) like %?2%)")
    long countAllByNameOrCode(String name, String code);
}
