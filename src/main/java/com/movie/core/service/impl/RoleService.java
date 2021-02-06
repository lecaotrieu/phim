package com.movie.core.service.impl;

import com.movie.core.convert.RoleConvert;
import com.movie.core.dto.RoleDTO;
import com.movie.core.entity.RoleEntity;
import com.movie.core.repository.RoleRepository;
import com.movie.core.service.IRoleService;
import com.movie.core.service.utils.StringGlobalUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class RoleService implements IRoleService {
    @Autowired
    private RoleRepository roleRepository;

    public List<RoleDTO> findAll() {
        List<RoleEntity> roleEntities = roleRepository.findAll();
        List<RoleDTO> roleDTOS = new ArrayList<RoleDTO>();
        for (RoleEntity roleEntity : roleEntities) {
            RoleDTO roleDTO = new RoleDTO();
            BeanUtils.copyProperties(roleEntity, roleDTO);
            roleDTOS.add(roleDTO);
        }
        return roleDTOS;
    }

    @Override
    public List<RoleDTO> findAllNotAdmin() {
        List<RoleEntity> roleEntities = roleRepository.findAllByCodeNotContaining("ADMIN");
        List<RoleDTO> roleDTOS = new ArrayList<RoleDTO>();
        for (RoleEntity roleEntity : roleEntities) {
            RoleDTO roleDTO = new RoleDTO();
            BeanUtils.copyProperties(roleEntity, roleDTO);
            roleDTOS.add(roleDTO);
        }
        return roleDTOS;
    }

    @Autowired
    private RoleConvert roleConvert;

    @Override
    public RoleDTO findOneById(Long id) throws Exception {
        return roleConvert.toDTO(roleRepository.findOne(id));
    }

    @Override
    public List<RoleDTO> findByProperties(String search, int page, int limit, String sortExpression, String sortDirection) throws Exception {
        Sort sort = null;
        search = search.toLowerCase();
        if (sortExpression != null && sortDirection != null) {
            sort = new Sort(sortDirection.equals("1") ? Sort.Direction.ASC : Sort.Direction.DESC, sortExpression);
        }
        Pageable pageable = new PageRequest(page - 1, limit, sort);
        List<RoleDTO> roleDTOS = new ArrayList<RoleDTO>();
        List<RoleEntity> roleEntities = roleRepository.findAllByNameOrCode(search, search, pageable);
        for (RoleEntity entity : roleEntities) {
            RoleDTO roleDTO = roleConvert.toDTO(entity);
            roleDTOS.add(roleDTO);
        }
        return roleDTOS;
    }

    @Override
    public int getTotalItem(String search) throws Exception {
        return (int) roleRepository.countAllByNameOrCode(search, search);
    }

    @Autowired
    private StringGlobalUtils stringGlobalUtils;

    @Transactional
    @Override
    public Long save(RoleDTO roleDTO) throws Exception {
        RoleEntity entity;
        if (roleDTO.getId() != null) {
            entity = roleRepository.findOne(roleDTO.getId());
            entity.setCode(roleDTO.getCode());
            entity.setName(roleDTO.getName());
        } else {
            entity = roleConvert.toEntity(roleDTO);
        }
        if (entity.getCode() == null) {
            entity.setCode(stringGlobalUtils.covertToString(entity.getName()));
        }
        entity = roleRepository.save(entity);
        return roleConvert.toDTO(entity).getId();
    }

    @Transactional
    @Override
    public void delete(Long[] ids) throws Exception {
        for (Long id : ids) {
            RoleEntity roleEntity = roleRepository.findOne(id);
            roleEntity.setEmployees(null);
            roleRepository.save(roleEntity);
            roleRepository.delete(id);
        }
    }
}
