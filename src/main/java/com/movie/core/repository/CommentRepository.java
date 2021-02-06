package com.movie.core.repository;

import com.movie.core.entity.CommentEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CommentRepository extends JpaRepository<CommentEntity, Long> {
    List<CommentEntity> findAllByFilm_IdAndCommentIsNull(Long filmId, Pageable pageable);

    List<CommentEntity> findAllByComment_IdAndFilm_Id(Long commentId, Long filmId, Pageable pageable);

    long countAllByFilm_Id(Long id);

    long countAllByFilm_IdAndComment_Id(Long commentId, Long filmId);
}
