package com.movie.web.api;

import com.movie.core.dto.DirectorDTO;
import com.movie.core.service.IDirectorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@RestController(value = "DirectorAPI")
public class DirectorAPI {
    @Autowired
    private IDirectorService directorService;

    @PostMapping("/api/admin/director")
    public DirectorDTO saveActor(@RequestBody DirectorDTO directorDTO) {
        try {
            return directorService.save(directorDTO);
        } catch (IOException e) {
            return null;
        }
    }


    @PutMapping("/api/admin/director")
    public DirectorDTO updateDirector(@RequestBody DirectorDTO directorDTO) {
        try {
            directorDTO = directorService.save(directorDTO);
        } catch (IOException ex) {
            return null;
        }
        return directorDTO;
    }

    @DeleteMapping("/api/admin/director")
    public void deleteDirector(@RequestBody Long[] ids) {
        directorService.delete(ids);
    }
}
