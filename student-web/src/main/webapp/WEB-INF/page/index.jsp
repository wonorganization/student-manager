<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">
    <title>旦可韵</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <!--[if lt IE 9]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->
    <jsp:include page="include.jsp"></jsp:include>

</head>


<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
    <div id="wrapper"></div>
</body>

<script type="text/javascript">
    $(function(){
        var list;
        var userName;
        postAsync($.URL.index.menu,{},function(result){list = result.data;});//加载菜单信息
        postAsync($.URL.index.getSessionUser,{},function(result){userName = result.data.username;});//加载用户信息
        loadMenu(list,userName);
    });

    function logout(){
        postAjax($.URL.index.logout,{},function(result){if(result.success){window.location.href="${ctx}/login";}});
    }

    function loadMenu(list,userName){
        var html = template('menu_tmplate',{list:list,userName:userName});
        $('#wrapper').append(html);
        loadLayout();
        loadHref();
    }
</script>



<script id="menu_tmplate" type="text/html">
    <!--左侧导航开始-->
    <nav class="navbar-default navbar-static-side" role="navigation">
        <div class="nav-close"><i class="fa fa-times-circle"></i>
        </div>
        <div class="sidebar-collapse">
            <ul class="nav" id="side-menu">
                <li class="nav-header">
                    <div class="dropdown profile-element">
                        <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                <span class="clear">
                                    <span class="block m-t-xs" style="font-size:20px;">
                                        <i class="fa fa-area-chart"></i>
                                        <strong class="font-bold">旦可韵</strong>
                                    </span>
                                </span>
                        </a>
                    </div>
                    <div class="logo-element">旦可韵
                    </div>
                </li>
                <li class="line dk"></li>
                <li class="hidden-folded padder m-t m-b-sm text-muted text-xs">
                    <span class="ng-scope">导航栏</span>
                </li>
                {{each list as value index}}
                <li>
                    <a href="#"><i class="{{value.icon}}"></i> <span class="nav-label">{{value.menuname}}</span><span class="fa arrow"></span></a>
                    {{if value.hasChildren}}
                    <ul class="nav nav-second-level">
                        {{each value.children as children i}}
                        <li><a class="J_menuItem" href="{{children.linkurl}}">{{children.menuname}}</a></li>
                        {{/each}}
                    </ul>
                    {{/if}}
                </li>
                {{/each}}
            </ul>
        </div>
    </nav>
    <!--左侧导航结束-->
    <!--右侧部分开始-->
    <div id="page-wrapper" class="gray-bg dashbard-1">
        <div class="row border-bottom">
            <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                <div class="navbar-header"><a class="navbar-minimalize minimalize-styl-2 btn btn-info " href="#"><i class="fa fa-bars"></i> </a>
                    <h1 align="center"><i>欢迎使用旦可韵后台管理系统</i></h1>
                </div>
                <ul class="nav navbar-top-links navbar-right">
                    <li class="dropdown">
                        <a data-toggle="dropdown" href="#" class="dropdown-toggle">
								<span class="user-info">
                                        <small>Welcome,</small>
                                        {{userName}}
								</span>

                            <i class="icon-caret-down"></i>
                        </a>

                        <ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
                            <li class="divider"></li>
                            <li>
                                <a href="javascript:logout();">
                                    <i class="icon-off"></i>
                                    Logout
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </nav>
        </div>
        <div class="row J_mainContent" id="content-main">
            <iframe id="J_iframe" width="100%" height="100%" src="${ctx}/center" frameborder="0" data-id="center.html" seamless></iframe>
        </div>
    </div>
    <!--右侧部分结束-->
    </div>
</script>

</html>
