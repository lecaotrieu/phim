package com.movie.core.convert;

import com.movie.core.dto.CommentDTO;
import com.movie.core.entity.CommentEntity;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.concurrent.TimeUnit;

@Component
public class CommentConvert {
    @Autowired
    private UserConvert userConvert;

    @Autowired
    private FilmConvert filmConvert;

    public CommentDTO toDTO(CommentEntity entity) {
        CommentDTO dto = new CommentDTO();
        BeanUtils.copyProperties(entity, dto);
        if (entity.getUser() != null) {
            dto.setUser(userConvert.toDTO(entity.getUser()));
        }
        if (entity.getFilm() != null) {
            dto.setFilm(filmConvert.toDTO(entity.getFilm()));
        }
        if (entity.getComment()!=null){
            dto.setComment(toDTO(entity.getComment()));
        }
        Long time = System.currentTimeMillis() - entity.getCreatedDate().getTime();
        if (TimeUnit.HOURS.convert(time, TimeUnit.MILLISECONDS) > 72) {
            DateFormat df = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
            dto.setThoiGianDang(df.format(entity.getCreatedDate()));
        } else if (TimeUnit.HOURS.convert(time, TimeUnit.MILLISECONDS) > 24) {
            dto.setThoiGianDang(TimeUnit.DAYS.convert(time, TimeUnit.MILLISECONDS) + " ngày trước");
        } else if (TimeUnit.MINUTES.convert(time, TimeUnit.MILLISECONDS) > 60) {
            dto.setThoiGianDang(TimeUnit.HOURS.convert(time, TimeUnit.MILLISECONDS) + " giờ trước");
        } else if (TimeUnit.SECONDS.convert(time, TimeUnit.MILLISECONDS) > 60) {
            dto.setThoiGianDang(TimeUnit.MINUTES.convert(time, TimeUnit.MILLISECONDS) + " phút trước");
        } else {
            dto.setThoiGianDang(TimeUnit.SECONDS.convert(time, TimeUnit.MILLISECONDS) + " giây trước");
        }
        return dto;
    }


    public CommentEntity toEntity(CommentDTO dto) {
        CommentEntity entity = new CommentEntity();
        BeanUtils.copyProperties(dto, entity);
        if (dto.getUser() != null) {
            entity.setUser(userConvert.toEntity(dto.getUser()));
        }
        if (dto.getComment()!=null){
            entity.setComment(toEntity(dto.getComment()));
        }
        if (dto.getFilm() != null) {
            entity.setFilm(filmConvert.toEntity(dto.getFilm()));
        }
        return entity;
    }
}
