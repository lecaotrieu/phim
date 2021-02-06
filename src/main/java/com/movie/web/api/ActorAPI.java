package com.movie.web.api;

import com.movie.core.dto.ActorDTO;
import com.movie.core.service.IActorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@RestController(value = "ActorAPI")
public class ActorAPI {
    @Autowired
    private IActorService actorService;

    @PostMapping("/api/admin/actor")
    public ActorDTO saveActor(@RequestBody ActorDTO actorDTO) {
        try {
            actorDTO = actorService.save(actorDTO);
        } catch (IOException ex) {
            return null;
        }
        return actorDTO;
    }

    @PutMapping("/api/admin/actor")
    public ActorDTO updateActor(@RequestBody ActorDTO actorDTO) {
        try {
            actorDTO = actorService.save(actorDTO);
        } catch (IOException ex) {
            return null;
        }
        return actorDTO;
    }

    @DeleteMapping("/api/admin/actor")
    public void deleteActor(@RequestBody Long[] ids) {
        actorService.delete(ids);
    }
}
