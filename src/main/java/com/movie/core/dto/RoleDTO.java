package com.movie.core.dto;

import java.util.List;

public class RoleDTO extends AbstractDTO<RoleDTO> {
    private String code;
    private String name;
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

    public List<EmployeeDTO> getEmployees() {
        return employees;
    }

    public void setEmployees(List<EmployeeDTO> employees) {
        this.employees = employees;
    }
}
