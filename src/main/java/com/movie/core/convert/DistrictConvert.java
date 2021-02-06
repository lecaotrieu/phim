package com.movie.core.convert;

import com.movie.core.dto.DistrictDTO;
import com.movie.core.entity.DistrictEntity;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class DistrictConvert {
    @Autowired
    private CountryConvert countryConvert;
    @Autowired
    private CityConvert cityConvert;
    public DistrictDTO toDTO(DistrictEntity entity) {
        DistrictDTO dto = new DistrictDTO();
        BeanUtils.copyProperties(entity, dto);
        if (entity.getCity() != null) {
            dto.setCity(cityConvert.toDTO(entity.getCity()));
        }
        if (entity.getCountry() != null) {
            dto.setCountry(countryConvert.toDTO(entity.getCountry()));
        }
        return dto;
    }


    public DistrictEntity toEntity(DistrictDTO dto) {
        DistrictEntity entity = new DistrictEntity();
        BeanUtils.copyProperties(dto,entity);
        if (dto.getCity() != null) {
            entity.setCity(cityConvert.toEntity(dto.getCity()));
        }
        if (dto.getCountry() != null) {
            entity.setCountry(countryConvert.toEntity(dto.getCountry()));
        }
        return entity;
    }
}
