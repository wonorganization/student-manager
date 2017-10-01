package com.wonpera.student.common.response;

import java.io.Serializable;
import java.util.List;

/**
 * Created by wangpeng on 2016/11/4.
 */
public class MenuView implements Serializable {

    private static final long serialVersionUID = 1L;
    private Long id;
    private Long menuid;

    private String menuname;

    private String linkurl;

    private String icon;

    private Long parentmenuid;

    private Long orderclomun;

    private List<MenuView> children;

    private boolean checked;

    private boolean hasChildren = false;


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
        this.menuname = menuname;
    }

    public String getLinkurl() {
        return linkurl;
    }

    public void setLinkurl(String linkurl) {
        this.linkurl = linkurl;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
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

    public List<MenuView> getChildren() {
        return children;
    }

    public void setChildren(List<MenuView> children) {
        this.hasChildren = true;
        this.children = children;
    }

    public boolean isChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }

    public boolean isHasChildren() {
        return hasChildren;
    }

    public void setHasChildren(boolean hasChildren) {
        this.hasChildren = hasChildren;
    }
}
