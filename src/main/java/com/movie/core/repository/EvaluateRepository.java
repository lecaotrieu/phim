package com.movie.core.repository;

import com.movie.core.entity.EvaluateEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EvaluateRepository extends JpaRepository<EvaluateEntity, Long> {
    List<EvaluateEntity> findAllByFilm_IdAndStatus(Long filmId, Integer status);

    List<EvaluateEntity> findAllByUser_IdAndStatus(Long userId, Integer status);

    EvaluateEntity findAllByFilm_IdAndUser_IdAndStatus(Long filmId, Long userId, Integer status);
}
