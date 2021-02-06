package com.movie.core.convert;

import com.movie.core.dto.CommentLikeDTO;
import com.movie.core.entity.CommentLikeEntity;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class CommentLikeConvert {
    @Autowired
    private CommentConvert commentConvert;
    @Autowired
    private UserConvert userConvert;

    public CommentLikeDTO toDTO(CommentLikeEntity entity) {
        CommentLikeDTO dto = new CommentLikeDTO();
        BeanUtils.copyProperties(entity, dto);
        if (entity.getComment() != null) {
            dto.setComment(commentConvert.toDTO(entity.getComment()));
        }
        if (entity.getUser() != null) {
            dto.setUser(userConvert.toDTO(entity.getUser()));
        }
        return dto;
    }


    public CommentLikeEntity toEntity(CommentLikeDTO dto) {
        CommentLikeEntity entity = new CommentLikeEntity();
        BeanUtils.copyProperties(dto, entity);
        if (dto.getComment() != null) {
            entity.setComment(commentConvert.toEntity(dto.getComment()));
        }
        if (dto.getUser() != null) {
            entity.setUser(userConvert.toEntity(dto.getUser()));
        }
        return entity;
    }
}
