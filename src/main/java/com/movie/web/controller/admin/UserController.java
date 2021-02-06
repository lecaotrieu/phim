package com.movie.web.controller.admin;

import com.movie.web.command.UserCommand;
import com.movie.core.constant.CoreConstant;
import com.movie.core.utils.FormUtil;
import com.movie.core.dto.UserDTO;
import com.movie.core.service.IEvaluateService;
import com.movie.core.service.IUserService;
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

@Controller(value = "UserControllerOfAdmin")
public class UserController {
    ResourceBundle bundle = ResourceBundle.getBundle("ApplicationResource");
    @Autowired
    private IUserService userService;

    @RequestMapping(value = {"/admin/user/list"}, method = RequestMethod.GET)
    public ModelAndView showUserList(HttpServletRequest request) {
        UserCommand command = FormUtil.populate(UserCommand.class, request);
        RequestUtil.initSearchBean(request, command);
        executeSearchUser(command);
        ModelAndView mav = new ModelAndView("admin/user/list");
        if (command.getMessage() != null)
            WebCommonUtil.addRedirectMessage(request, getMapMessage(), command.getMessage());
        mav.addObject(WebConstant.LIST_ITEM, command);
        return mav;
    }

    @RequestMapping(value = {"/admin/user/edit"}, method = RequestMethod.GET)
    public ModelAndView showUserEdit(@ModelAttribute(WebConstant.FORM_ITEM) UserDTO userDTO,
                                     @RequestParam(value = "id", required = false) Long id,
                                     @RequestParam(value = "message", required = false) String message,
                                     HttpServletRequest request) {
        if (message != null) {
            WebCommonUtil.addRedirectMessage(request, getMapMessage(), message);
        }
        ModelAndView mav = new ModelAndView("admin/user/edit");
        if (id != null) {
            try {
                userDTO = userService.findOneById(id);
            } catch (Exception e) {
                mav = new ModelAndView("redirect:/admin/user/list?message=redirect_error");
            }
        }
        mav.addObject(WebConstant.FORM_ITEM, userDTO);
        return mav;
    }

    @RequestMapping(value = "/admin/user/photo/edit", method = RequestMethod.GET)
    public ModelAndView showUserPhotoEdit(@ModelAttribute(WebConstant.FORM_ITEM) UserDTO userDTO,
                                          @RequestParam(value = "id") Long id,
                                          @RequestParam(value = "message", required = false) String message,
                                          HttpServletRequest request) {
        if (message != null) {
            WebCommonUtil.addRedirectMessage(request, getMapMessage(), message);
        }
        ModelAndView mav = new ModelAndView("admin/user/edit_avatar");
        try {
            userDTO = userService.findOneById(id);
        } catch (Exception e) {
            mav = new ModelAndView("redirect:/admin/user/list?message=redirect_error");
        }
        mav.addObject(WebConstant.FORM_ITEM, userDTO);
        return mav;
    }

    @Autowired
    private IEvaluateService evaluateService;

    @RequestMapping(value = "/admin/user/profile", method = RequestMethod.GET)
    public ModelAndView showUserProfile(@RequestParam(value = "id") Long id, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/user/profile");
        UserDTO userDTO;
        try {
            userDTO = userService.findOneById(id);
            userDTO.setEvaluates(evaluateService.findAllByUserId(id, CoreConstant.ACTIVE_STATUS));
            mav.addObject(WebConstant.FORM_ITEM, userDTO);
        } catch (Exception e) {
            mav = new ModelAndView("redirect:/admin/user/list?message=redirect_error");
        }
        return mav;
    }

    private Map<String, String> getMapMessage() {
        Map<String, String> mapValue = new HashMap<String, String>();
        mapValue.put(WebConstant.REDIRECT_ERROR, bundle.getString("label.message.error"));
        mapValue.put(WebConstant.REDIRECT_INSERT, bundle.getString("label.user.message.add.success"));
        mapValue.put(WebConstant.REDIRECT_DELETE, bundle.getString("label.user.message.delete.success"));
        mapValue.put(WebConstant.REDIRECT_UPDATE, bundle.getString("label.user.message.update.success"));
        return mapValue;
    }

    private void executeSearchUser(UserCommand command) {
        if (SecurityUtils.getEmployeeAuthorities().contains(WebConstant.ROLE_ADMIN) || SecurityUtils.getEmployeeAuthorities().contains(WebConstant.ROLE_MANAGER)) {
            List<UserDTO> userDTOS = userService.findByProperties(command.getSearch(), command.getPage(), command.getLimit(), command.getSortExpression(), command.getSortDirection());
            command.setListResult(userDTOS);
            command.setTotalItems(userService.getTotalItem(command.getSearch()));
            command.setTotalPage((int) Math.ceil((double) command.getTotalItems() / command.getLimit()));
        }
    }
}
