package com.movie.core.convert;

import com.movie.core.dto.EpisodeDTO;
import com.movie.core.entity.EpisodeEntity;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class EpisodeConvert {
    @Autowired
    private FilmConvert filmConvert;
    public EpisodeDTO toDTO(EpisodeEntity entity) {
        EpisodeDTO dto = new EpisodeDTO();
        BeanUtils.copyProperties(entity, dto);
        if (entity.getFilm() != null) {
            dto.setFilm(filmConvert.toDTO(entity.getFilm()));
        }
        return dto;
    }


    public EpisodeEntity toEntity(EpisodeDTO dto) {
        EpisodeEntity entity = new EpisodeEntity();
        BeanUtils.copyProperties(dto, entity);
        if (dto.getFilm() != null) {
            entity.setFilm(filmConvert.toEntity(dto.getFilm()));
        }
        return entity;
    }
}
