package com.movie.core.repository;

import com.movie.core.entity.UserEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, Long> {
    @Query("select u from UserEntity u where lower(u.userName) like %?1%")
    List<UserEntity> findAllByUserName(String userName, Pageable pageble);

    @Query("select count(distinct u.userName) from UserEntity u where  lower(u.userName) like %?1%")
    long countAllByUserName(String search);

    UserEntity findOneByUserNameAndStatus(String userName, Integer status);

}
