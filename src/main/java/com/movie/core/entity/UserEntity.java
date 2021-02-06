package com.movie.core.entity;

import javax.persistence.*;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "user")
public class UserEntity extends BaseEntity {
    @Column(name = "username", unique = true)
    private String userName;

    @Column(name = "password")
    private String password;

    @Column
    private String email;

    @Column(name = "firstname")
    private String firstName;

    @Column(name = "lastname")
    private String lastName;

    @Column(name = "photo")
    private String photo;

    @Column(name="birthdate")
    private Date birthDate;

    @Column
    private String phone;

    @Column
    private Integer status;

    @Column(columnDefinition = "VARCHAR(255)")
    private String address;

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<EvaluateEntity> evaluates;

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<CommentEntity> comments;

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<CommentLikeEntity> commentLikes;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public List<EvaluateEntity> getEvaluates() {
        return evaluates;
    }

    public void setEvaluates(List<EvaluateEntity> evaluates) {
        this.evaluates = evaluates;
    }

    public List<CommentEntity> getComments() {
        return comments;
    }

    public void setComments(List<CommentEntity> comments) {
        this.comments = comments;
    }

    public List<CommentLikeEntity> getCommentLikes() {
        return commentLikes;
    }

    public void setCommentLikes(List<CommentLikeEntity> commentLikes) {
        this.commentLikes = commentLikes;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }
}
