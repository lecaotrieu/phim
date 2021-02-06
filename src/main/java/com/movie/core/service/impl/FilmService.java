package com.movie.core.service.impl;

import com.google.api.services.drive.model.File;
import com.movie.core.constant.CoreConstant;
import com.movie.core.dto.ActorDTO;
import com.movie.core.dto.CategoryDTO;
import com.movie.core.dto.FilmDTO;
import com.movie.core.entity.*;
import com.movie.core.repository.EpisodeRepository;
import com.movie.core.repository.FilmRepository;
import com.movie.core.service.IDriveService;
import com.movie.core.service.IEpisodeService;
import com.movie.core.service.IFilmService;
import com.movie.core.service.utils.StringGlobalUtils;
import com.movie.core.convert.FilmConvert;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.lang.StringUtils;
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
public class FilmService implements IFilmService {
    @Autowired
    private FilmRepository filmRepository;
    @Autowired
    private EpisodeRepository episodeRepository;
    @Autowired
    private FilmConvert filmConvert;

    public List<FilmDTO> findByProperties(String search, String userName, int page, int limit, String sortExpression, String sortDirection) {
        Sort sort = null;
        search = search.toLowerCase();
        if (sortExpression != null && sortDirection != null) {
            sort = new Sort(sortDirection.equals("1") ? Sort.Direction.ASC : Sort.Direction.DESC, sortExpression);
        }
        Pageable pageable = new PageRequest(page - 1, limit, sort);
        List<FilmEntity> filmEntities;
        if (!userName.equals("ADMIN")) {
            filmEntities = filmRepository.findAllByEmployee_UserNameAndNameOrCodeAndStatus(userName, search, CoreConstant.ACTIVE_STATUS, pageable);
        } else {
            filmEntities = filmRepository.findAllByNameContainingOrCodeContaining(search, search, pageable);
        }
        List<FilmDTO> filmDTOS = new ArrayList<FilmDTO>();
        for (FilmEntity entity : filmEntities) {
            Integer countEpisode;
            if (!userName.equals("ADMIN")) {
                countEpisode = episodeRepository.countAllByFilm_IdAndStatus(entity.getId(), CoreConstant.ACTIVE_STATUS);
            } else {
                countEpisode = episodeRepository.countAllByFilm_Id(entity.getId());
            }
            FilmDTO filmDTO = filmConvert.toDTO(entity);
            filmDTO.setEpisodesCount(countEpisode);
            filmDTOS.add(filmDTO);

        }
        return filmDTOS;
    }

    public List<FilmDTO> findByProperties(String search, String filmType, String category, String country, String year, int page, int limit, String sortExpression, String sortDirection) {
        Sort sort = null;
        search = search.toLowerCase();
        if (sortExpression != null && sortDirection != null) {
            sort = new Sort(sortDirection.equals("1") ? Sort.Direction.ASC : Sort.Direction.DESC, sortExpression);
        }
        Pageable pageable = new PageRequest(page - 1, limit, sort);
        List<FilmEntity> filmEntities;
        filmEntities = filmRepository.findAllByProperties(search, filmType, category, country, year, pageable);
        List<FilmDTO> filmDTOS = new ArrayList<FilmDTO>();
        for (FilmEntity entity : filmEntities) {
            FilmDTO filmDTO = filmConvert.toDTO(entity);
            filmDTOS.add(filmDTO);
        }
        return filmDTOS;
    }

    public List<FilmDTO> findByProperties(int page, int limit, String sortExpression, String sortDirection) {
        Sort sort = null;
        if (sortExpression != null && sortDirection != null) {
            sort = new Sort(sortDirection.equals("1") ? Sort.Direction.ASC : Sort.Direction.DESC, sortExpression);
        }
        Pageable pageable = new PageRequest(page - 1, limit, sort);
        List<FilmEntity> filmEntities;
        filmEntities = filmRepository.findAllByStatus(CoreConstant.ACTIVE_STATUS, pageable);
        List<FilmDTO> filmDTOS = new ArrayList<FilmDTO>();
        for (FilmEntity entity : filmEntities) {
            FilmDTO filmDTO = filmConvert.toDTO(entity);
            filmDTOS.add(filmDTO);
        }
        return filmDTOS;
    }

    public List<FilmDTO> findByProperties(String filmTypeCode, int page, int limit, String sortExpression, String sortDirection) {
        Sort sort = null;
        if (sortExpression != null && sortDirection != null) {
            sort = new Sort(sortDirection.equals("1") ? Sort.Direction.ASC : Sort.Direction.DESC, sortExpression);
        }
        Pageable pageable = new PageRequest(page - 1, limit, sort);
        List<FilmEntity> filmEntities;
        filmEntities = filmRepository.findAllByStatusAndFilmType_Code(CoreConstant.ACTIVE_STATUS, filmTypeCode, pageable);
        List<FilmDTO> filmDTOS = new ArrayList<FilmDTO>();
        for (FilmEntity entity : filmEntities) {
            FilmDTO filmDTO = filmConvert.toDTO(entity);
            filmDTOS.add(filmDTO);
        }
        return filmDTOS;
    }

