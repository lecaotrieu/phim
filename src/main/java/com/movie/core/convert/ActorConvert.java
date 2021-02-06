package com.movie.core.convert;

import com.movie.core.dto.ActorDTO;
import com.movie.core.entity.ActorEntity;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
public class ActorConvert {
    public ActorDTO toDTO(ActorEntity entity) {
        ActorDTO dto = new ActorDTO();
        BeanUtils.copyProperties(entity, dto,"films");
        return dto;
    }


    public ActorEntity toEntity(ActorDTO dto) {
        ActorEntity entity = new ActorEntity();
        BeanUtils.copyProperties(dto, entity,"films");
        return entity;
    }
}
