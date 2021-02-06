package com.movie.web.interceptor;

import com.movie.core.service.IEpisodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EpisodeHandelInterceptor implements HandlerInterceptor {
    @Autowired
    private IEpisodeService episodeService;

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
       /* boolean check = false;
        if (request.getParameter("id") != null) {
            Long id = Long.parseLong(request.getParameter("id"));
            check = episodeService.checkEmployeeCreate(SecurityUtils.getPrincipal().getUsername(), id);
        }
        return check;*/
        return false;
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
