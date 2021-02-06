package com.movie.core.dto;

import java.util.List;

public class CommentDTO extends AbstractDTO<CommentDTO>{
    private String content;
    private UserDTO user;
    private List<CommentDTO> comments;
    private CommentDTO comment;
    private FilmDTO film;
    private String thoiGianDang;
    private List<CommentLikeDTO> commentLikes;
    private Integer like;
    private Integer totalLike;
    private Integer subCommentCount=0;

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO user) {
        this.user = user;
    }

    public List<CommentDTO> getComments() {
        return comments;
    }

    public void setComments(List<CommentDTO> comments) {
        this.comments = comments;
    }

    public CommentDTO getComment() {
        return comment;
    }

    public void setComment(CommentDTO comment) {
        this.comment = comment;
    }

    public FilmDTO getFilm() {
        return film;
    }

    public void setFilm(FilmDTO film) {
        this.film = film;
    }

    public List<CommentLikeDTO> getCommentLikes() {
        return commentLikes;
    }

    public void setCommentLikes(List<CommentLikeDTO> commentLikes) {
        this.commentLikes = commentLikes;
    }

    public String getThoiGianDang() {
        return thoiGianDang;
    }

    public void setThoiGianDang(String thoiGianDang) {
        this.thoiGianDang = thoiGianDang;
    }

    public Integer getLike() {
        return like;
    }

    public void setLike(Integer like) {
        this.like = like;
    }

    public Integer getSubCommentCount() {
        return subCommentCount;
    }

    public void setSubCommentCount(Integer subCommentCount) {
        this.subCommentCount = subCommentCount;
    }

    public Integer getTotalLike() {
        return totalLike;
    }

    public void setTotalLike(Integer totalLike) {
        this.totalLike = totalLike;
    }
}
