package com.movie.web.command;

import com.movie.core.command.AbstractCommand;
import com.movie.core.dto.RoleDTO;

public class RoleCommand extends AbstractCommand<RoleDTO> {
    public RoleCommand() {
        this.pojo = new RoleDTO();
    }
}
