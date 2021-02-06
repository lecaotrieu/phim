package com.movie.core.service.impl;

import com.movie.core.constant.CoreConstant;
import com.movie.core.dto.MyUser;
import com.movie.core.entity.UserEntity;
import com.movie.core.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.ArrayList;
import java.util.List;

public class CustomUserDetailsService implements UserDetailsService {
    @Autowired
    private UserRepository userRepository;
    public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
        UserEntity entity = userRepository.findOneByUserNameAndStatus(userName, CoreConstant.ACTIVE_STATUS);
        if (entity == null) {
            throw new UsernameNotFoundException("User not found");
        }
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        authorities.add(new SimpleGrantedAuthority("USER"));
        MyUser myUser = new MyUser(entity.getUserName(), entity.getPassword(), true, true, true, true, authorities);
        myUser.setFullName(entity.getFirstName() + " " + entity.getLastName());
        myUser.setId(entity.getId());
        myUser.setPhoto(entity.getPhoto());
        return myUser;
    }
}
