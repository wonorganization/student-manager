<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> - jqGird</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link rel="shortcut icon" href="favicon.ico">
    <style>
        #alertmod_table_list_2 {
            top: 900px !important;
        }
    </style>
    <jsp:include page="../include.jsp"></jsp:include>
</head>

<body class="gray-bg">
<div class="wrapper wrapper-content  animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox ">
                <div class="ibox-title">
                    <h5>季节管理</h5>
                </div>
                <div class="ibox-content">
                    <form role="form" class="form-inline" id="searchForm">
                        <div class="form-group">
                            <label>季节名称:</label>
                            <input type="text" name="name" class="form-control">
                        </div>&nbsp;&nbsp;&nbsp;&nbsp;
                        <div class="form-group">
                            <label>季节代码:</label>
                            <select name="type" class="form-control">
                                <option value="">---请选择---</option>
                                <option value="1">产品</option>
                                <option value="2">show</option>
                            </select>
                        </div>&nbsp;&nbsp;&nbsp;&nbsp;
                        <button type="button" class="btn btn-w-m btn-primary" id="searchBth" >查询</button>
                        <button type="button" class="btn btn-w-m btn-success" id="resetBtn">重置</button>
                    </form>
                </div>
                <div class="ibox-content">
                    <button type="button" class="btn btn-w-m btn-success" id="addBtn">新增</button>
                </div>
                <div class="ibox-content">
                    <!-- <h4>用户列表</h4> -->
                    <div class="jqGrid_wrapper">
                        <table id="table_list"></table>
                        <div id="pager_list"></div>
                    </div>
                    <p>&nbsp;</p>
                </div>
            </div>
        </div>
    </div>
</div>



<div id="add-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-info">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">
                    <i class="icon-pencil"></i>
                    <span  style="font-weight:bold">季节新增</span>
                </h4>
            </div>
            <form class="form-horizontal form-bordered form-row-strippe" id="addForm" action="" data-toggle="validator">
                <div class="modal-body" id="add-data">

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm" data-dismiss="modal">取消</button>
                    <button type="button" id="save-btn" class="btn btn-sm btn-success">确定</button>
                </div>
            </form>
        </div>
    </div>
</div>


<div id="upd-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-info">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">
                    <i class="icon-pencil"></i>
                    <span  style="font-weight:bold">季节修改</span>
                </h4>
            </div>
            <form class="form-horizontal form-bordered form-row-strippe" id="updForm" action="" data-toggle="validator">
                <div class="modal-body" id="upd-data">

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm" data-dismiss="modal">取消</button>
                    <button type="button" id="upd-btn" class="btn btn-sm btn-success">确定</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Page-Level Scripts -->
