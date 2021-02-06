package com.movie.core.convert;

import com.movie.core.dto.RoleDTO;
import com.movie.core.entity.RoleEntity;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
public class RoleConvert {
    public RoleDTO toDTO(RoleEntity entity) {
        RoleDTO dto = new RoleDTO();
        BeanUtils.copyProperties(entity, dto);
        return dto;
    }

    public RoleEntity toEntity(RoleDTO dto) {
        RoleEntity entity = new RoleEntity();
        BeanUtils.copyProperties(dto,entity);
        return entity;
    }
}
