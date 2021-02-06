package com.movie.web.interceptor;

import com.movie.core.service.IFilmService;
import com.movie.web.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FilmHandelInterceptor implements HandlerInterceptor {
    @Autowired
    private IFilmService filmService;

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String idParameter = request.getParameter("id");
        boolean check = true;
        if (idParameter != null) {
            Long id = Long.parseLong(idParameter);
            if (SecurityUtils.getEmployeeAuthorities().contains("ADMIN")) {
                check = true;
            } else if (SecurityUtils.getEmployeeAuthorities().contains("POSTER")) {
                check = filmService.checkPosterFilm(id, SecurityUtils.getPrincipal().getUsername());
            } else {
                return false;
            }
        }
        return check;
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
