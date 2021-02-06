package com.movie.core.service.impl;

import com.movie.core.dto.CityDTO;
import com.movie.core.entity.CityEntity;
import com.movie.core.repository.CityRepository;
import com.movie.core.service.ICityService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CityService implements ICityService {
    @Autowired
    private CityRepository cityRepository;

    public List<CityDTO> findByCountry(Long id) {
        List<CityEntity> cityEntities = cityRepository.findCityEntitiesByCountry_Id(id);
        List<CityDTO> cityDTOS = new ArrayList<CityDTO>();
        for (CityEntity cityEntity : cityEntities) {
            CityDTO cityDTO = new CityDTO();
            BeanUtils.copyProperties(cityEntity,cityDTO);
            cityDTOS.add(cityDTO);
        }
            return cityDTOS;
    }

    public CityDTO findCityById(Long id) {
        CityEntity cityEntity = cityRepository.findOneByCode("sssa");
        return null;
    }

}
