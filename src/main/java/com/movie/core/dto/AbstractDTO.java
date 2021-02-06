package com.movie.core.dto;

import java.util.Date;

public class AbstractDTO<T> {
    private Long id;
    private Date createdDate;
    private Date modifiedDate;
    private String createdBy;
    private String modifiedBy;

//    private long[] ids;
//    private List<T> listResult = new ArrayList<T>();
//    private Integer page;
//    private Integer limit;
//    private Integer totalPage;
//    private Integer totalItem;
//    private String sortName;
//    private String sortBy;
//    private String type;

    public AbstractDTO() {
    }

    public AbstractDTO(Long id, Date createdDate, Date modifiedDate, String createdBy, String modifiedBy) {
        this.id = id;
        this.createdDate = createdDate;
        this.modifiedDate = modifiedDate;
        this.createdBy = createdBy;
        this.modifiedBy = modifiedBy;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(Date modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public String getModifiedBy() {
        return modifiedBy;
    }

    public void setModifiedBy(String modifiedBy) {
        this.modifiedBy = modifiedBy;
    }
}
