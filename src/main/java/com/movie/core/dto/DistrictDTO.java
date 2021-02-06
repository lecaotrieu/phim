package com.movie.core.dto;

import java.util.List;

public class DistrictDTO extends AbstractDTO<DistrictDTO> {
    private String code;
    private String name;
    private List<CommuneDTO> communes;
    private List<EmployeeDTO> employees;
    private CityDTO city;
    private CountryDTO country;

    public List<EmployeeDTO> getEmployees() {
        return employees;
    }

    public void setEmployees(List<EmployeeDTO> employees) {
        this.employees = employees;
    }

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

    public List<CommuneDTO> getCommunes() {
        return communes;
    }

    public void setCommunes(List<CommuneDTO> communes) {
        this.communes = communes;
    }

    public CityDTO getCity() {
        return city;
    }

    public void setCity(CityDTO city) {
        this.city = city;
    }

    public CountryDTO getCountry() {
        return country;
    }

    public void setCountry(CountryDTO country) {
        this.country = country;
    }
}
