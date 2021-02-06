package com.movie.core.service;

import com.movie.core.dto.CategoryDTO;

import java.io.IOException;
import java.util.List;

public interface ICategoryService {
    List<CategoryDTO> findAll();

    List<CategoryDTO> findByProperties(String search, int page, int limit, String sortExpression, String sortDirection);

    int getTotalItem(String search);

    CategoryDTO findOneById(Long id);

    CategoryDTO save(CategoryDTO categoryDTO) throws IOException;

    void delete(Long[] ids);
}
