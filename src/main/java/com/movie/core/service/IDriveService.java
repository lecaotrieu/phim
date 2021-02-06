package com.movie.core.service;

import com.google.api.services.drive.model.File;
import com.google.api.services.drive.model.Permission;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

public interface IDriveService {
    List<File> getGoogleSubFolders(String googleFolderIdParent) throws IOException;

    File createNewFolder(String folderIdParent, String folderName) throws IOException;

    File createGoogleFile(String googleFolderIdParent, String contentType, String customFileName, java.io.File uploadFile) throws IOException;

    File createGoogleFile(String googleFolderIdParent, String contentType, String customFileName, byte[] uploadData) throws IOException;

    File createGoogleFile(String googleFolderIdParent, String contentType, String customFileName, InputStream inputStream) throws IOException;

    List<File> getSubFoldersByName(String googleFolderIdParent, String subFolderName) throws IOException;

    void deleteFileById(String id) throws IOException;

    Permission createPublicPermission(String googleFileId) throws IOException;

    String getSharableLinkById(String googleFileId) throws IOException;

    File getFileById(String googleFileId) throws IOException;
}
