package com.movie.core.service.impl;

import com.movie.core.constant.CoreConstant;
import com.movie.core.dto.MyEmployee;
import com.movie.core.dto.MyUser;
import com.movie.core.entity.EmployeeEntity;
import com.movie.core.entity.RoleEntity;
import com.movie.core.repository.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.ArrayList;
import java.util.List;

public class CustomEmployeeDetailsService implements UserDetailsService {
    @Autowired
    private EmployeeRepository employeeRepository;

    public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
        EmployeeEntity entity = employeeRepository.findOneByUserNameAndStatus(userName, CoreConstant.ACTIVE_STATUS);
        if (entity == null) {
            throw new UsernameNotFoundException("Employee not found");
        }
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        for (RoleEntity role : entity.getRoles()) {
            authorities.add(new SimpleGrantedAuthority(role.getCode()));
        }

        MyEmployee myEmployee = new MyEmployee(entity.getUserName(), entity.getPassword(), true, true, true, true, authorities);
        myEmployee.setFullName(entity.getFirstName() + " " + entity.getLastName());
        myEmployee.setId(entity.getId());
        return myEmployee;
    }
}
