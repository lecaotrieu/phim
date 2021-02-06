package com.movie.core.entity;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "city")
public class CityEntity extends BaseEntity {
    @Column
    private String name;

    @Column
    private String code;

    @OneToMany(mappedBy = "city", fetch = FetchType.LAZY)
    private List<DistrictEntity> districts;

    @OneToMany(mappedBy = "city", fetch = FetchType.LAZY)
    private List<CommuneEntity> communes;

    @OneToMany(mappedBy = "city", fetch = FetchType.LAZY)
    private List<EmployeeEntity> employees;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "country_id")
    private CountryEntity country;

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

    public List<DistrictEntity> getDistricts() {
        return districts;
    }

    public void setDistricts(List<DistrictEntity> districts) {
        this.districts = districts;
    }

    public CountryEntity getCountry() {
        return country;
    }

    public void setCountry(CountryEntity country) {
        this.country = country;
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
}
