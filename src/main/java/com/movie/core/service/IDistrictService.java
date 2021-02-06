package com.movie.core.service;

import com.movie.core.dto.DistrictDTO;

import java.util.List;

public interface IDistrictService {
    List<DistrictDTO> findByCity(Long id);
}
