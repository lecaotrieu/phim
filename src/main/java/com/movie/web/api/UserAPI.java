package com.movie.web.api;

import com.movie.core.dto.UserDTO;
import com.movie.core.service.IUserService;
import com.movie.core.utils.UploadUtil;
import com.movie.web.utils.SecurityUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

@RestController(value = "UserAPIOfAdmin")
public class UserAPI {
    @Autowired
    private IUserService userService;

    @PostMapping("/api/admin/user")
    public UserDTO createUser(@RequestBody UserDTO userDTO) throws Exception {
        return userService.save(userDTO);
    }

    @PostMapping("/api/user/register")
    public UserDTO registerUser(@RequestBody UserDTO userDTO) throws Exception {
        return userService.save(userDTO);
    }

    @PutMapping("/api/admin/user/status")
    public boolean updateUserStatus(@RequestBody UserDTO userDTO) {
        userService.updateUserStatus(userDTO);
        return true;
    }

    @PutMapping("/api/admin/user/password")
    public Long updateUserPassword(@RequestBody UserDTO userDTO) throws Exception {
        userService.updatePassword(userDTO.getId(), userDTO.getPassword());
        return userDTO.getId();
    }

    @PutMapping("/api/user/password")
    public Long updateUserPasswordOfUser(@RequestBody UserDTO userDTO) throws Exception {
        if (SecurityUtils.getUserAuthorities().contains("USER")){
            userDTO.setId(SecurityUtils.getUserPrincipal().getId());
            userService.updatePassword(userDTO);
        }
        return userDTO.getId();
    }


    @PutMapping("/api/user")
    public Long updateUserOfUser(@RequestBody UserDTO userDTO) throws Exception {
        userDTO = userService.save(userDTO);
        return userDTO.getId();
    }

    @PutMapping("/api/admin/user")
    public Long updateUser(@RequestBody UserDTO userDTO) throws Exception {
        userDTO = userService.save(userDTO);
        return userDTO.getId();
    }

    @PostMapping("/api/admin/user/photo")
    public ModelAndView updateUserPhoto(HttpServletRequest request) {
        UploadUtil uploadUtil = new UploadUtil();
        Set<String> titleValue = buildTitleValue();
        Object[] objects = uploadUtil.getFileInputStreams(request, titleValue);
        UserDTO userDTO = new UserDTO();
        userDTO = returnValueOfDTO(userDTO, (Map<String, Object>) objects[1]);
        List<FileItem> fileItems = (List<FileItem>) objects[0];
        ModelAndView mav;
        try {
            if (!fileItems.isEmpty()) {
                userService.updatePhoto(userDTO.getId(), fileItems.get(0));
            }
            mav = new ModelAndView("redirect:/admin/user/photo/edit?id=" + userDTO.getId() + "&message=redirect_update");
        } catch (IOException e) {
            mav = new ModelAndView("redirect:/admin/user/photo/edit?id=" + userDTO.getId() + "&message=redirect_error");
        }
        return mav;
    }

    @PostMapping("/api/user/photo")
    public ModelAndView updatePhotoOfUser(HttpServletRequest request) {
        UploadUtil uploadUtil = new UploadUtil();
        Set<String> titleValue = buildTitleValue();
        Object[] objects = uploadUtil.getFileInputStreams(request, titleValue);
        UserDTO userDTO = new UserDTO();
        userDTO = returnValueOfDTO(userDTO, (Map<String, Object>) objects[1]);
        List<FileItem> fileItems = (List<FileItem>) objects[0];
        ModelAndView mav;
        try {
            if (!fileItems.isEmpty()) {
                userService.updatePhoto(userDTO.getId(), fileItems.get(0));
                SecurityUtils.getUserPrincipal().setPhoto(userService.getPhotoId(SecurityUtils.getUserPrincipal().getId()));
            }
            mav = new ModelAndView("redirect:/chinh-sua-trang-ca-nhan/doi-avatar?change_success");
        } catch (Exception e) {
            mav = new ModelAndView("redirect:/chinh-sua-trang-ca-nhan/doi-avatar?change_error");
        }
        return mav;
    }

    private UserDTO returnValueOfDTO(UserDTO dto, Map<String, Object> mapValue) {
        for (Map.Entry<String, Object> item : mapValue.entrySet()) {
            if (item.getKey().equals("id") && StringUtils.isNotBlank((String) item.getValue())) {
                dto.setId(Long.parseLong(item.getValue().toString()));
            }
        }
        return dto;
    }

    private Set<String> buildTitleValue() {
        Set<String> titleValue = new HashSet<String>();
        titleValue.add("id");
        return titleValue;
    }

    @DeleteMapping("/api/admin/user")
    public void deleteUser(@RequestBody Long[] ids) {
        userService.deleteById(ids);
    }
}
