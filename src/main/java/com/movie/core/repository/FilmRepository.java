package com.movie.core.repository;

import com.movie.core.entity.FilmEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface FilmRepository extends JpaRepository<FilmEntity, Long> {
    @Query("select f from FilmEntity f where f.employee.userName=?1 and (lower(f.name) like %?2% or lower(f.code) like %?2%) and f.status=?3")
    List<FilmEntity> findAllByEmployee_UserNameAndNameOrCodeAndStatus(String userName, String search, Integer status, Pageable pageable);

    List<FilmEntity> findAllByStatus(Integer status, Pageable pageable);


    List<FilmEntity> findAllByStatusAndFilmType_Code(Integer status, String filmTypeCode, Pageable pageable);

    @Query("select f from FilmEntity f where f.status=?1 and f.episodes.size = 0 and f.trailer <> 'null'")
    List<FilmEntity> findAllByStatusAndTrailerNotNull(Integer status, Pageable pageable);

    @Query("select distinct f from FilmEntity f  join f.evaluates e  where f.status=?2 and e.user.id = ?1 and e.follow=1")
    List<FilmEntity> findAllByUserFollow(Long userId, Integer status, Pageable pageable);

    @Query("select f from FilmEntity f where (lower(f.name) like %?1% or lower(f.code) like %?2%)")
    List<FilmEntity> findAllByNameContainingOrCodeContaining(String name, String code, Pageable pageable);

    @Query("select count(f.id) from FilmEntity f where f.employee.userName=?1 and (lower(f.name) like %?2% or lower(f.code) like %?2%) and f.status=?3")
    long countAllByEmployee_UserNameAndNameOrCodeAndStatus(String userName, String search, Integer status);

    @Query("select count(f.id) from FilmEntity f where (lower(f.name) like %?1% or lower(f.code) like %?2%)")
    long countAllByNameContainingOrCodeContaining(String name, String code);

    long countAllByIdAndEmployee_UserNameAndStatus(Long id, String username, Integer status);

    FilmEntity findOneByCode(String code);

    FilmEntity findOneByIdAndStatus(Long id, Integer status);

    FilmEntity findOneByIdAndCreatedByAndStatus(Long id, String poster, Integer status);

    FilmEntity findOneByIdAndCodeAndStatus(Long id, String code, Integer status);

    @Query("select distinct f from FilmEntity f join f.categories c where (lower(f.name) like %?1% or lower(f.code) like %?1%) and f.filmType.code like %?2% and f.country.code like %?4% and f.year like %?5% and c.code like %?3%")
    List<FilmEntity> findAllByProperties(String search, String filmType, String category, String country, String year, Pageable pageable);

    @Query("select count(distinct f.id) from FilmEntity f join f.categories c where (lower(f.name) like %?1% or lower(f.code) like %?1%) and f.filmType.code like %?2% and f.country.code like %?4% and f.year like %?5% and c.code like %?3%")
    long countAllByProperties(String search, String filmType, String category, String country, String year);
}
