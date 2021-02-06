package com.movie.web.api;

import com.movie.core.dto.EpisodeDTO;
import com.movie.core.dto.FilmDTO;
import com.movie.core.service.IEpisodeService;
import com.movie.core.utils.UploadUtil;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

@RestController(value = "EpisodeAPI")
public class EpisodeAPI {
    @Autowired
    private IEpisodeService episodeService;

    @PostMapping("/api/admin/film/episode")
    public EpisodeDTO saveEpisode(HttpServletRequest request) {
        UploadUtil uploadUtil = new UploadUtil();
        Set<String> titleValue = buildTitleValue();
        Object[] objects = uploadUtil.getFileInputStreams(request, titleValue);
        EpisodeDTO episodeDTO = new EpisodeDTO();
        episodeDTO = returnValueOfDTO(episodeDTO, (Map<String, Object>) objects[1]);
        List<FileItem> fileItems = (List<FileItem>) objects[0];
        if (fileItems.size() > 0) {
            episodeDTO.setVideo(fileItems.get(0));
        }
        return episodeService.save(episodeDTO);
    }

    @PutMapping("/api/admin/film/episode")
    public Long updateEpisode(HttpServletRequest request) {
        UploadUtil uploadUtil = new UploadUtil();
        Set<String> titleValue = buildTitleValue();
        Object[] objects = uploadUtil.getFileInputStreams(request, titleValue);
        EpisodeDTO episodeDTO = new EpisodeDTO();
        episodeDTO = returnValueOfDTO(episodeDTO, (Map<String, Object>) objects[1]);
        List<FileItem> fileItems = (List<FileItem>) objects[0];
        if (fileItems.size() > 0) {
            episodeDTO.setVideo(fileItems.get(0));
        }
        episodeService.save(episodeDTO);
        return episodeDTO.getId();
    }

    @PutMapping("/api/admin/film/episode/status")
    public Long updateEpisodeStatus(@RequestBody EpisodeDTO episodeDTO) {
        return episodeService.updateStatus(episodeDTO.getId(), episodeDTO.getStatus());
    }

    @DeleteMapping("/api/admin/film/episode")
    public void deleteEpisode(@RequestBody Long[] ids) {
        episodeService.delete(ids);
    }

    private EpisodeDTO returnValueOfDTO(EpisodeDTO dto, Map<String, Object> mapValue) {
        for (Map.Entry<String, Object> item : mapValue.entrySet()) {
            if (item.getKey().equals("id") && StringUtils.isNotBlank((String) item.getValue())) {
                dto.setId(Long.parseLong(item.getValue().toString()));
            }
            if (item.getKey().equals("episodeCode") && StringUtils.isNotBlank((String) item.getValue())) {
                dto.setEpisodeCode(Integer.parseInt(item.getValue().toString()));
            }
            if (item.getKey().equals("film.id") && StringUtils.isNotBlank((String) item.getValue())) {
                FilmDTO filmDTO = new FilmDTO();
                filmDTO.setId(Long.parseLong(item.getValue().toString()));
                dto.setFilm(filmDTO);
            }
            if (item.getKey().equals("name") && StringUtils.isNotBlank(item.getValue().toString())) {
                dto.setName(item.getValue().toString());
            }
            if (item.getKey().equals("status") && StringUtils.isNotBlank(item.getValue().toString())) {
                dto.setStatus(Integer.parseInt(item.getValue().toString()));
            }
        }
        return dto;
    }

    private Set<String> buildTitleValue() {
        Set<String> titleValue = new HashSet<String>();
        titleValue.add("film.id");
        titleValue.add("name");
        titleValue.add("episodeCode");
        titleValue.add("id");
        titleValue.add("status");
        return titleValue;
    }
}

