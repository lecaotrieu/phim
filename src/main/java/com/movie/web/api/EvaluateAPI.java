package com.movie.web.api;

import com.movie.core.dto.EvaluateDTO;
import com.movie.core.service.IEvaluateService;
import com.movie.core.service.IFilmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController(value = "EvaluateAPI")
public class EvaluateAPI {
    @Autowired
    private IEvaluateService evaluateService;
    @Autowired
    private IFilmService filmService;

    @PostMapping("/api/evaluate")
    public Long saveEvaluate(@RequestBody EvaluateDTO evaluateDTO) {
        return evaluateService.save(evaluateDTO);
    }

    @PutMapping("/api/evaluate")
    public Long updateEvaluate(@RequestBody EvaluateDTO evaluateDTO) {
        return evaluateService.save(evaluateDTO);
    }

    @PutMapping("/api/evaluate/follow")
    public Long updateEvaluateFollow(@RequestBody EvaluateDTO evaluateDTO) {
        return evaluateService.updateFollow(evaluateDTO);
    }

    @PutMapping("/api/evaluate/scores")
    public Long updateEvaluateScores(@RequestBody EvaluateDTO evaluateDTO) {
        Long result = evaluateService.save(evaluateDTO);
        filmService.updateScores(evaluateDTO.getFilm().getId());
        return result;
    }
}
