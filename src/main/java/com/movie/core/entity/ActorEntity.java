package com.movie.core.entity;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "actor")
public class ActorEntity extends BaseEntity {
    @Column
    private String name;

    @Column(unique = true)
    private String code;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column
    private String avatar;

    @ManyToMany(mappedBy = "actors",fetch = FetchType.LAZY)
    private List<FilmEntity> films;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public List<FilmEntity> getFilms() {
        return films;
    }

    public void setFilms(List<FilmEntity> films) {
        this.films = films;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}
