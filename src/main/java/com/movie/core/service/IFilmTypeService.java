package com.movie.core.service;

import com.movie.core.dto.FilmTypeDTO;

import java.io.IOException;
import java.util.List;

public interface IFilmTypeService {
    List<FilmTypeDTO> findAll();

    FilmTypeDTO findOneById(Long id);

    List<FilmTypeDTO> findByProperties(String search, int page, int limit, String sortExpression, String sortDirection);

    int getTotalItem(String search);

    FilmTypeDTO save(FilmTypeDTO filmTypeDTO) throws IOException;

    void delete(Long[] ids);
}
