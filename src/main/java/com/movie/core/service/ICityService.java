package com.movie.core.service;

import com.movie.core.dto.CityDTO;

import java.util.List;

public interface ICityService {
    List<CityDTO> findByCountry(Long id);
    CityDTO findCityById(Long id);
}
