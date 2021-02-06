package com.movie.core.service;

import com.movie.core.dto.EvaluateDTO;

import java.io.IOException;
import java.util.List;

public interface IEvaluateService {
    List<EvaluateDTO> findAllByUserId(Long id, Integer status) throws Exception;

    EvaluateDTO findOneByUserAndFilm(Long filmId, Long userId);

    Long save(EvaluateDTO evaluateDTO);

    Long updateFollow(EvaluateDTO evaluateDTO);
}
