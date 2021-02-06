package com.movie.web.controller.admin;

import com.movie.core.constant.WebConstant;
import com.movie.core.dto.RoleDTO;
import com.movie.core.service.IRoleService;
import com.movie.core.utils.FormUtil;
import com.movie.core.utils.RequestUtil;
import com.movie.core.utils.WebCommonUtil;
import com.movie.web.command.RoleCommand;
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

@Controller(value = "RoleControllerOfAdmin")
public class RoleController {

    ResourceBundle bundle = ResourceBundle.getBundle("ApplicationResource");

    @Autowired
    private IRoleService roleService;

    @RequestMapping(value = {"/admin/role/list"}, method = RequestMethod.GET)
    public ModelAndView showRoleList(@RequestParam(value = "message", required = false) String message,
                                         HttpServletRequest request) {
        if (message != null) {
            WebCommonUtil.addRedirectMessage(request, getMapMessage(), message);
        }
        RoleCommand command = FormUtil.populate(RoleCommand.class, request);
        RequestUtil.initSearchBean(request, command);
        ModelAndView mav = new ModelAndView("admin/role/list");
        try {
            executeSearchRole(command);
        } catch (Exception e) {
            mav.setViewName("redirect:/admin/role/list?message=redirect_error");
        }
        mav.addObject(WebConstant.LIST_ITEM, command);
        return mav;
    }

    @RequestMapping(value = {"/ajax/admin/role/edit"}, method = RequestMethod.GET)
    public ModelAndView showCategoryEdit(@ModelAttribute("item") RoleDTO roleDTO,
                                         @RequestParam(value = "id", required = false) Long id,
                                         @RequestParam(value = "message", required = false) String message,
                                         HttpServletRequest request) {
        if (message != null) {
            WebCommonUtil.addRedirectMessage(request, getMapMessage(), message);
        }
        ModelAndView mav = new ModelAndView("admin/role/edit");
        if (id != null) {
            try {
                roleDTO = roleService.findOneById(id);
            } catch (Exception e){
                mav.setViewName("redirect:/admin/role/list?message=redirect_error");
            }
            mav.addObject(WebConstant.FORM_ITEM,roleDTO);
        }
        return mav;
    }


    private void executeSearchRole(RoleCommand command) throws Exception {
        List<RoleDTO> roleDTOS = roleService.findByProperties(command.getSearch(), command.getPage(), command.getLimit(), command.getSortExpression(), command.getSortDirection());
        command.setListResult(roleDTOS);
        command.setTotalItems(roleService.getTotalItem(command.getSearch()));
        command.setTotalPage((int) Math.ceil((double) command.getTotalItems() / command.getLimit()));
    }

    private Map<String, String> getMapMessage() {
        Map<String, String> mapValue = new HashMap<String, String>();
        mapValue.put(WebConstant.REDIRECT_ERROR, bundle.getString("label.message.error"));
        mapValue.put(WebConstant.REDIRECT_INSERT, bundle.getString("label.role.message.add.success"));
        mapValue.put(WebConstant.REDIRECT_DELETE, bundle.getString("label.role.message.delete.success"));
        mapValue.put(WebConstant.REDIRECT_UPDATE, bundle.getString("label.role.message.update.success"));
        return mapValue;
    }
}
