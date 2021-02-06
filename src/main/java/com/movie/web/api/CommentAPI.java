package com.movie.web.api;

import com.movie.core.dto.CommentDTO;
import com.movie.core.service.ICommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController(value = "CommentAPIOfWeb")
public class CommentAPI {
    @Autowired
    private ICommentService commentService;
    @PostMapping("/api/film/comment")
    public void saveComment(@RequestBody CommentDTO commentDTO) {
        commentService.save(commentDTO);
    }

    @DeleteMapping("/api/film/comment")
    public void deleteComment(@RequestBody Long[] ids) {
        commentService.deleteComment(ids);
    }
}
