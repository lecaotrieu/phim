package com.movie.core.repository;

import com.movie.core.entity.EmployeeEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EmployeeRepository extends JpaRepository<EmployeeEntity, Long> {
    @Query("select e from EmployeeEntity e join e.roles r where r.code in ?1 and e.userName like %?2% group by e.userName")
    List<EmployeeEntity> findAllByRolesAndUserName(List<String> roles, String username, Pageable pageable);

    @Query("select count(distinct e.userName) from EmployeeEntity e join e.roles r where r.code in ?1 and e.userName like %?2%")
    long countAllByRolesAndUserName(List<String> roles, String search);

    EmployeeEntity findOneByUserNameAndStatus(String userName, Integer status);
}
