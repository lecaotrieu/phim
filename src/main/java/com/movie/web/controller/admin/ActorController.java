package com.movie.web.controller.admin;

import com.movie.web.command.ActorCommand;
import com.movie.core.utils.FormUtil;
import com.movie.core.dto.ActorDTO;
import com.movie.core.service.IActorService;
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

@Controller(value = "ActorControllerOfAdmin")
public class ActorController {
    ResourceBundle bundle = ResourceBundle.getBundle("ApplicationResource");

    @Autowired
    private IActorService actorService;

    @RequestMapping(value = {"/admin/actor/list"}, method = RequestMethod.GET)
    public ModelAndView showActorList(@RequestParam(value = "message", required = false) String message,
                                         HttpServletRequest request) {
        if (message != null) {
            WebCommonUtil.addRedirectMessage(request, getMapMessage(), message);
        }
        ActorCommand command = FormUtil.populate(ActorCommand.class, request);
        RequestUtil.initSearchBean(request, command);
        executeSearchActor(command);
        ModelAndView mav = new ModelAndView("admin/actor/list");
        mav.addObject(WebConstant.LIST_ITEM, command);
        return mav;
    }

    @RequestMapping(value = {"/ajax/admin/actor/edit"}, method = RequestMethod.GET)
    public ModelAndView showCategoryEdit(@ModelAttribute("item") ActorDTO actorDTO,
                                         @RequestParam(value = "id", required = false) Long id,
                                         @RequestParam(value = "message", required = false) String message,
                                         HttpServletRequest request) {
        if (message != null) {
            WebCommonUtil.addRedirectMessage(request, getMapMessage(), message);
        }
        ModelAndView mav = new ModelAndView("admin/actor/edit");
        if (id != null) {
            actorDTO = actorService.findOneById(id);
            mav.addObject(WebConstant.FORM_ITEM,actorDTO);
        }
        return mav;
    }


    private void executeSearchActor(ActorCommand command) {
        List<ActorDTO> actorDTOS = actorService.findByProperties(command.getSearch(), command.getPage(), command.getLimit(), command.getSortExpression(), command.getSortDirection());
        command.setListResult(actorDTOS);
        command.setTotalItems(actorService.getTotalItem(command.getSearch()));
        command.setTotalPage((int) Math.ceil((double) command.getTotalItems() / command.getLimit()));
    }

    private Map<String, String> getMapMessage() {
        Map<String, String> mapValue = new HashMap<String, String>();
        mapValue.put(WebConstant.REDIRECT_ERROR, bundle.getString("label.message.error"));
        mapValue.put(WebConstant.REDIRECT_INSERT, bundle.getString("label.actor.message.add.success"));
        mapValue.put(WebConstant.REDIRECT_DELETE, bundle.getString("label.actor.message.delete.success"));
        mapValue.put(WebConstant.REDIRECT_UPDATE, bundle.getString("label.actor.message.update.success"));
        return mapValue;
    }
}
