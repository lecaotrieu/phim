package com.movie.core.service;

import com.movie.core.dto.CommentLikeDTO;

public interface ICommentLikeService {
    CommentLikeDTO findByUserAndComment(Long userId, Long commentId);

    int totalCommentLike(Long commentId);

    void save(CommentLikeDTO dto);
}
