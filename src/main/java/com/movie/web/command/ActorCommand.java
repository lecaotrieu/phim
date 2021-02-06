package com.movie.web.command;

import com.movie.core.command.AbstractCommand;
import com.movie.core.dto.ActorDTO;

public class ActorCommand extends AbstractCommand<ActorDTO> {
    public ActorCommand() {
        this.pojo = new ActorDTO();
    }
}
