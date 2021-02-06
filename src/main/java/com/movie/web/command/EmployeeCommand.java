package com.movie.web.command;

import com.movie.core.command.AbstractCommand;
import com.movie.core.dto.EmployeeDTO;

public class EmployeeCommand extends AbstractCommand<EmployeeDTO> {
    public EmployeeCommand() {
        this.pojo = new EmployeeDTO();
    }
    private String role;

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
