package com.movie.web.controller.web;

import com.movie.core.dto.CommentDTO;
import com.movie.core.dto.CommentLikeDTO;
import com.movie.core.service.ICommentLikeService;
import com.movie.core.service.ICommentService;
import com.movie.core.constant.WebConstant;
import com.movie.core.utils.FormUtil;
import com.movie.web.command.CommentCommand;
import com.movie.web.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class CommentController {
    @Autowired
    private ICommentService commentService;

    @Autowired
    private ICommentLikeService commentLikeService;

    @RequestMapping(value = "/ajax/comment/list", method = RequestMethod.GET)
    public ModelAndView loadCommentList(@ModelAttribute CommentCommand command) {
        ModelAndView mav = new ModelAndView("web/comment/list");
        List<CommentDTO> commentDTOS = commentService.findByProperties(command.getFilmId(), command.getPage(), command.getLimit(), "createdDate", command.getSortDirection());
        command.setListResult(commentDTOS);
        if (SecurityUtils.getUserAuthorities().contains("USER")) {
            for (CommentDTO commentDTO : commentDTOS) {
                CommentLikeDTO commentLikeDTO = commentLikeService.findByUserAndComment(SecurityUtils.getUserPrincipal().getId(), commentDTO.getId());
                if (commentLikeDTO != null) {
                    commentDTO.setLike(commentLikeDTO.getStatus());
                }
            }
        }
        mav.addObject(WebConstant.LIST_ITEM, command);
        return mav;
    }

    @RequestMapping(value = "/ajax/comment/edit", method = RequestMethod.GET)
    public ModelAndView loadCommentEdit(@RequestParam("filmId") Long filmId) {
        ModelAndView mav = new ModelAndView("web/comment/edit");
        CommentCommand command = new CommentCommand();
        command.setFilmId(filmId);
        command.setTotalItems(commentService.totalComment(filmId));
        mav.addObject(WebConstant.FORM_ITEM, command);
        return mav;
    }

    @RequestMapping(value = "/ajax/subComment/list", method = RequestMethod.GET)
    public ModelAndView loadSubCommentList(@ModelAttribute CommentCommand command) {
        ModelAndView mav = new ModelAndView("web/comment/subcomment/list");
        List<CommentDTO> commentDTOS = commentService.findByProperties(command.getCommentId(), command.getFilmId(), command.getPage(), command.getLimit(), "createdDate", command.getSortDirection());
        command.setListResult(commentDTOS);
        if (SecurityUtils.getUserAuthorities().contains("USER")) {
            for (CommentDTO commentDTO : commentDTOS) {
                CommentLikeDTO commentLikeDTO = commentLikeService.findByUserAndComment(SecurityUtils.getUserPrincipal().getId(), commentDTO.getId());
                if (commentLikeDTO != null) {
                    commentDTO.setLike(commentLikeDTO.getStatus());
                }
            }
        }
        int totalItem = commentService.totalComment(command.getCommentId(), command.getFilmId());
        int n = totalItem - command.getPage() * command.getLimit();
        if (n > 10) {
            command.setNextCountItem(10);
        } else {
            command.setNextCountItem(n);
        }
        mav.addObject(WebConstant.LIST_ITEM, command);
        return mav;
    }
}
