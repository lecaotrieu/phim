package com.movie.core.convert;

import com.movie.core.dto.CityDTO;
import com.movie.core.entity.CityEntity;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class CityConvert {
    @Autowired
    private CountryConvert countryConvert;

    public CityDTO toDTO(CityEntity entity) {
        CityDTO dto = new CityDTO();
        BeanUtils.copyProperties(entity, dto);
        if (entity.getCountry() != null) {
            dto.setCountry(countryConvert.toDTO(entity.getCountry()));
        }
        return dto;
    }


    public CityEntity toEntity(CityDTO dto) {
        CityEntity entity = new CityEntity();
        BeanUtils.copyProperties(dto, entity);
        if (dto.getCountry() != null) {
            entity.setCountry(countryConvert.toEntity(dto.getCountry()));
        }
        return entity;
    }
}
