package com.movie.web.command;

import com.movie.core.command.AbstractCommand;
import com.movie.core.dto.FilmDTO;

public class FilmCommand extends AbstractCommand<FilmDTO> {
    public FilmCommand() {
        this.pojo = new FilmDTO();
    }
    private String filmType = "";
    private String year = "";
    private String country = "";
    private String category = "";

    public String getFilmType() {
        return filmType;
    }

    public void setFilmType(String filmType) {
        this.filmType = filmType;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}
