package com.movie.web.api;

import com.movie.core.dto.FilmDTO;
import com.movie.core.service.IFilmService;
import com.movie.core.utils.UploadUtil;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

@RestController(value = "FilmAPI")
public class FilmAPI {

    @Autowired
    private IFilmService filmService;

    @PostMapping("/api/admin/film")
    public FilmDTO createFilm(@RequestBody FilmDTO filmDTO) {
        return filmService.save(filmDTO);
    }

    @PostMapping("/api/admin/film/image")
    public void saveImageFilm(HttpServletRequest request) {
        UploadUtil uploadUtil = new UploadUtil();
        Set<String> titleValue = buildTitleValue();
        Object[] objects = uploadUtil.getFileInputStreams(request, titleValue);
        FilmDTO filmDTO = new FilmDTO();
        filmDTO = returnValueOfDTO(filmDTO, (Map<String, Object>) objects[1]);
        List<FileItem> fileItems = (List<FileItem>) objects[0];
        try {
            filmService.updatePhoto(filmDTO.getId(),fileItems.get(0));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @PutMapping("/api/admin/film/trailer")
    public void updateFilmTrailer(HttpServletRequest request) {
        UploadUtil uploadUtil = new UploadUtil();
        Set<String> titleValue = buildTitleValue();
        Object[] objects = uploadUtil.getFileInputStreams(request, titleValue);
        FilmDTO filmDTO = new FilmDTO();
        filmDTO = returnValueOfDTO(filmDTO, (Map<String, Object>) objects[1]);
        List<FileItem> fileItems = (List<FileItem>) objects[0];
        try {
            filmService.updateTrailer(filmDTO.getId(),fileItems.get(0));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @PutMapping("/api/admin/film")
    public Long updateFilm(@RequestBody FilmDTO filmDTO) {
        return filmService.save(filmDTO).getId();
    }

    @PutMapping("/api/film/view")
    public void updateFilmView(@RequestBody Long filmId) {
         filmService.updateView(filmId);
    }

    @PutMapping("/api/admin/film/status")
    public boolean updateFilmStatus(@RequestBody FilmDTO filmDTO) {
        return filmService.updateFilmStatus(filmDTO);
    }

    @DeleteMapping("/api/admin/film")
    public void deleteFilm(@RequestBody Long[] ids) {
        filmService.deleteById(ids);
    }

    private FilmDTO returnValueOfDTO(FilmDTO dto, Map<String, Object> mapValue) {
        for (Map.Entry<String, Object> item : mapValue.entrySet()) {
            if (item.getKey().equals("id") && StringUtils.isNotBlank((String) item.getValue())) {
                dto.setId(Long.parseLong(item.getValue().toString()));
            }
        }
        return dto;
    }

    private Set<String> buildTitleValue() {
        Set<String> titleValue = new HashSet<String>();
        titleValue.add("id");
        return titleValue;
    }
}
