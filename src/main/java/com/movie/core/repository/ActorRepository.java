package com.movie.core.repository;

import com.movie.core.entity.ActorEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ActorRepository extends JpaRepository<ActorEntity, Long> {
    @Query("select a from ActorEntity a where (lower(a.name) like %?1% or lower(a.code) like %?2%)")
    List<ActorEntity> findAllByNameOrCode(String name, String code, Pageable pageable);

    @Query("select count(a.id) from ActorEntity a where (lower(a.name) like %?1% or lower(a.code) like %?2%)")
    long countAllByNameOrCode(String name, String code);
}
