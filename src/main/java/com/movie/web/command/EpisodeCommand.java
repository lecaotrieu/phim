package com.movie.web.command;

import com.movie.core.command.AbstractCommand;
import com.movie.core.dto.EpisodeDTO;

public class EpisodeCommand extends AbstractCommand<EpisodeDTO> {
    public EpisodeCommand() {
        this.pojo = new EpisodeDTO();
    }
}
