package com.movie.web.api;

import com.movie.core.dto.FilmTypeDTO;
import com.movie.core.service.IFilmTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@RestController(value = "FilmTypeAPIOfAdmin")
public class FilmTypeAPI {
    @Autowired
    private IFilmTypeService filmTypeService;

    @PostMapping("/api/admin/film-type")
    public FilmTypeDTO saveFilmType(@RequestBody FilmTypeDTO filmTypeDTO) {
        try {
            filmTypeDTO = filmTypeService.save(filmTypeDTO);
        } catch (IOException ex) {
            return null;
        }
        return filmTypeDTO;
    }

    @PutMapping("/api/admin/film-type")
    public FilmTypeDTO updateFilmType(@RequestBody FilmTypeDTO filmTypeDTO) {
        try {
            filmTypeDTO = filmTypeService.save(filmTypeDTO);
        } catch (IOException ex) {
            return null;
        }
        return filmTypeDTO;
    }

    @DeleteMapping("/api/admin/film-type")
    public void deleteFilmType(@RequestBody Long[] ids) {
        filmTypeService.delete(ids);
    }
}
