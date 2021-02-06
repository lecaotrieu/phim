package com.movie.web.command;

import com.movie.core.command.AbstractCommand;
import com.movie.core.dto.CommentDTO;

public class CommentCommand extends AbstractCommand<CommentDTO> {
    public CommentCommand() {
        this.pojo = new CommentDTO();
    }
    private Long filmId;
    private Long commentId;
    private Integer nextCountItem;

    public Long getFilmId() {
        return filmId;
    }

    public void setFilmId(Long filmId) {
        this.filmId = filmId;
    }

    public Long getCommentId() {
        return commentId;
    }

    public void setCommentId(Long commentId) {
        this.commentId = commentId;
    }

    public Integer getNextCountItem() {
        return nextCountItem;
    }

    public void setNextCountItem(Integer nextCountItem) {
        this.nextCountItem = nextCountItem;
    }
}
