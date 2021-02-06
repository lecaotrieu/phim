package com.movie.web.interceptor;

import com.movie.core.constant.CoreConstant;
import com.movie.core.constant.WebConstant;
import com.movie.core.dto.CategoryDTO;
import com.movie.core.dto.CountryDTO;
import com.movie.core.dto.FilmDTO;
import com.movie.core.dto.FilmTypeDTO;
import com.movie.core.service.ICategoryService;
import com.movie.core.service.ICountryService;
import com.movie.core.service.IFilmService;
import com.movie.core.service.IFilmTypeService;
import com.movie.web.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class WebHandelInterceptor implements HandlerInterceptor {
    @Autowired
    private ICategoryService categoryService;

    @Autowired
    private ICountryService countryService;

    @Autowired
    private IFilmService filmService;

    @Autowired
    private IFilmTypeService filmTypeService;

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        List<CategoryDTO> categoryDTOS = categoryService.findAll();
        List<CountryDTO> countryDTOS = countryService.findAll();
        List<FilmTypeDTO> filmTypeDTOS = filmTypeService.findAll();
        List<FilmDTO> newFilmHaveTrailer = filmService.findByProperties(true, 1, 8, "modifiedDate", CoreConstant.SORT_DESC);
        List<FilmDTO> seriesFilmHot = filmService.findByProperties("phim-bo", 1, 8, "view", CoreConstant.SORT_DESC);
        if (SecurityUtils.getUserAuthorities().contains("USER")){
            List<FilmDTO> filmFollowed = filmService.findByProperties(SecurityUtils.getUserPrincipal().getId(),1,20);
            request.setAttribute(WebConstant.FILM_FOLLOWED, filmFollowed);
        }
        List<Integer> years = new ArrayList<Integer>();
        int year = Calendar.getInstance().get(Calendar.YEAR);
        for (int i = 0; i < 5; i++) {
            years.add((year));
            year--;
        }
        request.setAttribute(WebConstant.CATEGORY_LIST, categoryDTOS);
        request.setAttribute(WebConstant.COUNTRY_LIST, countryDTOS);
        request.setAttribute(WebConstant.FILM_TYPE_LIST, filmTypeDTOS);
        request.setAttribute(WebConstant.NEW_FILM_HAVE_TRAILER, newFilmHaveTrailer);
        request.setAttribute(WebConstant.SERIES_FILM_HOT, seriesFilmHot);
        request.setAttribute(WebConstant.YEARS, years);
        return true;
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
