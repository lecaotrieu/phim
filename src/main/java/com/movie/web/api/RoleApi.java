package com.movie.web.api;

import com.movie.core.dto.RoleDTO;
import com.movie.core.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController(value = "RoleApi")
public class RoleApi {
    @Autowired
    private IRoleService roleService;

    @PostMapping("/api/admin/role")
    public Long saveRole(@RequestBody RoleDTO roleDTO) throws Exception {
        return roleService.save(roleDTO);
    }


    @PutMapping("/api/admin/role")
    public Long updateRole(@RequestBody RoleDTO roleDTO) throws Exception{
        return roleService.save(roleDTO);
    }

    @DeleteMapping("/api/admin/role")
    public void deleteRole(@RequestBody Long[] ids) throws Exception {
        roleService.delete(ids);
    }
}
