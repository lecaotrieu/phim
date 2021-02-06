package com.movie.core.service;

import com.movie.core.dto.UserDTO;
import org.apache.commons.fileupload.FileItem;

import java.io.IOException;
import java.util.List;

public interface IUserService {
    List<UserDTO> findByProperties(String search, int page, int limit, String sortExpression, String sortDirection);

    int getTotalItem(String search);

    UserDTO findOneById(Long id) throws Exception;

    UserDTO save(UserDTO userDTO) throws Exception;

    boolean updateUserStatus(UserDTO userDTO);

    void deleteById(Long[] ids);

    void updatePhoto(Long id, FileItem photo) throws IOException;

    void updatePassword(Long id, String password) throws Exception;

    void updatePassword(UserDTO userDTO) throws Exception;

    String getPhotoId(Long userId) throws Exception;

}
