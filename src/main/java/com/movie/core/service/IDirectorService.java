package com.movie.core.service;

import com.movie.core.dto.DirectorDTO;

import java.io.IOException;
import java.util.List;

public interface IDirectorService {
    List<DirectorDTO> findAll();
    DirectorDTO save(DirectorDTO directorDTO) throws IOException;

    DirectorDTO findOneById(Long id);

    List<DirectorDTO> findByProperties(String search, int page, int limit, String sortExpression, String sortDirection);

    int getTotalItem(String search);

    void delete(Long[] ids);
}
