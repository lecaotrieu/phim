package com.movie.core.dto;

import java.util.List;

public class CountryDTO extends AbstractDTO<CountryDTO> {
    private String code;
    private String name;
    private List<CityDTO> cities;
    private List<DistrictDTO> districts;
    private List<CommuneDTO> communes;
    private List<FilmDTO> films;
    private List<EmployeeDTO> employees;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<CityDTO> getCities() {
        return cities;
    }

    public void setCities(List<CityDTO> cities) {
        this.cities = cities;
    }

    public List<FilmDTO> getFilms() {
        return films;
    }

    public void setFilms(List<FilmDTO> films) {
        this.films = films;
    }

    public List<EmployeeDTO> getEmployees() {
        return employees;
    }

    public void setEmployees(List<EmployeeDTO> employees) {
        this.employees = employees;
    }

    public List<DistrictDTO> getDistricts() {
        return districts;
    }

    public void setDistricts(List<DistrictDTO> districts) {
        this.districts = districts;
    }

    public List<CommuneDTO> getCommunes() {
        return communes;
    }

    public void setCommunes(List<CommuneDTO> communes) {
        this.communes = communes;
    }
}
