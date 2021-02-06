package com.movie.core.convert;

import com.movie.core.dto.CommuneDTO;
import com.movie.core.entity.CommuneEntity;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class CommuneConvert {
    @Autowired
    private CityConvert cityConvert;
    @Autowired
    private CountryConvert countryConvert;
    @Autowired
    private DistrictConvert districtConvert;

    public CommuneDTO toDTO(CommuneEntity entity) {
        CommuneDTO dto = new CommuneDTO();
        BeanUtils.copyProperties(entity, dto);
        if (entity.getCity() != null) {
            dto.setCity(cityConvert.toDTO(entity.getCity()));
        }
        if (entity.getCountry() != null) {
            dto.setCountry(countryConvert.toDTO(entity.getCountry()));
        }
        if (entity.getDistrict() != null) {
            dto.setDistrict(districtConvert.toDTO(entity.getDistrict()));
        }
        return dto;
    }

    public CommuneEntity toEntity(CommuneDTO dto) {
        CommuneEntity entity = new CommuneEntity();
        BeanUtils.copyProperties(dto, entity);
        if (dto.getCity() != null) {
            entity.setCity(cityConvert.toEntity(dto.getCity()));
        }
        if (dto.getCountry() != null) {
            entity.setCountry(countryConvert.toEntity(dto.getCountry()));
        }
        if (dto.getDistrict() != null) {
            entity.setDistrict(districtConvert.toEntity(dto.getDistrict()));
        }
        return entity;
    }
}
