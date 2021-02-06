package com.movie.web.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller(value = "CountryControllerOfAdmin")
public class CountryController {
    @RequestMapping(value = {"/ajax/country/list"},method = RequestMethod.GET)
    public ModelAndView getCountryList() {
        ModelAndView mav = new ModelAndView();
        return mav;
    }
}
