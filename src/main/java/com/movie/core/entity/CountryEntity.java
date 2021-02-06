package com.movie.core.entity;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "country")
public class CountryEntity extends BaseEntity {
    @Column
    private String code;

    @Column
    private String name;

    @OneToMany(mappedBy = "country", fetch = FetchType.LAZY)
    private List<CityEntity> cities;

    @OneToMany(mappedBy = "country", fetch = FetchType.LAZY)
    private List<CommuneEntity> communes;

    @OneToMany(mappedBy = "country", fetch = FetchType.LAZY)
    private List<DistrictEntity> districts;

    @OneToMany(mappedBy = "country", fetch = FetchType.LAZY)
    private List<FilmEntity> films;

    @OneToMany(mappedBy = "country", fetch = FetchType.LAZY)
    private List<EmployeeEntity> employees;

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

    public List<CityEntity> getCities() {
        return cities;
    }

    public void setCities(List<CityEntity> cities) {
        this.cities = cities;
    }

    public List<FilmEntity> getFilms() {
        return films;
    }

    public void setFilms(List<FilmEntity> films) {
        this.films = films;
    }

    public List<EmployeeEntity> getEmployees() {
        return employees;
    }

    public void setEmployees(List<EmployeeEntity> employees) {
        this.employees = employees;
    }

    public List<CommuneEntity> getCommunes() {
        return communes;
    }

    public void setCommunes(List<CommuneEntity> communes) {
        this.communes = communes;
    }

    public List<DistrictEntity> getDistricts() {
        return districts;
    }

    public void setDistricts(List<DistrictEntity> districts) {
        this.districts = districts;
    }

}
