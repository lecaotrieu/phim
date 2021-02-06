package com.movie.web.controller.admin;

import com.movie.web.command.FilmTypeCommand;
import com.movie.core.utils.FormUtil;
import com.movie.core.dto.FilmTypeDTO;
import com.movie.core.service.IFilmTypeService;
import com.movie.core.constant.WebConstant;
import com.movie.core.utils.RequestUtil;
import com.movie.core.utils.WebCommonUtil;
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

@Controller(value = "FilmTypeControllerOfAdmin")
public class FilmTypeController {
    ResourceBundle bundle = ResourceBundle.getBundle("ApplicationResource");

    @Autowired
    private IFilmTypeService filmTypeService;

    @RequestMapping(value = {"/admin/film-type/list"}, method = RequestMethod.GET)
    public ModelAndView showCategoryList(@RequestParam(value = "message", required = false) String message,
                                         HttpServletRequest request) {
        if (message != null) {
            WebCommonUtil.addRedirectMessage(request, getMapMessage(), message);
        }
        FilmTypeCommand command = FormUtil.populate(FilmTypeCommand.class, request);
        RequestUtil.initSearchBean(request, command);
        executeSearchFilmType(command);
        ModelAndView mav = new ModelAndView("admin/filmType/list");
        mav.addObject(WebConstant.LIST_ITEM, command);
        return mav;
    }

    @RequestMapping(value = {"/ajax/admin/film-type/edit"}, method = RequestMethod.GET)
    public ModelAndView showCategoryEdit(@ModelAttribute("item") FilmTypeDTO filmTypeDTO,
                                         @RequestParam(value = "id", required = false) Long id,
                                         @RequestParam(value = "message", required = false) String message,
                                         HttpServletRequest request) {
        if (message != null) {
            WebCommonUtil.addRedirectMessage(request, getMapMessage(), message);
        }
        ModelAndView mav = new ModelAndView("admin/filmType/edit");
        if (id != null) {
            filmTypeDTO = filmTypeService.findOneById(id);
            mav.addObject(WebConstant.FORM_ITEM, filmTypeDTO);
        }
        return mav;
    }


    private void executeSearchFilmType(FilmTypeCommand command) {
        List<FilmTypeDTO> filmTypeDTOS = filmTypeService.findByProperties(command.getSearch(), command.getPage(), command.getLimit(), command.getSortExpression(), command.getSortDirection());
        command.setListResult(filmTypeDTOS);
        command.setTotalItems(filmTypeService.getTotalItem(command.getSearch()));
        command.setTotalPage((int) Math.ceil((double) command.getTotalItems() / command.getLimit()));
    }

    private Map<String, String> getMapMessage() {
        Map<String, String> mapValue = new HashMap<String, String>();
        mapValue.put(WebConstant.REDIRECT_ERROR, bundle.getString("label.message.error"));
        mapValue.put(WebConstant.REDIRECT_INSERT, bundle.getString("label.film.type.message.add.success"));
        mapValue.put(WebConstant.REDIRECT_DELETE, bundle.getString("label.film.type.message.delete.success"));
        mapValue.put(WebConstant.REDIRECT_UPDATE, bundle.getString("label.film.type.message.update.success"));
        return mapValue;
    }
}
