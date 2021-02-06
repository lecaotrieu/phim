package com.movie.web.controller.admin;

import com.movie.core.constant.WebConstant;
import com.movie.core.dto.CommentDTO;
import com.movie.core.dto.CommentLikeDTO;
import com.movie.core.service.ICommentLikeService;
import com.movie.core.service.ICommentService;
import com.movie.core.utils.FormUtil;
import com.movie.web.command.CommentCommand;
import com.movie.web.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller(value = "CommentControllerOfAdmin")
public class CommentController {
    @Autowired
    private ICommentService commentService;

    @Autowired
    private ICommentLikeService commentLikeService;

    @RequestMapping(value = "/ajax/admin/comment/list", method = RequestMethod.GET)
    public ModelAndView loadCommentList(@ModelAttribute CommentCommand command) {
        ModelAndView mav = new ModelAndView("admin/comment/list");
        List<CommentDTO> commentDTOS = commentService.findByProperties(command.getFilmId(), command.getPage(), command.getLimit(), "createdDate", command.getSortDirection());
        command.setListResult(commentDTOS);
        for (CommentDTO commentDTO : commentDTOS) {
            commentDTO.setTotalLike(commentLikeService.totalCommentLike(commentDTO.getId()));
        }
        command.setTotalItems(commentService.totalComment(command.getFilmId()));
        mav.addObject(WebConstant.LIST_ITEM, command);
        command.setTotalPage((int) Math.ceil((double)command.getTotalItems() / command.getLimit()));
        return mav;
    }

    @RequestMapping(value = "/ajax/admin/comment/edit", method = RequestMethod.GET)
    public ModelAndView loadCommentEdit(@RequestParam("filmId") Long filmId) {
        ModelAndView mav = new ModelAndView("admin/comment/edit");
        CommentCommand command = new CommentCommand();
        command.setFilmId(filmId);
        command.setTotalItems(commentService.totalComment(filmId));
        mav.addObject(WebConstant.FORM_ITEM, command);
        return mav;
    }

    @RequestMapping(value = "/ajax/admin/subComment/list", method = RequestMethod.GET)
    public ModelAndView loadSubCommentList(@ModelAttribute CommentCommand command) {
        ModelAndView mav = new ModelAndView("admin/comment/subcomment/list");
        List<CommentDTO> commentDTOS = commentService.findByProperties(command.getCommentId(), command.getFilmId(), command.getPage(), command.getLimit(), "createdDate", command.getSortDirection());
        command.setListResult(commentDTOS);
        for (CommentDTO commentDTO : commentDTOS) {
            commentDTO.setTotalLike(commentLikeService.totalCommentLike(commentDTO.getId()));
        }
        command.setTotalItems(commentService.totalComment(command.getFilmId()));
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
