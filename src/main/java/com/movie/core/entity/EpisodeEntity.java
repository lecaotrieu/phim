package com.movie.core.entity;

import javax.persistence.*;

@Entity
@Table(name = "episode")
public class EpisodeEntity extends BaseEntity {
    @Column(name = "episode_id")
    private String episodeId;

    @Column
    private String name;

    @Column(name = "episode_code")
    private Integer episodeCode;

    @Column(name = "status")
    private Integer status;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "film_id")
    private FilmEntity film;

    public String getEpisodeId() {
        return episodeId;
    }

    public void setEpisodeId(String episodeId) {
        this.episodeId = episodeId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public FilmEntity getFilm() {
        return film;
    }

    public void setFilm(FilmEntity film) {
        this.film = film;
    }

    public Integer getEpisodeCode() {
        return episodeCode;
    }

    public void setEpisodeCode(Integer episodeCode) {
        this.episodeCode = episodeCode;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
