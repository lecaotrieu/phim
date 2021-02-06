package com.movie.web.controller.admin;

import com.movie.web.command.CategoryCommand;
import com.movie.core.utils.FormUtil;
import com.movie.core.dto.CategoryDTO;
import com.movie.core.service.ICategoryService;
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

@Controller(value = "CategoryControllerOfAdmin")
public class CategoryController {
    ResourceBundle bundle = ResourceBundle.getBundle("ApplicationResource");

    @Autowired
    private ICategoryService categoryService;

    @RequestMapping(value = {"/admin/category/list"}, method = RequestMethod.GET)
    public ModelAndView showCategoryList(@RequestParam(value = "message", required = false) String message,
                                         HttpServletRequest request) {
        if (message != null) {
            WebCommonUtil.addRedirectMessage(request, getMapMessage(), message);
        }
        CategoryCommand command = FormUtil.populate(CategoryCommand.class, request);
        RequestUtil.initSearchBean(request, command);
        executeSearchCategory(command);
        ModelAndView mav = new ModelAndView("admin/category/list");
        mav.addObject(WebConstant.LIST_ITEM, command);
        return mav;
    }

    @RequestMapping(value = {"/ajax/admin/category/edit"}, method = RequestMethod.GET)
    public ModelAndView showCategoryEdit(@ModelAttribute("item") CategoryDTO categoryDTO,
                                         @RequestParam(value = "id", required = false) Long id,
                                         @RequestParam(value = "message", required = false) String message,
                                         HttpServletRequest request) {
        if (message != null) {
            WebCommonUtil.addRedirectMessage(request, getMapMessage(), message);
        }
        ModelAndView mav = new ModelAndView("admin/category/edit");
        if (id != null) {
            categoryDTO = categoryService.findOneById(id);
            mav.addObject(WebConstant.FORM_ITEM,categoryDTO);
        }
        return mav;
    }


    private void executeSearchCategory(CategoryCommand command) {
        List<CategoryDTO> categoryDTOS = categoryService.findByProperties(command.getSearch(), command.getPage(), command.getLimit(), command.getSortExpression(), command.getSortDirection());
        command.setListResult(categoryDTOS);
        command.setTotalItems(categoryService.getTotalItem(command.getSearch()));
        command.setTotalPage((int) Math.ceil((double) command.getTotalItems() / command.getLimit()));
    }

    private Map<String, String> getMapMessage() {
        Map<String, String> mapValue = new HashMap<String, String>();
        mapValue.put(WebConstant.REDIRECT_ERROR, bundle.getString("label.message.error"));
        mapValue.put(WebConstant.REDIRECT_INSERT, bundle.getString("label.category.message.add.success"));
        mapValue.put(WebConstant.REDIRECT_DELETE, bundle.getString("label.category.message.delete.success"));
        mapValue.put(WebConstant.REDIRECT_UPDATE, bundle.getString("label.category.message.update.success"));
        return mapValue;
    }
}
