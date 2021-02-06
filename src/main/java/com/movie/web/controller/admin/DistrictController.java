package com.movie.web.controller.admin;

import com.movie.core.dto.DistrictDTO;
import com.movie.core.service.IDistrictService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller(value = "DistrictControllerOfAdmin")
public class DistrictController {
    @Autowired
    private IDistrictService districtService;

    @RequestMapping(value = {"/ajax/district/list"})
    public ModelAndView getDistrictList(@RequestParam("cityId") Long id ) {
        List<DistrictDTO> districtDTOS = districtService.findByCity(id);
        ModelAndView mav = new ModelAndView("/admin/employee/district/list");
        mav.addObject("districts", districtDTOS);
        return mav;
    }
}
