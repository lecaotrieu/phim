package com.movie.web.controller.admin;

import com.movie.web.command.DirectorCommand;
import com.movie.core.utils.FormUtil;
import com.movie.core.dto.DirectorDTO;
import com.movie.core.service.IDirectorService;
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

@Controller(value = "DirectorControllerOfAdmin")
public class DirectorController {
    ResourceBundle bundle = ResourceBundle.getBundle("ApplicationResource");

    @Autowired
    private IDirectorService directorService;

    @RequestMapping(value = {"/admin/director/list"}, method = RequestMethod.GET)
    public ModelAndView showDirectorList(@RequestParam(value = "message", required = false) String message,
                                         HttpServletRequest request) {
        if (message != null) {
            WebCommonUtil.addRedirectMessage(request, getMapMessage(), message);
        }
        DirectorCommand command = FormUtil.populate(DirectorCommand.class, request);
        RequestUtil.initSearchBean(request, command);
        executeSearchDirector(command);
        ModelAndView mav = new ModelAndView("admin/director/list");
        mav.addObject(WebConstant.LIST_ITEM, command);
        return mav;
    }

    @RequestMapping(value = {"/ajax/admin/director/edit"}, method = RequestMethod.GET)
    public ModelAndView showCategoryEdit(@ModelAttribute("item") DirectorDTO directorDTO,
                                         @RequestParam(value = "id", required = false) Long id,
                                         @RequestParam(value = "message", required = false) String message,
                                         HttpServletRequest request) {
        if (message != null) {
            WebCommonUtil.addRedirectMessage(request, getMapMessage(), message);
        }
        ModelAndView mav = new ModelAndView("admin/director/edit");
        if (id != null) {
            directorDTO = directorService.findOneById(id);
            mav.addObject(WebConstant.FORM_ITEM,directorDTO);
        }
        return mav;
    }


    private void executeSearchDirector(DirectorCommand command) {
        List<DirectorDTO> directorDTOS = directorService.findByProperties(command.getSearch(), command.getPage(), command.getLimit(), command.getSortExpression(), command.getSortDirection());
        command.setListResult(directorDTOS);
        command.setTotalItems(directorService.getTotalItem(command.getSearch()));
        command.setTotalPage((int) Math.ceil((double) command.getTotalItems() / command.getLimit()));
    }

    private Map<String, String> getMapMessage() {
        Map<String, String> mapValue = new HashMap<String, String>();
        mapValue.put(WebConstant.REDIRECT_ERROR, bundle.getString("label.message.error"));
        mapValue.put(WebConstant.REDIRECT_INSERT, bundle.getString("label.director.message.add.success"));
        mapValue.put(WebConstant.REDIRECT_DELETE, bundle.getString("label.director.message.delete.success"));
        mapValue.put(WebConstant.REDIRECT_UPDATE, bundle.getString("label.director.message.update.success"));
        return mapValue;
    }
}
