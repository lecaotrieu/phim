package com.movie.web.controller;

import com.google.api.services.drive.Drive;
import com.movie.core.utils.DriveUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

@Controller
public class DisplayImage {
    private Drive googleDrive;

       @GetMapping(value = "/repository/film/{id}")
       public @ResponseBody
       byte[] getImage(@PathVariable("id") String id) throws IOException {
           googleDrive = DriveUtils.getDriveService();
           ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
           googleDrive.files().get(id)
                   .executeMediaAndDownloadTo(outputStream);
           byte[] rs = outputStream.toByteArray();
           return rs;
       }
   /* private final String imagesBase = "/" + CoreConstant.FOLDER_UPLOAD;

    @GetMapping(value = "/repository/{relativeImagePath}")
    public @ResponseBody
    byte[] getImage(@PathVariable("relativeImagePath") String relativeImagePath) throws IOException {
        InputStream fin = new FileInputStream(imagesBase + File.separator + relativeImagePath);
        byte[] rs = IOUtils.toByteArray(fin);
        return rs;
    }*/
}
