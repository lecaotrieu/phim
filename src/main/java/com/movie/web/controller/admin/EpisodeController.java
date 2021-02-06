package com.movie.web.controller.admin;

import com.movie.web.command.EpisodeCommand;
import com.movie.core.constant.CoreConstant;
import com.movie.core.dto.EpisodeDTO;
import com.movie.core.dto.FilmDTO;
import com.movie.core.service.IEpisodeService;
import com.movie.core.service.IFilmService;
import com.movie.core.constant.WebConstant;
import com.movie.web.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller(value = "EpisodeControllerOfAdmin")
public class EpisodeController {

    @Autowired
    private IFilmService filmService;
    @Autowired
    private IEpisodeService episodeService;

    @RequestMapping(value = {"/admin/film/{filmCode}-{filmId}"}, method = RequestMethod.GET)
    public ModelAndView showEpisodeEdit(@PathVariable("filmCode") String filmCode, @PathVariable("filmId") Long filmId) {
        ModelAndView mav;
        boolean check = buildCheck(filmId);
        if (check == true) {
            FilmDTO filmDTO = buildFilmToShow(filmId);
            mav = new ModelAndView("/admin/episode/edit");
            mav.addObject("film", filmDTO);
            buildFilmToShow(filmId);
            if (!filmCode.equals(filmDTO.getCode())) {
                mav = new ModelAndView("redirect:/admin/film/" + filmDTO.getCode() + "-" + filmId);
            }
        } else {
            mav = new ModelAndView("redirect:/admin/film/list");
        }
        return mav;
    }

    private FilmDTO buildFilmToShow(Long filmId) {
        FilmDTO filmDTO = filmService.findOneById(filmId);
        List<EpisodeDTO> episodeDTOS;
        if (SecurityUtils.getEmployeeAuthorities().contains(WebConstant.ROLE_ADMIN)) {
            episodeDTOS = episodeService.findAllByFilmId(filmDTO.getId());
        } else {
            episodeDTOS = episodeService.findAllByFilmId(filmDTO.getId(), CoreConstant.ACTIVE_STATUS);
        }
        filmDTO.setEpisodes(episodeDTOS);
        return filmDTO;
    }


    @RequestMapping(value = {"/admin/film/{filmCode}-{filmId}/tap-{episodeCode}-{id}"}, method = RequestMethod.GET)
    public ModelAndView showEpisodeEdit(@PathVariable("filmCode") String filmCode, @PathVariable("filmId") Long filmId, @PathVariable("episodeCode") Integer episodeCode, @PathVariable("id") Long id) {
        boolean check = buildCheck(filmId);
        ModelAndView mav;
        if (check == true) {
            FilmDTO filmDTO = buildFilmToShow(filmId);
            mav = new ModelAndView("/admin/episode/edit");
            mav.addObject("film", filmDTO);
            EpisodeDTO episodeDTO;
            if (SecurityUtils.getEmployeeAuthorities().contains(WebConstant.ROLE_ADMIN)) {
                episodeDTO = episodeService.findOneById(id);
            } else {
                episodeDTO = episodeService.findOneById(id, CoreConstant.ACTIVE_STATUS);
            }
            if (episodeDTO!=null){
                mav.addObject(WebConstant.FORM_ITEM, episodeDTO);
                if (!filmCode.equals(filmDTO.getCode()) || !episodeCode.equals(episodeDTO.getEpisodeCode())) {
                    mav = new ModelAndView("redirect:/admin/film/" + filmDTO.getCode() + "-" + filmId + "/tap-" + episodeDTO.getEpisodeCode() + "-" + id);
                }
            } else{
                mav = new ModelAndView("redirect:/admin/film/list");
            }
        } else {
            mav = new ModelAndView("redirect:/admin/film/list");
        }
        return mav;
    }

    @RequestMapping(value = {"/ajax/admin/film/list"}, method = RequestMethod.GET)
    public ModelAndView showEpisodeList(@RequestParam("filmId") Long id) {
        EpisodeCommand command = new EpisodeCommand();
        boolean check = buildCheck(id);
        ModelAndView mav = null;
        if (check == true) {
            if (SecurityUtils.getEmployeeAuthorities().contains(WebConstant.ROLE_ADMIN)) {
                command.setListResult(episodeService.findAllByFilmId(id));
            } else if (SecurityUtils.getEmployeeAuthorities().contains(WebConstant.ROLE_POSTER)) {
                command.setListResult(episodeService.findAllByFilmId(id, CoreConstant.ACTIVE_STATUS));
            }
            FilmDTO filmDTO = filmService.findOneById(id);
            mav = new ModelAndView("/admin/episode/list");
            mav.addObject("film", filmDTO);
            mav.addObject(WebConstant.LIST_ITEM, command);
        }
        return mav;
    }

    private boolean buildCheck(Long id) {
        boolean check = false;
        if (SecurityUtils.getEmployeeAuthorities().contains("ADMIN")) {
            check = true;
        } else {
            check = filmService.checkPosterFilm(id, SecurityUtils.getPrincipal().getUsername());
        }
        return check;
    }
}
