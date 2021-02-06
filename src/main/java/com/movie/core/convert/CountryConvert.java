package com.movie.core.convert;

import com.movie.core.dto.CountryDTO;
import com.movie.core.entity.CountryEntity;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
public class CountryConvert {
    public CountryDTO toDTO(CountryEntity entity) {
        CountryDTO dto = new CountryDTO();
        BeanUtils.copyProperties(entity, dto);
        return dto;
    }


    public CountryEntity toEntity(CountryDTO dto) {
        CountryEntity entity = new CountryEntity();
        BeanUtils.copyProperties(dto, entity);
        return entity;
    }
}
