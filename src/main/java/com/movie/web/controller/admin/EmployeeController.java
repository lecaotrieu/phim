package com.movie.web.controller.admin;

import com.movie.web.command.EmployeeCommand;
import com.movie.core.utils.FormUtil;
import com.movie.core.dto.EmployeeDTO;
import com.movie.core.service.IEmployeeService;
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
import java.util.*;

@Controller(value = "EmployeeControllerOfAdmin")
public class EmployeeController {

    @Autowired
    private IEmployeeService employeeService;

    ResourceBundle bundle = ResourceBundle.getBundle("ApplicationResource");

    @RequestMapping(value = "/admin/employee/list", method = RequestMethod.GET)
    public ModelAndView showEmployeeList(@ModelAttribute(WebConstant.LIST_ITEM) EmployeeCommand command, HttpServletRequest request) {
        command = FormUtil.populate(EmployeeCommand.class, request);
        RequestUtil.initSearchBean(request, command);
        executeSearchEmployee(command);
        ModelAndView mav = new ModelAndView("admin/employee/list");
        if (command.getMessage() != null) {
            WebCommonUtil.addRedirectMessage(request, getMapMessage(), command.getMessage());
        }
        mav.addObject(WebConstant.LIST_ITEM, command);
        return mav;
    }

    @RequestMapping(value = {"/admin/employee/edit", "/admin/personal/information"}, method = RequestMethod.GET)
    public ModelAndView showEmployeeEdit(@ModelAttribute(WebConstant.FORM_ITEM) EmployeeDTO employeeDTO,
                                         @RequestParam(value = "id", required = false) Long id,
                                         @RequestParam(value = "message", required = false) String message,
                                         HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/employee/edit");
        if (message != null) {
            WebCommonUtil.addRedirectMessage(request, getMapMessage(), message);
        }
        if (SecurityUtils.getEmployeeAuthorities().contains(WebConstant.ROLE_ADMIN)) {
            if (id != null) {
                employeeDTO = employeeService.findOneById(id);
            } else if (request.getRequestURL().toString().endsWith("/admin/personal/information")) {
                employeeDTO = employeeService.findOneById(SecurityUtils.getPrincipal().getId());
            }
        } else {
            if (id != null) {
                mav = new ModelAndView("redirect:/admin/personal/information");
            } else {
                employeeDTO = employeeService.findOneById(SecurityUtils.getPrincipal().getId());
            }
        }
        mav.addObject(WebConstant.FORM_ITEM, employeeDTO);
        return mav;
    }

    @RequestMapping(value = {"/admin/employee/photo/edit"}, method = RequestMethod.GET)
    public ModelAndView showEmployeePhotoEdit(@ModelAttribute(WebConstant.FORM_ITEM) EmployeeDTO employeeDTO,
                                              @RequestParam(value = "id") Long id,
                                              @RequestParam(value = "message", required = false) String message,
                                              HttpServletRequest request) {
        if (message != null) {
            WebCommonUtil.addRedirectMessage(request, getMapMessage(), message);
        }
        employeeDTO = employeeService.findOneById(id);
        ModelAndView mav = new ModelAndView("admin/employee/edit_avatar");
        mav.addObject(WebConstant.FORM_ITEM, employeeDTO);
        return mav;
    }

    @RequestMapping(value = {"/admin/employee/profile"}, method = RequestMethod.GET)
    public ModelAndView showEmployeeProfile(@RequestParam(value = "id") Long id,
                                              @RequestParam(value = "message", required = false) String message,
                                              HttpServletRequest request) {
        EmployeeDTO employeeDTO;
        if (message != null) {
            WebCommonUtil.addRedirectMessage(request, getMapMessage(), message);
        }
        employeeDTO = employeeService.findOneById(id);
        ModelAndView mav = new ModelAndView("admin/employee/profile");
        mav.addObject(WebConstant.FORM_ITEM, employeeDTO);
        return mav;
    }

    @RequestMapping(value = {"/admin/personal/photo"}, method = RequestMethod.GET)
    public ModelAndView showPersonalPhoto(@ModelAttribute(WebConstant.FORM_ITEM) EmployeeDTO employeeDTO,
                                              @RequestParam(value = "message", required = false) String message,
                                              HttpServletRequest request) {
        if (message != null) {
            WebCommonUtil.addRedirectMessage(request, getMapMessage(), message);
        }
        employeeDTO = employeeService.findOneById(SecurityUtils.getPrincipal().getId());
        ModelAndView mav = new ModelAndView("admin/employee/edit_avatar");
        mav.addObject(WebConstant.FORM_ITEM, employeeDTO);
        return mav;
    }


    public void executeSearchEmployee(EmployeeCommand command) {
        if (SecurityUtils.getEmployeeAuthorities().contains("ADMIN")) {
            List<String> roleCodes = new ArrayList<String>();
            if (command.getRole() != null && !command.getRole().equals("ADMIN") ) {
                roleCodes.add(command.getRole());
            } else {
                roleCodes.add(WebConstant.ROLE_MANAGER);
                roleCodes.add(WebConstant.ROLE_POSTER);
            }
            List<EmployeeDTO> employeeDTOS = employeeService.findByProperties(command.getSearch(), roleCodes,
                    command.getPage(), command.getLimit(), command.getSortExpression(), command.getSortDirection());
            command.setListResult(employeeDTOS);
            command.setTotalItems(employeeService.getTotalItem(roleCodes, command.getSearch()));
            command.setTotalPage((int) Math.ceil((double) command.getTotalItems() / command.getLimit()));
        }
    }

    private Map<String, String> getMapMessage() {
        Map<String, String> mapValue = new HashMap<String, String>();
        mapValue.put(WebConstant.REDIRECT_ERROR, bundle.getString("label.message.error"));
        mapValue.put(WebConstant.REDIRECT_INSERT, bundle.getString("label.employee.message.add.success"));
        mapValue.put(WebConstant.REDIRECT_DELETE, bundle.getString("label.employee.message.delete.success"));
        mapValue.put(WebConstant.REDIRECT_UPDATE, bundle.getString("label.employee.message.update.success"));
        return mapValue;
    }
}
