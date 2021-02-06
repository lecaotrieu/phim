package com.movie.web.api;

import com.movie.core.dto.EmployeeDTO;
import com.movie.core.service.IEmployeeService;
import com.movie.core.utils.UploadUtil;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

@RestController(value = "EmployeeAPI")
public class EmployeeAPI {

    @Autowired
    private IEmployeeService employeeService;

    @PostMapping("/api/admin/employee")
    public EmployeeDTO createEmployee(@RequestBody EmployeeDTO employeeDTO) throws Exception {
        return employeeService.save(employeeDTO);
    }

    @PutMapping("/api/admin/employee/status")
    public boolean updateEmployeeStatus(@RequestBody EmployeeDTO employeeDTO) {
        employeeService.updateEmployeeStatus(employeeDTO);
        return true;
    }


    @PutMapping("/api/admin/employee/password")
    public Long updateEmployeePassword(@RequestBody EmployeeDTO employeeDTO) throws Exception {
        employeeService.updatePassword(employeeDTO.getId(), employeeDTO.getPassword());
        return employeeDTO.getId();
    }

    @PutMapping("/api/admin/employee")
    public Long updateEmployee(@RequestBody EmployeeDTO employeeDTO) throws Exception {
        employeeDTO = employeeService.save(employeeDTO);
        return employeeDTO.getId();
    }

    @PostMapping({"/api/admin/employee/photo","/api/admin/personal/photo"})
    public ModelAndView updateEmployeePhoto(HttpServletRequest request) {
        UploadUtil uploadUtil = new UploadUtil();
        Set<String> titleValue = buildTitleValue();
        Object[] objects = uploadUtil.getFileInputStreams(request, titleValue);
        EmployeeDTO employeeDTO = new EmployeeDTO();
        employeeDTO = returnValueOfDTO(employeeDTO, (Map<String, Object>) objects[1]);
        List<FileItem> fileItems = (List<FileItem>) objects[0];
        ModelAndView mav;
        try {
            if (!fileItems.isEmpty()) {
                employeeService.updatePhoto(employeeDTO.getId(), fileItems.get(0));
            }
            if (request.getRequestURL().toString().endsWith("/api/admin/personal/photo")) {
                mav = new ModelAndView("redirect:/admin/personal/photo?message=redirect_update");
            }else {
                mav = new ModelAndView("redirect:/admin/employee/photo/edit?id=" + employeeDTO.getId() + "&message=redirect_update");
            }
        } catch (IOException e) {
            mav = new ModelAndView("redirect:/admin/employee/photo/edit?id=" + employeeDTO.getId() + "&message=redirect_error");
        }
        return mav;
    }

    private EmployeeDTO returnValueOfDTO(EmployeeDTO dto, Map<String, Object> mapValue) {
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

    @DeleteMapping("/api/admin/employee")
    public void deleteEmployee(@RequestBody Long[] ids) {
        employeeService.deleteById(ids);
    }
}
