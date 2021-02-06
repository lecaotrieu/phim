package com.movie.web.controller.admin;

import com.movie.web.command.FilmCommand;
import com.movie.core.utils.FormUtil;
import com.movie.core.dto.FilmDTO;
import com.movie.core.service.IFilmService;
import com.movie.core.constant.WebConstant;
import com.movie.core.utils.RequestUtil;
import com.movie.core.utils.WebCommonUtil;
import com.movie.web.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

@Controller(value = "filmControllerOfAdmin")
public class FilmController {
    ResourceBundle bundle = ResourceBundle.getBundle("ApplicationResource");

    @Autowired
    private IFilmService filmService;

    @RequestMapping(value = {"/admin/film/list"}, method = RequestMethod.GET)
    public ModelAndView showFilmList(@ModelAttribute(WebConstant.LIST_ITEM) FilmCommand command, HttpServletRequest request) {
        command = FormUtil.populate(FilmCommand.class, request);
        RequestUtil.initSearchBean(request, command);
        executeSearchFilm(command);
        ModelAndView mav = new ModelAndView("admin/film/list");
        if (command.getMessage() != null) {
            WebCommonUtil.addRedirectMessage(request, getMapMessage(), command.getMessage());
        }
        mav.addObject(WebConstant.LIST_ITEM, command);
        return mav;
    }

    @RequestMapping(value = {"/admin/film/show"}, method = RequestMethod.GET)
    public ModelAndView showFilmProfile(@RequestParam Long id) {
        FilmDTO filmDTO = null;
        if (id != null) {
            if (SecurityUtils.getEmployeeAuthorities().contains("ADMIN")) {
                filmDTO = filmService.findOneById(id);
            } else if (SecurityUtils.getEmployeeAuthorities().contains("POSTER")) {
                filmDTO = filmService.findOneById(id, 1);
            }
        }
        ModelAndView mav = new ModelAndView("admin/film/profile");
        mav.addObject(WebConstant.FORM_ITEM, filmDTO);
        return mav;
    }

    @RequestMapping(value = "/admin/film/edit", method = RequestMethod.GET)
    public ModelAndView showFilmEdit(@ModelAttribute(WebConstant.FORM_ITEM) FilmDTO filmDTO,
                                     @RequestParam(value = "id", required = false) Long id,
                                     @RequestParam(value = "message", required = false) String message,
                                     HttpServletRequest request) {
        if (message != null) {
            WebCommonUtil.addRedirectMessage(request, getMapMessage(), message);
        }
        if (id != null) {
            if (SecurityUtils.getEmployeeAuthorities().contains("ADMIN")) {
                filmDTO = filmService.findOneById(id);
            } else if (SecurityUtils.getEmployeeAuthorities().contains("POSTER")) {
                filmDTO = filmService.findOneById(id, 1);
            }
        }
        ModelAndView mav = new ModelAndView("admin/film/edit");
        mav.addObject(WebConstant.FORM_ITEM, filmDTO);
        return mav;
    }

    @RequestMapping(value = "/admin/film/trailer", method = RequestMethod.GET)
    public ModelAndView showFilmTrailerEdit(@RequestParam(value = "id", required = false) Long id,
                                            @RequestParam(value = "message", required = false) String message,
                                            HttpServletRequest request) {
        if (message != null) {
            WebCommonUtil.addRedirectMessage(request, getMapMessage(), message);
        }
        FilmDTO filmDTO = new FilmDTO();
        if (id != null) {
            if (SecurityUtils.getEmployeeAuthorities().contains("ADMIN")) {
                filmDTO = filmService.findOneById(id);
            } else if (SecurityUtils.getEmployeeAuthorities().contains("POSTER")) {
                filmDTO = filmService.findOneById(id, 1);
            }
        }
        ModelAndView mav = new ModelAndView("admin/film/trailerEdit");
        mav.addObject(WebConstant.FORM_ITEM, filmDTO);
        return mav;
    }

    public void executeSearchFilm(FilmCommand command) {
        String userName = null;
        if (SecurityUtils.getEmployeeAuthorities().contains("ADMIN")) {
            userName = "ADMIN";
        } else if (SecurityUtils.getEmployeeAuthorities().contains("POSTER")) {
            userName = SecurityUtils.getPrincipal().getUsername();
        }
        List<FilmDTO> filmDTOS = filmService.findByProperties(command.getSearch(), userName,
                command.getPage(), command.getLimit(), command.getSortExpression(), command.getSortDirection());
        command.setListResult(filmDTOS);
        command.setTotalItems(filmService.getTotalItem(userName, command.getSearch()));
        command.setTotalPage((int) Math.ceil((double) command.getTotalItems() / command.getLimit()));
    }

    private Map<String, String> getMapMessage() {
        Map<String, String> mapValue = new HashMap<String, String>();
        mapValue.put(WebConstant.REDIRECT_ERROR, bundle.getString("label.message.error"));
        mapValue.put(WebConstant.REDIRECT_INSERT, bundle.getString("label.film.message.add.success"));
        mapValue.put(WebConstant.REDIRECT_DELETE, bundle.getString("label.film.message.delete.success"));
        mapValue.put(WebConstant.REDIRECT_UPDATE, bundle.getString("label.film.message.update.success"));
        return mapValue;
    }
}
