package com.movie.web.controller.web;

import com.movie.core.constant.CoreConstant;
import com.movie.core.constant.WebConstant;
import com.movie.core.dto.EpisodeDTO;
import com.movie.core.dto.EvaluateDTO;
import com.movie.core.dto.FilmDTO;
import com.movie.core.service.IEpisodeService;
import com.movie.core.service.IEvaluateService;
import com.movie.core.service.IFilmService;
import com.movie.web.command.FilmCommand;
import com.movie.web.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller(value = "FilmControllerOfWeb")
public class FilmController {
    @Autowired
    private IFilmService filmService;
    @Autowired
    private IEpisodeService episodeService;


    @RequestMapping(value = "/film/{filmCode}-{filmId}/{episode}", method = RequestMethod.GET)
    public ModelAndView showFilmAndEpisode(@PathVariable("filmId") Long filmId, @PathVariable("filmCode") String filmCode, @PathVariable("episode") Integer epCode) {
        ModelAndView mav = new ModelAndView("web/film/episode/show");
        FilmDTO filmDTO = filmService.findOne(filmId, filmCode, CoreConstant.ACTIVE_STATUS);
        filmDTO.setEpisodes(episodeService.findAllByFilmId(filmId));
        EpisodeDTO episodeDTO = episodeService.findOneByFilmAndCode(filmCode, epCode);
        if (SecurityUtils.getUserAuthorities().contains("USER")) {
            EvaluateDTO evaluateDTO = evaluateService.findOneByUserAndFilm(filmId, SecurityUtils.getUserPrincipal().getId());
            if (evaluateDTO != null) {
                mav.addObject("evaluate", evaluateDTO);
            }
        }
        List<FilmDTO> relatedFilms = filmService.findByProperties("", filmDTO.getFilmType().getCode(),"","","",1,8,"modifiedDate",CoreConstant.SORT_ASC);
        mav.addObject("film", filmDTO);
        mav.addObject("relatedFilms", relatedFilms);
        mav.addObject("episode", episodeDTO);
        mav.addObject("comments", episodeDTO);
        return mav;
    }


    @RequestMapping(value = {"/phim","/phim/tim-kiem", "/phim/nam-{year}", "/phim/quoc-gia/{country}", "/phim/quoc-gia/{country}/{year}", "/phim/the-loai/{category}",
            "/phim/the-loai/{category}/{country}", "/phim/the-loai/{category}/{country}/{year}", "/phim/the-loai/{category}/nam-{year}",
            "/phim/{filmType}", "/phim/{filmType}/nam-{year}", "/phim/{filmType}/nuoc-{country}", "/phim/{filmType}/nuoc-{country}/{year}", "/phim/{filmType}/{category}",
            "/phim/{filmType}/{category}/nam-{year}", "/phim/{filmType}/{category}/{country}", "/phim/{filmType}/{category}/{country}/{year}"}, method = RequestMethod.GET)
    public ModelAndView showListFilm(@PathVariable(value = "year", required = false) String year,
                                     @PathVariable(value = "country", required = false) String country,
                                     @PathVariable(value = "category", required = false) String category,
                                     @PathVariable(value = "filmType", required = false) String filmType,
                                     @RequestParam(value = "sort", required = false) String sortExpression,
                                     @RequestParam(value = "search", required = false) String search,
                                     @RequestParam(value = "page", required = false) Integer page) {
        ModelAndView mav = new ModelAndView("web/film/list");
        FilmCommand command = new FilmCommand();
        command = setValueForCommand(command, search, page, sortExpression, filmType, category, country, year);
        List<FilmDTO> filmDTOS = filmService.findByProperties(command.getSearch(), command.getFilmType(), command.getCategory(), command.getCountry(), command.getYear(), command.getPage(), command.getLimit(), sortExpression, "1");
        command.setListResult(filmDTOS);
        command.setTotalItems(filmService.getTotalItem(command.getSearch(), command.getFilmType(), command.getCategory(), command.getCountry(), command.getYear()));
        command.setTotalPage((int) Math.ceil((double)command.getTotalItems() / command.getLimit()));
        mav.addObject(WebConstant.LIST_ITEM, command);
        return mav;
    }

    private FilmCommand setValueForCommand(FilmCommand command, String search, Integer page, String sortExpression, String filmType, String category, String country, String year) {
        if (page != null) {
            command.setPage(page);
        }
        if (sortExpression != null) {
            command.setSortExpression(sortExpression);
        }
        if (filmType != null) {
            command.setFilmType(filmType);
        }
        if (category != null) {
            command.setCategory(category);
        }
        if (country != null) {
            command.setCountry(country);
        }
        if (year != null) {
            command.setYear(year);
        }
        if (search != null) {
            command.setSearch(search);
        }
        command.setLimit(18);
        return command;
    }


    @Autowired
    private IEvaluateService evaluateService;

    @RequestMapping(value = "/film/{filmCode}-{filmId}", method = RequestMethod.GET)
    public ModelAndView showFilmDetail(@PathVariable("filmId") Long filmId, @PathVariable("filmCode") String filmCode) {
        ModelAndView mav = new ModelAndView("web/film/movie-info");
        FilmDTO filmDTO = filmService.findOne(filmId, filmCode, CoreConstant.ACTIVE_STATUS);
        if (SecurityUtils.getUserAuthorities().contains("USER")) {
            EvaluateDTO evaluateDTO = evaluateService.findOneByUserAndFilm(filmId, SecurityUtils.getUserPrincipal().getId());
            if (evaluateDTO != null)
                mav.addObject("evaluate", evaluateDTO);
        }
        mav.addObject("film", filmDTO);
        return mav;
    }
}
