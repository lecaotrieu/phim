package com.movie.web.interceptor;

import com.movie.core.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FilmEditHandelInterceptor implements HandlerInterceptor {
    @Autowired
    private ICountryService countryService;
    @Autowired
    private ICategoryService categoryService;
    @Autowired
    private IFilmTypeService filmTypeService;
    @Autowired
    private IDirectorService directorService;
    @Autowired
    private IActorService actorService;

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        request.setAttribute("countries", countryService.findAll());
        request.setAttribute("categories", categoryService.findAll());
        request.setAttribute("filmTypes", filmTypeService.findAll());
        request.setAttribute("directors", directorService.findAll());
        request.setAttribute("actors", actorService.findAll());
        return true;
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
