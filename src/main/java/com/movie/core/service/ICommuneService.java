package com.movie.core.service;

import com.movie.core.dto.CommuneDTO;

import java.util.List;

public interface ICommuneService {
    List<CommuneDTO> findByDistrict(Long id);
}
