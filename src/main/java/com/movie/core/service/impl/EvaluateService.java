package com.movie.core.service.impl;

import com.movie.core.constant.CoreConstant;
import com.movie.core.convert.EvaluateConvert;
import com.movie.core.dto.EvaluateDTO;
import com.movie.core.entity.EvaluateEntity;
import com.movie.core.repository.EpisodeRepository;
import com.movie.core.repository.EvaluateRepository;
import com.movie.core.service.IEvaluateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class EvaluateService implements IEvaluateService {
    @Autowired
    private EvaluateRepository evaluateRepository;
    @Autowired
    private EvaluateConvert evaluateConvert;
    @Autowired
    private EpisodeRepository episodeRepository;

    public List<EvaluateDTO> findAllByUserId(Long id, Integer status) throws Exception {
        List<EvaluateDTO> evaluateDTOS = new ArrayList<EvaluateDTO>();
        List<EvaluateEntity> evaluateEntities = evaluateRepository.findAllByUser_IdAndStatus(id, status);
        for (EvaluateEntity evaluateEntity : evaluateEntities) {
            EvaluateDTO evaluateDTO = evaluateConvert.toDTO(evaluateEntity);
            evaluateDTO.getFilm().setEpisodesCount(episodeRepository.countAllByFilm_IdAndStatus(evaluateDTO.getFilm().getId(), CoreConstant.ACTIVE_STATUS));
            evaluateDTOS.add(evaluateDTO);
        }
        return evaluateDTOS;
    }

    public EvaluateDTO findOneByUserAndFilm(Long filmId, Long userId) {
        EvaluateEntity evaluateEntity = evaluateRepository.findAllByFilm_IdAndUser_IdAndStatus(filmId, userId, CoreConstant.ACTIVE_STATUS);
        if (evaluateEntity != null) {
            return evaluateConvert.toDTO(evaluateEntity);
        }
        return null;
    }

    @Transactional
    public Long save(EvaluateDTO evaluateDTO) {
        EvaluateEntity entity;
        if (evaluateDTO.getId() != null) {
            entity = evaluateRepository.findOne(evaluateDTO.getId());
            entity = evaluateConvert.toEntity(entity, evaluateDTO);
        } else {
            entity = evaluateConvert.toEntity(evaluateDTO);
            entity.setWatched(0);
            entity.setFollow(0);
        }
        entity = evaluateRepository.save(entity);
        return entity.getId();
    }

    public Long updateFollow(EvaluateDTO evaluateDTO) {
        EvaluateEntity entity;
        entity = evaluateRepository.findAllByFilm_IdAndUser_IdAndStatus(evaluateDTO.getFilm().getId(), evaluateDTO.getUser().getId(), CoreConstant.ACTIVE_STATUS);
        entity.setFollow(evaluateDTO.getFollow());
        entity = evaluateRepository.save(entity);
        return entity.getId();
    }

}
