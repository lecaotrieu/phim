package com.movie.core.dto;

import java.util.List;

public class CityDTO extends AbstractDTO<CityDTO> {
    private String name;
    private String code;
    private List<DistrictDTO> districts;
    private List<CommuneDTO> communes;
    private List<EmployeeDTO> employeeDTOS;
    private CountryDTO country;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public List<DistrictDTO> getDistricts() {
        return districts;
    }

    public void setDistricts(List<DistrictDTO> districts) {
        this.districts = districts;
    }

    public CountryDTO getCountry() {
        return country;
    }

    public void setCountry(CountryDTO country) {
        this.country = country;
    }

    public List<EmployeeDTO> getEmployeeDTOS() {
        return employeeDTOS;
    }

    public void setEmployeeDTOS(List<EmployeeDTO> employeeDTOS) {
        this.employeeDTOS = employeeDTOS;
    }

    public List<CommuneDTO> getCommunes() {
        return communes;
    }

    public void setCommunes(List<CommuneDTO> communes) {
        this.communes = communes;
    }

}