    public List<FilmDTO> findByProperties(boolean trailer, int page, int limit, String sortExpression, String sortDirection) {
        Sort sort = null;
        if (sortExpression != null && sortDirection != null) {
            sort = new Sort(sortDirection.equals("1") ? Sort.Direction.ASC : Sort.Direction.DESC, sortExpression);
        }
        Pageable pageable = new PageRequest(page - 1, limit, sort);
        List<FilmEntity> filmEntities;
        filmEntities = filmRepository.findAllByStatusAndTrailerNotNull(CoreConstant.ACTIVE_STATUS, pageable);
        List<FilmDTO> filmDTOS = new ArrayList<FilmDTO>();
        for (FilmEntity entity : filmEntities) {
            FilmDTO filmDTO = filmConvert.toDTO(entity);
            filmDTOS.add(filmDTO);
        }
        return filmDTOS;
    }

    public List<FilmDTO> findByProperties(Long userId, int page, int limit) {
        Pageable pageable = new PageRequest(page - 1, limit);
        List<FilmEntity> filmEntities;
        filmEntities = filmRepository.findAllByUserFollow(userId, CoreConstant.ACTIVE_STATUS, pageable);
        List<FilmDTO> filmDTOS = new ArrayList<FilmDTO>();
        for (FilmEntity entity : filmEntities) {
            FilmDTO filmDTO = filmConvert.toDTO(entity);
            filmDTOS.add(filmDTO);
        }
        return filmDTOS;
    }

    public int getTotalItem(String search, String filmType, String category, String country, String year) {
        return (int) filmRepository.countAllByProperties(search, filmType, category, country, year);
    }

    public int getTotalItem(String userName, String search) {
        if (!userName.equals("ADMIN")) {
            return (int) filmRepository.countAllByEmployee_UserNameAndNameOrCodeAndStatus(userName, search, CoreConstant.ACTIVE_STATUS);
        } else {
            return (int) filmRepository.countAllByNameContainingOrCodeContaining(search, search);
        }
    }

    public FilmDTO findOneById(Long id) {
        FilmEntity entity = filmRepository.findOne(id);
        Integer countEpisode = episodeRepository.countAllByFilm_IdAndStatus(entity.getId(), CoreConstant.ACTIVE_STATUS);
        if (entity == null) return null;
        FilmDTO filmDTO = filmConvert.toDTO(entity);
        filmDTO.setEpisodesCount(countEpisode);
        return filmDTO;
    }

    public FilmDTO findOne(Long id, String code, Integer status) {
        FilmEntity entity = filmRepository.findOneByIdAndCodeAndStatus(id, code, status);
        if (entity == null) {
            return null;
        }
        Integer countEpisode = episodeRepository.countAllByFilm_IdAndStatus(entity.getId(), CoreConstant.ACTIVE_STATUS);
        FilmDTO filmDTO = filmConvert.toDTO(entity);
        filmDTO.setEpisodesCount(countEpisode);
        return filmDTO;
    }

    public FilmDTO findOneById(Long id, Integer status) {
        FilmEntity entity = filmRepository.findOneByIdAndStatus(id, status);
        if (entity == null) {
            return null;
        }
        Integer countEpisode = episodeRepository.countAllByFilm_IdAndStatus(entity.getId(), CoreConstant.ACTIVE_STATUS);
        FilmDTO filmDTO = filmConvert.toDTO(entity);
        filmDTO.setEpisodesCount(countEpisode);
        return filmDTO;
    }

    public FilmDTO findOneById(Long id, String poster, Integer status) {
        FilmEntity entity = filmRepository.findOneByIdAndCreatedByAndStatus(id, poster, status);
        if (entity == null) {
            return null;
        }
        Integer countEpisode = episodeRepository.countAllByFilm_IdAndStatus(entity.getId(), CoreConstant.ACTIVE_STATUS);
        FilmDTO filmDTO = filmConvert.toDTO(entity);
        filmDTO.setEpisodesCount(countEpisode);
        return filmDTO;
    }

    public FilmDTO findOneByCode(String code) {
        FilmEntity entity = filmRepository.findOneByCode(code);
        if (entity == null) {
            return null;
        }
        Integer countEpisode = episodeRepository.countAllByFilm_IdAndStatus(entity.getId(), CoreConstant.ACTIVE_STATUS);
        FilmDTO filmDTO = filmConvert.toDTO(entity);
        filmDTO.setEpisodesCount(countEpisode);
        return filmDTO;
    }

