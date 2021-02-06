package com.movie.web.command;

import com.movie.core.command.AbstractCommand;
import com.movie.core.dto.FilmTypeDTO;

public class FilmTypeCommand extends AbstractCommand<FilmTypeDTO> {
    public FilmTypeCommand() {
        this.pojo = new FilmTypeDTO();
    }
}
