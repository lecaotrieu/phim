package com.movie.core.service.impl;

import com.movie.core.dto.CommuneDTO;
import com.movie.core.entity.CommuneEntity;
import com.movie.core.repository.CommuneRepository;
import com.movie.core.service.ICommuneService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CommuneService implements ICommuneService {
    @Autowired
    private CommuneRepository communeRepository;

    public List<CommuneDTO> findByDistrict(Long id) {
        List<CommuneEntity> communeEntities = communeRepository.findCommuneEntitiesByDistrict_Id(id);
        List<CommuneDTO> communeDTOS = new ArrayList<CommuneDTO>();
        for (CommuneEntity entity : communeEntities) {
            CommuneDTO communeDTO = new CommuneDTO();
            BeanUtils.copyProperties(entity, communeDTO);
            communeDTOS.add(communeDTO);
        }
        return communeDTOS;
    }
}
