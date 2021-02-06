package com.movie.web.command;

import com.movie.core.command.AbstractCommand;
import com.movie.core.dto.DirectorDTO;

public class DirectorCommand extends AbstractCommand<DirectorDTO> {
    public DirectorCommand() {
        this.pojo = new DirectorDTO();
    }
}
