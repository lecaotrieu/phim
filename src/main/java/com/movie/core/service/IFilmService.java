package com.movie.core.service;

import com.movie.core.dto.FilmDTO;
import org.apache.commons.fileupload.FileItem;

import java.io.IOException;
import java.util.List;

public interface IFilmService {
    List<FilmDTO> findByProperties(String search, String userName, int page, int limit, String sortExpression, String sortDirection);

    List<FilmDTO> findByProperties(String search, String filmType, String category, String country, String year, int page, int limit, String sortExpression, String sortDirection);

    List<FilmDTO> findByProperties(int page, int limit, String sortExpression, String sortDirection);

    List<FilmDTO> findByProperties(String filmTypeCode, int page, int limit, String sortExpression, String sortDirection);

    List<FilmDTO> findByProperties(boolean trailer, int page, int limit, String sortExpression, String sortDirection);

    List<FilmDTO> findByProperties(Long userId,int page, int limit);

    int getTotalItem(String search, String filmType, String category, String country, String year);

    int getTotalItem(String userName, String search);

    FilmDTO findOneById(Long id);

    FilmDTO findOne(Long id, String code, Integer status);

    FilmDTO findOneById(Long id, Integer status);

    FilmDTO findOneById(Long id, String poster, Integer status);

    FilmDTO findOneByCode(String code);

    boolean checkPosterFilm(Long id, String userName);

    FilmDTO save(FilmDTO filmDTO);

    boolean updateFilmStatus(FilmDTO filmDTO);

    void deleteById(Long[] ids);

    void updatePhoto(Long id, FileItem photo) throws IOException;

    void updateTrailer(Long id, FileItem trailer) throws IOException;

    void updateScores(Long id);

    void updateView(Long id);
}
