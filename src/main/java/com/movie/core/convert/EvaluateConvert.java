package com.movie.core.convert;

import com.movie.core.dto.EvaluateDTO;
import com.movie.core.entity.EvaluateEntity;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class EvaluateConvert {
    @Autowired
    private FilmConvert filmConvert;
    @Autowired
    private UserConvert userConvert;

    public EvaluateDTO toDTO(EvaluateEntity entity) {
        EvaluateDTO dto = new EvaluateDTO();
        BeanUtils.copyProperties(entity, dto);
        if (entity.getFilm() != null) {
            dto.setFilm(filmConvert.toDTO(entity.getFilm()));
        }
        if (entity.getUser() != null) {
            dto.setUser(userConvert.toDTO(entity.getUser()));
        }
        return dto;
    }

    public EvaluateEntity toEntity(EvaluateDTO dto) {
        EvaluateEntity entity = new EvaluateEntity();
        BeanUtils.copyProperties(dto, entity);
        if (dto.getFilm() != null) {
            entity.setFilm(filmConvert.toEntity(dto.getFilm()));
        }
        if (dto.getUser() != null) {
            entity.setUser(userConvert.toEntity(dto.getUser()));
        }
        return entity;
    }

    public EvaluateEntity toEntity(EvaluateEntity entity, EvaluateDTO dto) {
        entity.setWatched(dto.getWatched());
        entity.setStatus(dto.getStatus());
        entity.setScores(dto.getScores());
        entity.setFollow(dto.getFollow());
        entity.setLiked(dto.getLiked());
        return entity;
    }
}
