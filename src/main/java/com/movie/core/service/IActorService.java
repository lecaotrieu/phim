package com.movie.core.service;

import com.movie.core.dto.ActorDTO;

import java.io.IOException;
import java.util.List;

public interface IActorService {
    List<ActorDTO> findAll();

    ActorDTO save(ActorDTO actorDTO) throws IOException;

    ActorDTO findOneById(Long id);

    List<ActorDTO> findByProperties(String search, int page, int limit, String sortExpression, String sortDirection);

    int getTotalItem(String search);

    void delete(Long[] ids);
}
