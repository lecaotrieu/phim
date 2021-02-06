package com.movie.core.repository;

import com.movie.core.entity.EpisodeEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EpisodeRepository extends JpaRepository<EpisodeEntity, Long> {
    int countAllByFilm_Id(Long id);

    int countAllByFilm_IdAndStatus(Long id, Integer status);

    List<EpisodeEntity> findByFilm_IdAndStatus(Long id, Integer status, Pageable pageable);

    EpisodeEntity findByFilm_CodeAndEpisodeCode(String filmCode, Integer code);

    EpisodeEntity findByIdAndStatus(Long id, Integer status);

    List<EpisodeEntity> findAllByStatusAndFilm_Id(Integer status, Long filmId);

    List<EpisodeEntity> findAllByFilm_Id(Long filmId);

    Integer countByFilm_Employee_UserNameAndId(String username, Long id);
}
