package com.movie.web.controller.admin;

import com.movie.core.dto.CommuneDTO;
import com.movie.core.service.ICommuneService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller(value = "CommuneControllerOfAdmin")
public class CommuneController {
    @Autowired
    private ICommuneService communeService;

    @RequestMapping(value = "/ajax/commune/list")
    public ModelAndView getCommuneList(@RequestParam("districtId") Long id) {
        ModelAndView mav = new ModelAndView("/admin/employee/commune/list");
        List<CommuneDTO> communeDTOS = communeService.findByDistrict(id);
        mav.addObject("communes", communeDTOS);
        return mav;
    }
}
