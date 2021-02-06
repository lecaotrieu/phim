package com.movie.core.service.impl;

import com.movie.core.dto.CountryDTO;
import com.movie.core.entity.CountryEntity;
import com.movie.core.repository.CountryRepository;
import com.movie.core.service.ICountryService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CountryService implements ICountryService {
    @Autowired
    private CountryRepository countryRepository;

    public List<CountryDTO> findAll() {
        List<CountryEntity> countryEntities = countryRepository.findAll();
        List<CountryDTO> countryDTOS = new ArrayList<CountryDTO>();
        for (CountryEntity entity : countryEntities) {
            CountryDTO countryDTO = new CountryDTO();
            BeanUtils.copyProperties(entity, countryDTO);
            countryDTOS.add(countryDTO);
        }
        return countryDTOS;
    }
}
