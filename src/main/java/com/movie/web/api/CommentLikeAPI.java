package com.movie.web.api;

import com.movie.core.dto.CommentLikeDTO;
import com.movie.core.service.ICommentLikeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController(value = "CommentLike")
public class CommentLikeAPI {
    @Autowired
    private ICommentLikeService commentLikeService;
    @PostMapping("/api/film/comment/like")
    public void saveCommentLike(@RequestBody CommentLikeDTO dto) {
        commentLikeService.save(dto);
    }
}
