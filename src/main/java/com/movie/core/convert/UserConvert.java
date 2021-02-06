package com.movie.core.convert;

import com.movie.core.dto.UserDTO;
import com.movie.core.entity.UserEntity;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
public class UserConvert {
    public UserDTO toDTO(UserEntity entity) {
        UserDTO dto = new UserDTO();
        BeanUtils.copyProperties(entity, dto);
        return dto;
    }

    public UserEntity toEntity(UserDTO dto) {
        UserEntity entity = new UserEntity();
        BeanUtils.copyProperties(dto,entity);
        return entity;
    }

    public UserEntity toEntity(UserDTO userDTO, UserEntity userEntity) {
        BeanUtils.copyProperties(userDTO, userEntity,"photo","password");
        return userEntity;
    }
}
