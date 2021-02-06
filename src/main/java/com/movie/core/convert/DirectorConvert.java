package com.movie.core.convert;

import com.movie.core.dto.DirectorDTO;
import com.movie.core.entity.DirectorEntity;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
public class DirectorConvert {
    public DirectorDTO toDTO(DirectorEntity entity) {
        DirectorDTO dto = new DirectorDTO();
        BeanUtils.copyProperties(entity, dto,"films");
        return dto;
    }


    public DirectorEntity toEntity(DirectorDTO dto) {
        DirectorEntity entity = new DirectorEntity();
        BeanUtils.copyProperties(dto, entity,"films");
        return entity;
    }
}
