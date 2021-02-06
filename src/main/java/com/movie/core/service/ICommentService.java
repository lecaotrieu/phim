package com.movie.core.service;

import com.movie.core.dto.CommentDTO;

import java.util.List;

public interface ICommentService {
    List<CommentDTO> findByProperties(Long filmId, int page, int limit, String sortExpression, String sortDirection);

    List<CommentDTO> findByProperties(Long commentId, Long filmId, int page, int limit, String sortExpression, String sortDirection);

    void save(CommentDTO commentDTO);

    int totalComment(Long filmId);

    int totalComment(Long commentId, Long filmId);

    void deleteComment(Long[] ids);
}
