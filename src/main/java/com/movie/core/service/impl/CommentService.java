package com.movie.core.service.impl;

import com.movie.core.dto.CommentDTO;
import com.movie.core.entity.CommentEntity;
import com.movie.core.repository.CommentRepository;
import com.movie.core.service.ICommentService;
import com.movie.core.convert.CommentConvert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class CommentService implements ICommentService {
    @Autowired
    private CommentRepository commentRepository;
    @Autowired
    private CommentConvert commentConvert;

    public List<CommentDTO> findByProperties(Long filmId, int page, int limit, String sortExpression, String sortDirection) {
        Sort sort = null;
        if (sortExpression != null && sortDirection != null) {
            sort = new Sort(sortDirection.equals("1") ? Sort.Direction.ASC : Sort.Direction.DESC, sortExpression);
        }
        Pageable pageable = new PageRequest(page - 1, limit, sort);
        List<CommentEntity> commentEntities = commentRepository.findAllByFilm_IdAndCommentIsNull(filmId, pageable);
        List<CommentDTO> commentDTOS = new ArrayList<CommentDTO>();
        for (CommentEntity entity : commentEntities) {
            CommentDTO commentDTO = commentConvert.toDTO(entity);
            commentDTO.setSubCommentCount(entity.getComments().size());
            commentDTOS.add(commentDTO);
        }
        return commentDTOS;
    }

    public List<CommentDTO> findByProperties(Long commentId, Long filmId, int page, int limit, String sortExpression, String sortDirection) {
        Sort sort = null;
        if (sortExpression != null && sortDirection != null) {
            sort = new Sort(sortDirection.equals("1") ? Sort.Direction.ASC : Sort.Direction.DESC, sortExpression);
        }
        Pageable pageable = new PageRequest(page - 1, limit, sort);
        List<CommentEntity> commentEntities = commentRepository.findAllByComment_IdAndFilm_Id(commentId, filmId, pageable);
        List<CommentDTO> commentDTOS = new ArrayList<CommentDTO>();
        for (CommentEntity entity : commentEntities) {
            CommentDTO commentDTO = commentConvert.toDTO(entity);
            commentDTOS.add(commentDTO);
        }
        return commentDTOS;
    }

    @Transactional
    public void save(CommentDTO commentDTO) {
        CommentEntity entity;
        if (commentDTO.getId() != null) {
            entity = commentRepository.findOne(commentDTO.getId());
            entity.setContent(commentDTO.getContent());
        } else {
            entity = commentConvert.toEntity(commentDTO);
        }
        commentRepository.save(entity);
    }

    public int totalComment(Long filmId) {
        int result = (int) commentRepository.countAllByFilm_Id(filmId);
        return result;
    }

    public int totalComment(Long commentId, Long filmId) {
        int result = (int) commentRepository.countAllByFilm_IdAndComment_Id(commentId, filmId);
        return result;
    }

    @Transactional
    public void deleteComment(Long[] ids) {
        for (Long id : ids) {
            commentRepository.delete(id);
        }
    }
}
