package com.wonpera.student.common.bean;


import com.wonpera.student.common.base.BaseParameter;

import java.util.Date;

public class Menu extends BaseParameter {
    private Long id;

    private Long menuid;

    private String menuname;

    private String linkurl;

    private String icon;

    private Long parentmenuid;

    private Long orderclomun;

    private Date createtime;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getMenuid() {
        return menuid;
    }

    public void setMenuid(Long menuid) {
        this.menuid = menuid;
    }

    public String getMenuname() {
        return menuname;
    }

    public void setMenuname(String menuname) {
        this.menuname = menuname == null ? null : menuname.trim();
    }

    public String getLinkurl() {
        return linkurl;
    }

    public void setLinkurl(String linkurl) {
        this.linkurl = linkurl == null ? null : linkurl.trim();
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon == null ? null : icon.trim();
    }

    public Long getParentmenuid() {
        return parentmenuid;
    }

    public void setParentmenuid(Long parentmenuid) {
        this.parentmenuid = parentmenuid;
    }

    public Long getOrderclomun() {
        return orderclomun;
    }

    public void setOrderclomun(Long orderclomun) {
        this.orderclomun = orderclomun;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }
}