<script>
    var seasons = {};//
    var types = {};//
    var seasonList;
    var typeList;
    var products;
    $(document).ready(function () {
        seasonList = getDicJsonData('${ctx}/','season');
        seasons = dicJsonToObj(seasonList);
        $.jgrid.defaults.styleUI = 'Bootstrap';
        $("#table_list").jqGrid({
            datatype: "json",
            url: '${ctx}/season/page',
            mtype : 'POST',
            height: 300,
            autowidth: true,
            shrinkToFit: true,
            rowNum: 14,
            rowList: [10, 20, 30],
            colNames: ['id', '季节名称','季节类型','创建时间', '操作'],
            colModel: [
                {
                    name: 'id',
                    index: 'id',
                    width: 60,
                    sorttype: "int"
                },
                {
                    name: 'name',
                    index: 'name',
                    width: 90
                },
                {
                    name:'type',
                    index:'type',
                    width : 100,
                    formatter: function(cellvalue, options, rowObject){
                        if(cellvalue == '1'){
                            return '产品';
                        }else{
                            return 'show';
                        }
                    }
                },
                {
                    name: 'createtime',
                    index: 'createtime',
                    width: 150
                },
                {
                    name: 'id',
                    index: 'id',
                    width: 200,
                    sortable: false,
                    formatter: function(cellvalue, options, rowObject){
                        var html = '<button class="btn btn-info" name="edit-btn" onClick="goUpdate('+cellvalue+')" data-key="'+cellvalue+'" type="button"><i class="fa fa-paste"></i> 编辑</button>&nbsp;&nbsp;';
                        /*html += '<button class="btn btn-warning" onClick="deleteRow('+cellvalue+')"  type="button"><i class="fa fa-warning"></i> <span class="bold">删除</span> </button>';*/
                        return html;
                    }
                }
            ],
            pager: "#pager_list",
            viewrecords: true,
            hidegrid: false,
            jsonReader :{
                root: "result",    // json中代表实际模型数据的入口
                page: "pageNum",    // json中代表当前页码的数据
                total: "pages",    // json中代表页码总数的数据
                records: "total", // json中代表数据行总数的数据
                repeatitems: false
            },
            multiselect : true,
            autowidth: true,
            sortname: 'id',
            viewrecords: true,
            sortorder: "desc"
        });



        $('#addBtn').bind('click',function(){
            $('#add-data').html(template('add-tmpl',{
            }));
            $("#add-modal").modal({backdrop: 'static', keyboard: false});
        });


        $('#save-btn').bind('click',function(){
            save();
        });

        $('#searchBth').bind('click',function(){
            search();
        });

        $('#resetBtn').bind('click',function(){
            $('#searchForm')[0].reset();
        });

        $('#upd-btn').bind('click',function(){
            update();
        });



    });

   

    function goUpdate(id){
        var data;
        postAsync('${ctx}/season/getSeasonById',{'id':id},function(result){data=result.data});
        $('#upd-data').html(template('upd-tmpl',{
                'data':data
            }));
        $("#upd-modal").modal({backdrop: 'static', keyboard: false});
    }

    function update(){
        var param = {};
        $('#updForm .form-control').each(function(){
            var name = $(this).attr('name');
            var value = $(this).val();
            param[name] = value;
        });
        if(!validate(param)){
            return;
        }
        postAjax('${ctx}/season/update',param,function(result){
            if(result.success){
                $("#table_list").trigger("reloadGrid");
                swal("提示！", "修改成功!", "success");
                $("#upd-modal").modal("hide");
            }else{
                swal("提示！", result.msg, "error");
            }
        });
    }





    function search(){
        var param = {};
        $('#searchForm .form-control').each(function(){
            var name = $(this).attr('name');
            var value = $(this).val();
            param[name] = value;
        });
        $('#table_list').jqGrid('setGridParam',{
            postData : param,
            //查询重载第一页
            page : 1
        }).trigger("reloadGrid"); //重新载入
    }


    function save(){
        var param = {};
        $('#addForm .form-control').each(function(){
            var name = $(this).attr('name');
            var value = $(this).val();
            param[name] = value;
        });
        if(!validate(param)){
            return;
        }
        postAjax('${ctx}/season/add',param,function(result){
            if(result.success){
                $("#table_list").trigger("reloadGrid");
                swal("提示！", "新增成功!", "success");
                $("#add-modal").modal("hide");
            }else{
                swal("提示！", result.msg, "error");
            }
        });

    }


   /* function deleteRow(id){
        swal({
            title:"",
            text:"确定删除吗？",
            type:"warning",
            showCancelButton:"true",
            showConfirmButton:"true",
            confirmButtonText:"确定",
            cancelButtonText:"取消",
            animation:"slide-from-top"
        }, function() {
            postAjax('${ctx}/productImg/delete',{'id':id},function(result){
                if(result.success){
                    $("#table_list").trigger("reloadGrid");
                    swal("操作成功!", "已成功删除数据！", "success");
                }else{
                    swal("提示信息", "删除失败", "error");
                }
            });
        });
    }
*/

    function validate(param){
        if (!param['name']) {
            swal("提示信息", "季节名称不能为空", "error");
            return false;
        }
        if (!param['type']) {
            swal("提示信息", "季节代码不能为空", "error");
            return false;
        }
        return true;
    }
</script>
</body>



<!-- script templcate -->
<script id="add-tmpl" type="text/html">
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label class="control-label col-md-2">季节名称:</label>
                <div class="col-md-10">
                <input type="text" name="name" class="form-control" placeholder="季节名称">
                </div>
            </div>
			<div class="form-group">
                <label class="control-label col-md-2">季节类型:</label>
                <div class="col-md-10">
                <select name="type" class="form-control" >
                    <option value="">---请选择---</option>
                    <option value="1">产品</option>
                    <option value="2">show</option>
                </select>
                </div>
            </div>
        </div>
    </div>
</script>


<script id="upd-tmpl" type="text/html">
<input type="hidden" name="id" class="form-control" value="{{data.id}}" />
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label class="control-label col-md-2">季节名称:</label>
                <div class="col-md-10">
                <input type="text" name="name" value="{{data.name}}" class="form-control" placeholder="季节名称">
                </div>
            </div>
			<div class="form-group">
                <label class="control-label col-md-2">季节类型:</label>
                <div class="col-md-10">
                <select name="type" class="form-control" >
                    <option value="">---请选择---</option>
                    {{if data.type == 1}}
                    <option value="1" selected>产品</option>
                    <option value="2">show</option>
                    {{else}}
                     <option value="1">产品</option>
                    <option value="2" selected>show</option>
                    {{/if}}
                </select>
                </div>
            </div>
        </div>
    </div>
</script>




</html>
