package com.movie.web.command;

import com.movie.core.command.AbstractCommand;
import com.movie.core.dto.UserDTO;

public class UserCommand extends AbstractCommand<UserDTO> {
    public UserCommand() {
        this.pojo = new UserDTO();
    }
}
