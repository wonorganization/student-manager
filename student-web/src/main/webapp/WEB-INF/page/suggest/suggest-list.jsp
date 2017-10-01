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
                    <h5>建议列表</h5>
                </div>
                <div class="ibox-content">
                    <form role="form" class="form-inline" id="searchForm">
                        <div class="form-group">
                            <label>标题:</label>
                            <input type="text" name="title" class="form-control">
                        </div>&nbsp;&nbsp;&nbsp;&nbsp;
                        <button type="button" class="btn btn-w-m btn-primary" id="searchBth" >查询</button>
                        <button type="button" class="btn btn-w-m btn-success" id="resetBtn">重置</button>
                    </form>
                </div>
                <!-- <div class="ibox-content">
                    <button type="button" class="btn btn-w-m btn-success" id="addBtn">新增</button>
                </div> -->
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



<div class="modal inmodal" id="info-modal" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog" style="width: 800px;">
        <div class="modal-content animated rubberBand">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span
                        class="sr-only">关闭</span></button>
                <h2 class="modal-title">详细信息</h2>
            </div>
            <div class="modal-body">
                <div class="row" id="info-content">

                </div>
            </div>
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
            url: '${ctx}/suggest/page',
            mtype : 'POST',
            height: 300,
            autowidth: true,
            shrinkToFit: true,
            rowNum: 14,
            rowList: [10, 20, 30],
            colNames: ['id', '标题','名称','内容','创建时间', '操作'],
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
                    name: 'title',
                    index: 'title',
                    width: 90
                },
                {
                    name: 'content',
                    index: 'content',
                    width: 200
                },
                
                {
                    name: 'createTime',
                    index: 'createTime',
                    width: 150
                },
                {
                    name: 'id',
                    index: 'id',
                    width: 200,
                    sortable: false,
                    formatter: function(cellvalue, options, rowObject){
                        var html = '<button class="btn btn-info" name="edit-btn" onClick="goDetail('+cellvalue+')" data-key="'+cellvalue+'" type="button"><i class="fa fa-paste"></i> 详细</button>&nbsp;&nbsp;';
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



        $('#searchBth').bind('click',function(){
            search();
        });

        $('#resetBtn').bind('click',function(){
            $('#searchForm')[0].reset();
        });



    });

    function goDetail(id){
        var data;
        postAsync('${ctx}/suggest/getSuggestById',{'id':id},function(res){data=res.data;});
        var html = template('detail-template',{data:data});
        $("#info-content").html(html);
        $("#info-modal").modal({backdrop: 'static', keyboard: false});
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

</script>
</body>

<script id="detail-template" type="text/html">
    <div class="ibox border-bottom">
        <div class="ibox-title">
            <h5><b>建议详细信息</b> <span class="text-navy"></span></h5>
        </div>
        <div class="ibox-content" id="cloud-unit">
            <table class="table table-stripped footable footable-loaded no-paging" style="word-break:break-all; word-wrap:break-all;">
                <thead>
                <tr>
                    <th class="footable-sortable" style="cursor: default;width:140px;">属性名称</th>
                    <th class="footable-sortable" style="cursor: default;">属性值</th>
                </tr>
                </thead>
                <tbody>
                <tr class="footable-even" style="display: table-row;">
                    <td><span class="footable-toggle"></span>id</td>
                    <td>{{data.id}}</td>
                </tr>
                <tr class="footable-odd" style="display: table-row;">
                    <td><span class="footable-toggle"></span>名称</td>
                    <td>{{data.name}}</td>
                </tr>
                <tr class="footable-even" style="display: table-row;">
                    <td><span class="footable-toggle"></span>标题</td>
                    <td>{{data.title}}</td>
                </tr>
                <tr class="footable-even" style="display: table-row;">
                    <td><span class="footable-toggle"></span>内容</td>
                    <td>{{data.content}}</td>
                </tr>

                </tbody>
            </table>
        </div>
    </div>
</script>






</html>
