package com.movie.web.controller.admin;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller(value = "AccountControllerOfAdmin")
public class AccountController {
    @RequestMapping(value = "/account/login-admin", method = RequestMethod.GET)
    public ModelAndView showLoginPage() {
        ModelAndView mav = new ModelAndView("admin/login");
        return mav;
    }

    @RequestMapping(value = "/account/logout-admin", method = RequestMethod.GET)
    public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return new ModelAndView("redirect:/account/login-admin");
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public ModelAndView logoutOfUser(HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return new ModelAndView("redirect:/dang-nhap");
    }

    @RequestMapping(value = "/accessDenied-admin", method = RequestMethod.GET)
    public ModelAndView accessDeniedOfAdmin() {
        return new ModelAndView("redirect:/account/logout-admin?accessDenied");
    }

    @RequestMapping(value = "/accessDenied-user", method = RequestMethod.GET)
    public ModelAndView accessDeniedOfUser() {
        return new ModelAndView("redirect:/dang-nhap?accessDenied");
    }

}
