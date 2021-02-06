package com.movie.web.controller.web;

import com.movie.core.constant.CoreConstant;
import com.movie.core.dto.FilmDTO;
import com.movie.core.dto.GoogleDTO;
import com.movie.core.dto.MyUser;
import com.movie.core.service.IFilmService;
import com.movie.core.constant.WebConstant;
import com.movie.core.utils.GoogleUtils;
import com.movie.core.utils.RestFB;
import org.apache.http.client.ClientProtocolException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Controller(value = "HomeControllerOfWeb")
public class HomeController {
    @Autowired
    private IFilmService filmService;
    @Autowired
    private GoogleUtils googleUtils;

    @RequestMapping(value = "/trang-chu", method = RequestMethod.GET)
    public ModelAndView homePage() {
        List<FilmDTO> filmNominates = filmService.findByProperties(1, 3, "view", CoreConstant.SORT_ASC);
        List<FilmDTO> movieNewUpdate = filmService.findByProperties("phim-chieu-rap", 1, 8, "createdDate", CoreConstant.SORT_DESC);
        List<FilmDTO> oddFilmNewUpdate = filmService.findByProperties("phim-le", 1, 8, "modifiedDate", CoreConstant.SORT_DESC);
        ModelAndView mav = new ModelAndView("web/home");
        mav.addObject(WebConstant.FILM_NOMINATE, filmNominates);
        mav.addObject(WebConstant.FILM_CHIEU_RAP, movieNewUpdate);
        mav.addObject(WebConstant.ODD_FILM_NEW_UPDATE, oddFilmNewUpdate);
        return mav;
    }

    @RequestMapping(value = "/dang-nhap", method = RequestMethod.GET)
    public ModelAndView homeLoginPage(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("web/login");
        return mav;
    }

    @RequestMapping(value = "/dang-ky", method = RequestMethod.GET)
    public ModelAndView homeRegisterPage(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("web/register");
        return mav;
    }

    @RequestMapping(value = "/dang-nhap/google", method = RequestMethod.GET)
    public ModelAndView loginPageByGoogle(HttpServletRequest request) throws ClientProtocolException, IOException {
        String code = request.getParameter("code");

        if (code == null || code.isEmpty()) {
            new ModelAndView("redirect:/dang-nhap?message=google_error");
        }
        String accessToken = googleUtils.getToken(code);

        GoogleDTO googleDTO = googleUtils.getUserInfo(accessToken);
        UserDetails userDetail = googleUtils.buildUser(googleDTO);
        MyUser myUser = new MyUser(userDetail.getUsername(), userDetail.getPassword(), true, true, true, true, userDetail.getAuthorities());
        myUser.setPhoto(googleDTO.getPicture());
        UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(myUser, null,
                userDetail.getAuthorities());
        authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        return new ModelAndView("redirect:/trang-chu");
    }

    @Autowired
    private RestFB restFB;

    @RequestMapping("/AccessFacebook/login-facebook")
    public String loginFacebook(HttpServletRequest request) {
        String code = request.getParameter("code");
        String accessToken = "";
        try {
            accessToken = restFB.getToken(code);
        } catch (IOException e) {
            return "redirect:/dang-nhap?facebook=error";
        }
        com.restfb.types.User user = restFB.getUserInfo(accessToken);
        UserDetails userDetail = restFB.buildUser(user);
        UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(userDetail, null,
                userDetail.getAuthorities());
        authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        return "redirect:/trang-chu";
    }
}
