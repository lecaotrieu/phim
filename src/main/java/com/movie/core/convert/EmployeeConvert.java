package com.movie.core.convert;

import com.movie.core.dto.*;
import com.movie.core.entity.EmployeeEntity;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class EmployeeConvert {
    @Autowired
    private CommuneConvert communeConvert;
    @Autowired
    private CityConvert cityConvert;
    @Autowired
    private CountryConvert countryConvert;
    @Autowired
    private DistrictConvert districtConvert;

    public EmployeeDTO toDTO(EmployeeEntity entity) {
        EmployeeDTO dto = new EmployeeDTO();
        BeanUtils.copyProperties(entity, dto);
        if (entity.getCommune() != null && entity.getCommune().getId() != null) {
            dto.setCommune(communeConvert.toDTO(entity.getCommune()));
        }
        if (entity.getCountry() != null && entity.getCountry().getId() != null) {
            dto.setCountry(countryConvert.toDTO(entity.getCountry()));
        }
        if (entity.getCity() != null && entity.getCity().getId() != null) {
            dto.setCity(cityConvert.toDTO(entity.getCity()));
        }
        if (entity.getDistrict() != null && entity.getDistrict().getId() != null) {
            dto.setDistrict(districtConvert.toDTO(entity.getDistrict()));
        }
        return dto;
    }

    public EmployeeEntity toEntity(EmployeeDTO dto) {
        EmployeeEntity entity = new EmployeeEntity();
        BeanUtils.copyProperties(dto, entity);
        if (dto.getCommune() != null && dto.getCommune().getId() != null) {
            entity.setCommune(communeConvert.toEntity(dto.getCommune()));
        }
        if (dto.getCountry() != null && dto.getCountry().getId() != null) {
            entity.setCountry(countryConvert.toEntity(dto.getCountry()));
        }
        if (dto.getCity() != null && dto.getCity().getId() != null) {
            entity.setCity(cityConvert.toEntity(dto.getCity()));
        }
        if (dto.getDistrict() != null && dto.getDistrict().getId() != null) {
            entity.setDistrict(districtConvert.toEntity(dto.getDistrict()));
        }
        return entity;
    }

    public EmployeeEntity toEntity(EmployeeDTO dto, EmployeeEntity entity) {
        BeanUtils.copyProperties(dto, entity, "password");
        if (dto.getCommune() != null && dto.getCommune().getId() != null) {
            entity.setCommune(communeConvert.toEntity(dto.getCommune()));
        }
        if (dto.getCountry() != null && dto.getCountry().getId() != null) {
            entity.setCountry(countryConvert.toEntity(dto.getCountry()));
        }
        if (dto.getCity() != null && dto.getCity().getId() != null) {
            entity.setCity(cityConvert.toEntity(dto.getCity()));
        }
        if (dto.getDistrict() != null && dto.getDistrict().getId() != null) {
            entity.setDistrict(districtConvert.toEntity(dto.getDistrict()));
        }
        return entity;
    }
}
