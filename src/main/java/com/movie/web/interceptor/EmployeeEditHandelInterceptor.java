package com.movie.web.interceptor;

import com.movie.core.service.ICountryService;
import com.movie.core.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EmployeeEditHandelInterceptor implements HandlerInterceptor {

    @Autowired
    private ICountryService countryService;

    @Autowired
    private IRoleService roleService;

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        request.setAttribute("countries", countryService.findAll());
        request.setAttribute("roles", roleService.findAllNotAdmin());
        return true;
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
