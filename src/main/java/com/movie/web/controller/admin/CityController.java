package com.movie.web.controller.admin;

import com.movie.core.dto.CityDTO;
import com.movie.core.service.ICityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller(value = "CityControllerOfAdmin")
public class CityController {

    @Autowired
    private ICityService cityService;

    @RequestMapping(value = {"/ajax/city/list"}, method = RequestMethod.GET)
    public ModelAndView getCityList(@RequestParam("countryId") Long id) {
        List<CityDTO> cityDTOS = cityService.findByCountry(id);
        ModelAndView mav = new ModelAndView("/admin/employee/city/list");
        mav.addObject("cities", cityDTOS);
        return mav;

    }
}
