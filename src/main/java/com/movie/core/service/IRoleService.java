package com.movie.core.service;

import com.movie.core.dto.RoleDTO;

import java.util.List;

public interface IRoleService {
    List<RoleDTO> findAll();
    List<RoleDTO> findAllNotAdmin();

    RoleDTO findOneById(Long id) throws Exception;

    List<RoleDTO> findByProperties(String search, int page, int limit, String sortExpression, String sortDirection) throws Exception;

    int getTotalItem(String search) throws Exception;

    Long save(RoleDTO roleDTO) throws Exception;

    void delete(Long[] ids) throws Exception;
}
