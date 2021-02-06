package com.movie.core.dto;

public class CommentLikeDTO extends AbstractDTO<CommentLikeDTO> {
    private Integer status;
    private UserDTO user;
    private CommentDTO comment;

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO user) {
        this.user = user;
    }

    public CommentDTO getComment() {
        return comment;
    }

    public void setComment(CommentDTO comment) {
        this.comment = comment;
    }
}
