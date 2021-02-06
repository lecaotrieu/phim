package com.movie.core.dto;

import org.apache.commons.fileupload.FileItem;

public class EpisodeDTO extends AbstractDTO<EpisodeDTO> {
    private String episodeId;
    private String name;
    private Integer episodeCode;
    private FileItem video;
    private Integer status;
    private FilmDTO film;

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


    public FilmDTO getFilm() {
        return film;
    }

    public void setFilm(FilmDTO film) {
        this.film = film;
    }

    public FileItem getVideo() {
        return video;
    }

    public void setVideo(FileItem video) {
        this.video = video;
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
