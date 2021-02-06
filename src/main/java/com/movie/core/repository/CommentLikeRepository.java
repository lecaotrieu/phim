package com.movie.core.repository;

import com.movie.core.entity.CommentLikeEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CommentLikeRepository extends JpaRepository<CommentLikeEntity, Long> {
    CommentLikeEntity findByUser_IdAndComment_Id(Long userId, Long commentId);
    long countAllByComment_Id(Long commentId);
}
