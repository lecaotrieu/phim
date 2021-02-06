package com.movie.core.repository;

import com.movie.core.entity.RoleEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RoleRepository extends JpaRepository<RoleEntity, Long> {
    RoleEntity findOneByCode(String code);

    List<RoleEntity> findAllByCodeIn(List<String> codes);

    List<RoleEntity> findAllByCodeNotContaining(String roleCode);


    @Query("select r from RoleEntity r where (lower(r.name) like %?1% or lower(r.code) like %?2%)")
    List<RoleEntity> findAllByNameOrCode(String name, String code, Pageable pageable);

    @Query("select count(r.id) from RoleEntity r where (lower(r.name) like %?1% or lower(r.code) like %?2%)")
    long countAllByNameOrCode(String name, String code);
}
