<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <title> - 登录</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link href="${ctx}/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="${ctx}/assets/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="${ctx}/assets/css/animate.css" rel="stylesheet">
    <link href="${ctx}/assets/css/style.css" rel="stylesheet">
    <link href="${ctx}/assets/css/login.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->
    <link rel="shortcut icon" href="${ctx}/assets/img/a8.jpg"> <link href="${ctx}/assets/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${ctx}/assets/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="${ctx}/assets/css/animate.css" rel="stylesheet">
    <link href="${ctx}/assets/css/style.css?v=4.1.0" rel="stylesheet">
    <!-- Sweet Alert -->
    <link href="${ctx}/assets/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <!-- 全局js -->
    <script src="${ctx}/assets/js/jquery.min.js?v=2.1.4"></script>
    <script src="${ctx}/assets/js/bootstrap.min.js?v=3.3.6"></script>
    <script src="${ctx}/assets/js/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script src="${ctx}/assets/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
    <script src="${ctx}/assets/js/plugins/layer/layer.min.js"></script>
    <!-- 自定义js -->
    <script src="${ctx}/assets/js/hanfuLoad.js?v=4.1.0"></script>
    <!-- Sweet alert -->
    <script src="${ctx}/assets/js/plugins/sweetalert/sweetalert.min.js"></script>
    <!-- artTemplate -->
    <script src="${ctx}/assets/js/plugins/artTemplate/template.js"></script>
    <script src="${ctx}/assets/js/namespace.js"></script>
    <script src="${ctx}/assets/js/config.js"></script>
</head>

<body class="signin">
<div class="signinpanel">
    <div class="row">
        <div class="col-sm-12">
            <form method="post" id="loginForm">
                <h4 class="no-margins"></h4>
                <p class="m-t-md"></p>
                <input type="text" name="userName" id="userName" class="form-control uname" placeholder="用户名" />
                <input type="password" name="passWord" id="passWord" class="form-control pword m-b" placeholder="密码" />
                <a href="">忘记密码了？</a>
                <a href="javascript:void(0)" class="btn btn-success btn-block" id="btn-login" tabindex="3">登录</a>
            </form>
        </div>
    </div>
    <div class="signup-footer">
        <div class="pull-left">
            &copy; 旦可韵
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function() {
        var self = null;
        var $userName = $("#userName");
        var $password = $("#passWord");
        var $frame = $("#loginForm");
        var login = {
            init: function() {
                self = this;
                self.bind();
            },
            bind: function() {
                $(document)
                        .on('keyup', '#passWord, #userName', function (e) {
                            if (e.keyCode == 13) {
                                self.postForm();
                            }
                        })
                        .on('click', '#btn-login', function(){
                            self.postForm();
                        })
                        .on('click', '#btn-reset', function(){
                            self.clearForm();
                        })
            },
            clearForm: function() {
                $frame[0].reset();
            },
            postForm: function() {
                if ($userName.val() == "") {
                    swal("提示！", "您用户名不能为空!", "error");
                    return;
                }
                if ($password.val() == "") {
                    swal("提示！", "密码不能为空!", "error");
                    return;
                }
                postAjax($.URL.user.login,{'username':$userName.val(),'password':$password.val()},function(result){console.log(result)
                    if(result.success){//登陆成功
                        swal("提示！", "登陆成功!", "success");
                        window.location.href = "${ctx}/index";
                    }else{
                        swal("提示！",result.msg, "error");
                    }
                });
                return false;
            }
        };
        login.init();
    });
</script>
</body>

</html>
