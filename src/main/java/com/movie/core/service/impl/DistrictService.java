package com.movie.core.service.impl;

import com.movie.core.dto.DistrictDTO;
import com.movie.core.entity.DistrictEntity;
import com.movie.core.repository.DistrictRepository;
import com.movie.core.service.IDistrictService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class DistrictService implements IDistrictService {
    @Autowired
    private DistrictRepository districtRepository;

    public List<DistrictDTO> findByCity(Long id) {
        List<DistrictEntity> districtEntities = districtRepository.findDistrictEntitiesByCity_Id(id);
        List<DistrictDTO> districtDTOS = new ArrayList<DistrictDTO>();
        for (DistrictEntity entity : districtEntities) {
            DistrictDTO districtDTO = new DistrictDTO();
            BeanUtils.copyProperties(entity,districtDTO);
            districtDTOS.add(districtDTO);
        }
        return districtDTOS;
    }
}
