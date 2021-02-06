package com.movie.core.service.impl;

import com.google.api.services.drive.model.File;
import com.movie.core.constant.CoreConstant;
import com.movie.core.dto.UserDTO;
import com.movie.core.entity.*;
import com.movie.core.repository.UserRepository;
import com.movie.core.service.IDriveService;
import com.movie.core.service.IUserService;
import com.movie.core.convert.UserConvert;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class UserService implements IUserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserConvert userConvert;

    public List<UserDTO> findByProperties(String search, int page, int limit, String sortExpression, String sortDirection) {
        Sort sort = null;
        search = search.toLowerCase();
        if (sortExpression != null && sortDirection != null) {
            sort = new Sort(sortDirection.equals("1") ? Sort.Direction.ASC : Sort.Direction.DESC, sortExpression);
        }
        Pageable pageable = new PageRequest(page - 1, limit, sort);
        List<UserDTO> userDTOS = new ArrayList<UserDTO>();
        List<UserEntity> userEntities = userRepository.findAllByUserName(search, pageable);
        for (UserEntity entity : userEntities) {
            UserDTO userDTO = userConvert.toDTO(entity);
            userDTOS.add(userDTO);
        }
        return userDTOS;
    }

    public int getTotalItem(String search) {
        return (int) userRepository.countAllByUserName(search.toLowerCase());
    }

    public UserDTO findOneById(Long id) throws Exception {
        UserEntity userEntity = userRepository.findOne(id);
        return userConvert.toDTO(userEntity);
    }

    @Autowired
    private PasswordEncoder passwordEncoder;

    public UserDTO save(UserDTO userDTO) throws Exception {
        boolean check = checkUser(userDTO);
        if (check == false) {
            throw new Exception();
        }
        UserEntity userEntity;
        if (userDTO.getId() != null) {
            userEntity = userRepository.findOne(userDTO.getId());
            userEntity = userConvert.toEntity(userDTO, userEntity);
        } else {
            userEntity = userConvert.toEntity(userDTO);
            userEntity.setPassword(passwordEncoder.encode(userEntity.getPassword()));
        }
        userEntity = userRepository.save(userEntity);
        return userConvert.toDTO(userEntity);
    }

    private boolean checkUser(UserDTO userDTO) {
        Pattern p = Pattern.compile("[^A-Za-z0-9]");
        Matcher m = p.matcher(userDTO.getUserName());
        if (userDTO.getId() == null) {
            if (!userDTO.getPassword().equals(userDTO.getConfirmPassword()) || userDTO.getPassword().length() < 6) {
                return false;
            } else {
                boolean checkPassword = p.matcher(userDTO.getPassword()).find();
                if (checkPassword) {
                    return false;
                }
            }
        }
        if (userDTO.getEmail().contains("@") && !userDTO.getUserName().contains(" ")) {
            if (userDTO.getUserName() == null || userDTO.getUserName().trim().isEmpty()) {
                return false;
            } else {
                boolean checkUserName = m.find();
                if (!checkUserName) {
                    return true;
                } else {
                    return false;
                }
            }
        } else return false;
    }

    public boolean updateUserStatus(UserDTO userDTO) {
        UserEntity userEntity = userRepository.findOne(userDTO.getId());
        userEntity.setStatus(userDTO.getStatus());
        userRepository.save(userEntity);
        return true;
    }

    @Autowired
    private IDriveService driveService;

    public void deleteById(Long[] ids) {
        for (Long id : ids) {
            //xử lý film
            //xử lý thể loại
            UserEntity userEntity = userRepository.findOne(id);
            if (userEntity.getPhoto() != null) {
                try {
                    driveService.deleteFileById(userEntity.getPhoto());
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            userRepository.delete(id);
        }
    }

    public void updatePhoto(Long id, FileItem photo) throws IOException {
        UserEntity userEntity = userRepository.findOne(id);
        if (StringUtils.isNotBlank(userEntity.getPhoto())) {
            try {
                driveService.deleteFileById(userEntity.getPhoto());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        String photoName = "user_avatar_" + id;
        File file = driveService.createGoogleFile(CoreConstant.AVATAR_ADDRESS_ID, photo.getContentType(), photoName, photo.getInputStream());
        driveService.createPublicPermission(file.getId());
        userEntity.setPhoto(file.getId());
        userRepository.save(userEntity);
    }

    public void updatePassword(Long id, String password) throws Exception {
        if (password.length() >= 6) {
            Pattern p = Pattern.compile("[^A-Za-z0-9]");
            Matcher m = p.matcher(password);
            if (m.find()) {
                throw new Exception();
            }
        }
        UserEntity userEntity = userRepository.findOne(id);
        userEntity.setPassword(passwordEncoder.encode(password));
        userRepository.save(userEntity);
    }

    @Override
    public void updatePassword(UserDTO userDTO) throws Exception {
        UserEntity userEntity = userRepository.findOne(userDTO.getId());
        boolean check = checkUpdatePassword(userEntity.getPassword(), userDTO.getPassword(), userDTO.getNewPassword(), userDTO.getConfirmPassword());
        if (check == false) {
            throw new Exception();
        }
        userEntity.setPassword(passwordEncoder.encode(userDTO.getNewPassword()));
        userRepository.save(userEntity);
    }

    @Override
    public String getPhotoId(Long userId) throws Exception {
        String userPhoto = userRepository.findOne(userId).getPhoto();
        return userPhoto;
    }

    private boolean checkUpdatePassword(String userEntityPassword, String password, String newPassword, String confirmPassword) {
        if (passwordEncoder.matches(password, userEntityPassword)) {
            if (newPassword.length() >= 6 && newPassword.equals(confirmPassword)) {
                Pattern p = Pattern.compile("[^A-Za-z0-9]");
                Matcher m = p.matcher(newPassword);
                if (!m.find()) {
                    return true;
                }
            }
        }
        return false;
    }
}
