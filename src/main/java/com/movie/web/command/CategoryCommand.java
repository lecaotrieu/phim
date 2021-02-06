package com.movie.web.command;

import com.movie.core.command.AbstractCommand;
import com.movie.core.dto.CategoryDTO;

public class CategoryCommand extends AbstractCommand<CategoryDTO> {
    public CategoryCommand() {
        this.pojo = new CategoryDTO();
    }
}
