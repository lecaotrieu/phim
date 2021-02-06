package com.movie.core.service;

import com.movie.core.dto.CountryDTO;

import java.util.List;

public interface ICountryService {
    List<CountryDTO> findAll();
}
