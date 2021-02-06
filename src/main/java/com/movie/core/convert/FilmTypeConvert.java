package com.movie.core.convert;

import com.movie.core.dto.FilmTypeDTO;
import com.movie.core.entity.FilmTypeEntity;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
public class FilmTypeConvert {
    public FilmTypeDTO toDTO(FilmTypeEntity entity) {
        FilmTypeDTO dto = new FilmTypeDTO();
        BeanUtils.copyProperties(entity, dto,"films");
        return dto;
    }

    public FilmTypeEntity toEntity(FilmTypeDTO dto) {
        FilmTypeEntity entity = new FilmTypeEntity();
        BeanUtils.copyProperties(dto, entity,"films");
        return entity;
    }
}