    public boolean checkPosterFilm(Long id, String userName) {
        long count = filmRepository.countAllByIdAndEmployee_UserNameAndStatus(id, userName, 1);
        if (count >= 1) {
            return true;
        } else {
            return false;
        }
    }

    @Autowired
    private StringGlobalUtils stringGlobalUtils;

    @Transactional
    public FilmDTO save(FilmDTO filmDTO) {
        FilmEntity entity;
        String code = stringGlobalUtils.covertToString(filmDTO.getName());
        if (filmDTO.getId() != null) {
            entity = filmRepository.findOne(filmDTO.getId());
            entity = filmConvert.toEntity(filmDTO, entity, "image");
        } else {
            entity = filmConvert.toEntity(filmDTO);
            entity.setScores(0.0);
        }
        entity.setCode(code);
        List<CategoryEntity> categoryEntities = new ArrayList<CategoryEntity>();
        if (filmDTO.getCategories() != null) {
            for (CategoryDTO categoryDTO : filmDTO.getCategories()) {
                CategoryEntity categoryEntity = new CategoryEntity();
                BeanUtils.copyProperties(categoryDTO, categoryEntity);
                categoryEntities.add(categoryEntity);
            }
        }
        List<ActorEntity> actorEntities = new ArrayList<ActorEntity>();
        if (filmDTO.getActors() != null) {
            for (ActorDTO actorDTO : filmDTO.getActors()) {
                ActorEntity actorEntity = new ActorEntity();
                BeanUtils.copyProperties(actorDTO, actorEntity);
                actorEntities.add(actorEntity);
            }
        }
        entity.setCategories(categoryEntities);
        entity.setActors(actorEntities);
        entity = filmRepository.save(entity);
        filmDTO = filmConvert.toDTO(entity);
        return filmDTO;
    }

    @Transactional
    public boolean updateFilmStatus(FilmDTO filmDTO) {
        FilmEntity filmEntity = filmRepository.findOne(filmDTO.getId());
        filmEntity.setStatus(filmDTO.getStatus());
        filmRepository.save(filmEntity);
        return true;
    }

    @Autowired
    private IEpisodeService episodeService;

    @Transactional
    public void deleteById(Long[] ids) {
        for (Long id : ids) {
            // update episode
            FilmEntity entity = filmRepository.findOne(id);
            if (entity.getImage() != null) {
                try {
                    driveService.deleteFileById(entity.getImage());
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            for (EpisodeEntity episodeEntity : entity.getEpisodes()) {
                Long[] episodeIds = {episodeEntity.getId()};
                episodeService.delete(episodeIds);
            }
            filmRepository.delete(id);
        }
    }

    @Autowired
    private IDriveService driveService;

    @Transactional
    public void updatePhoto(Long id, FileItem photo) throws IOException {
        FilmEntity filmEntity = filmRepository.findOne(id);
        if (StringUtils.isNotBlank(filmEntity.getImage())) {
            try {
                driveService.deleteFileById(filmEntity.getImage());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        String photoName = "film_image_" + id;
        File file = driveService.createGoogleFile(CoreConstant.FILM_IMAGE_ADDRESS_ID, photo.getContentType(), photoName, photo.getInputStream());
        driveService.createPublicPermission(file.getId());
        filmEntity.setImage(file.getId());
        filmRepository.save(filmEntity);
    }

    public void updateTrailer(Long id, FileItem trailer) throws IOException {
        FilmEntity filmEntity = filmRepository.findOne(id);
        if (StringUtils.isNotBlank(filmEntity.getTrailer())) {
            try {
                driveService.deleteFileById(filmEntity.getTrailer());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        String trailerName = "film_trailer_" + id;
        File file = driveService.createGoogleFile(CoreConstant.FILM_TRAILER_ADDRESS_ID, trailer.getContentType(), trailerName, trailer.getInputStream());
        driveService.createPublicPermission(file.getId());
        filmEntity.setTrailer(file.getId());
        filmRepository.save(filmEntity);
    }

    public void updateScores(Long id) {
        FilmEntity filmEntity = filmRepository.findOne(id);
        Double total = 0.0;
        int n = 0;
        for (EvaluateEntity evaluateEntity : filmEntity.getEvaluates()) {
            if (evaluateEntity.getScores() != null) {
                total = total + evaluateEntity.getScores();
                n++;
            }
        }
        filmEntity.setScores(total / n);
        filmEntity.setTotalVote(n);
        filmRepository.save(filmEntity);
    }

    public void updateView(Long id) {
        FilmEntity filmEntity = filmRepository.findOne(id);
        int view;
        if (filmEntity.getView() == null) {
            view = 0;
        } else {
            view = filmEntity.getView() + 1;
        }

        filmEntity.setView(view);
        filmRepository.save(filmEntity);
    }
}
