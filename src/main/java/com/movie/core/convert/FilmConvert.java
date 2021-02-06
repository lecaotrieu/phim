package com.movie.core.convert;

import com.movie.core.dto.FilmDTO;
import com.movie.core.entity.FilmEntity;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class FilmConvert {
    @Autowired
    private CountryConvert countryConvert;
    @Autowired
    private FilmTypeConvert filmTypeConvert;
    @Autowired
    private EmployeeConvert employeeConvert;
    @Autowired
    private DirectorConvert directorConvert;

    public FilmDTO toDTO(FilmEntity entity) {
        FilmDTO dto = new FilmDTO();
        BeanUtils.copyProperties(entity, dto);
        if (entity.getCountry() != null) {
            dto.setCountry(countryConvert.toDTO(entity.getCountry()));
        }
        if (entity.getEmployee() != null) {
            dto.setEmployee(employeeConvert.toDTO(entity.getEmployee()));
        }
        if (entity.getFilmType() != null) {
            dto.setFilmType(filmTypeConvert.toDTO(entity.getFilmType()));
        }
        if (entity.getDirector() != null) {
            dto.setDirector(directorConvert.toDTO(entity.getDirector()));
        }
        return dto;
    }

    public FilmEntity toEntity(FilmDTO dto) {
        FilmEntity entity = new FilmEntity();
        BeanUtils.copyProperties(dto, entity);
        if (dto.getCountry() != null) {
            entity.setCountry(countryConvert.toEntity(dto.getCountry()));
        }
        if (dto.getEmployee() != null) {
            entity.setEmployee(employeeConvert.toEntity(dto.getEmployee()));
        }
        if (dto.getFilmType() != null) {
            entity.setFilmType(filmTypeConvert.toEntity(dto.getFilmType()));
        }
        if (dto.getDirector() != null) {
            entity.setDirector(directorConvert.toEntity(dto.getDirector()));
        }
        return entity;
    }

    public FilmEntity toEntity(FilmDTO dto,FilmEntity entity, String ignore) {
        BeanUtils.copyProperties(dto, entity, ignore);
        if (dto.getCountry() != null) {
            entity.setCountry(countryConvert.toEntity(dto.getCountry()));
        }
        if (dto.getEmployee() != null) {
            entity.setEmployee(employeeConvert.toEntity(dto.getEmployee()));
        }
        if (dto.getFilmType() != null) {
            entity.setFilmType(filmTypeConvert.toEntity(dto.getFilmType()));
        }
        if (dto.getDirector() != null) {
            entity.setDirector(directorConvert.toEntity(dto.getDirector()));
        }
        return entity;
    }
}
