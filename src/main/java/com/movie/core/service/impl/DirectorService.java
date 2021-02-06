package com.movie.core.service.impl;

import com.movie.core.dto.DirectorDTO;
import com.movie.core.entity.DirectorEntity;
import com.movie.core.repository.DirectorRepository;
import com.movie.core.service.IDirectorService;
import com.movie.core.service.utils.StringGlobalUtils;
import com.movie.core.convert.DirectorConvert;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service
public class DirectorService implements IDirectorService {
    @Autowired
    private DirectorRepository directorRepository;

    public List<DirectorDTO> findAll() {
        List<DirectorDTO> results = new ArrayList<DirectorDTO>();
        for (DirectorEntity directorEntity : directorRepository.findAll()) {
            DirectorDTO directorDTO = new DirectorDTO();
            BeanUtils.copyProperties(directorEntity, directorDTO, "films");
            results.add(directorDTO);
        }
        return results;
    }

    @Autowired
    private DirectorConvert directorConvert;

    @Autowired
    private StringGlobalUtils stringGlobalUtils;

    @Transactional
    public DirectorDTO save(DirectorDTO directorDTO) throws IOException {
        DirectorEntity entity;
        if (directorDTO.getId()!=null){
            entity = directorRepository.findOne(directorDTO.getId());
            entity.setCode(directorDTO.getCode());
            entity.setName(directorDTO.getName());
            entity.setDescription(directorDTO.getDescription());
        } else{
            entity = directorConvert.toEntity(directorDTO);
        }
        if (entity.getCode() == null) {
            entity.setCode(stringGlobalUtils.covertToString(entity.getName()));
        }
        entity = directorRepository.save(entity);
        return directorConvert.toDTO(entity);
    }

    public DirectorDTO findOneById(Long id) {
        return directorConvert.toDTO(directorRepository.findOne(id));
    }

    public List<DirectorDTO> findByProperties(String search, int page, int limit, String sortExpression, String sortDirection) {
        Sort sort = null;
        search = search.toLowerCase();
        if (sortExpression != null && sortDirection != null) {
            sort = new Sort(sortDirection.equals("1") ? Sort.Direction.ASC : Sort.Direction.DESC, sortExpression);
        }
        Pageable pageable = new PageRequest(page - 1, limit, sort);
        List<DirectorDTO> directorDTOS = new ArrayList<DirectorDTO>();
        List<DirectorEntity> directorEntities = directorRepository.findAllByNameOrCode(search, search, pageable);
        for (DirectorEntity entity : directorEntities) {
            DirectorDTO directorDTO = directorConvert.toDTO(entity);
            directorDTOS.add(directorDTO);
        }
        return directorDTOS;
    }

    public int getTotalItem(String search) {
        return (int) directorRepository.countAllByNameOrCode(search, search);
    }

    public void delete(Long[] ids) {
        for (Long id : ids) {
            DirectorEntity directorEntity = directorRepository.findOne(id);
            directorEntity.setFilms(null);
            directorRepository.save(directorEntity);
            directorRepository.delete(id);
        }
    }
}
