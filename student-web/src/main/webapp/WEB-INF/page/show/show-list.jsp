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
                    <h5>show管理</h5>
                </div>
                <div class="ibox-content">
                    <form role="form" class="form-inline" id="searchForm">
                        <div class="form-group">
                            <label>季节:</label>
                            <select name="showseason" id="searchSeason" class="form-control">
                               <option value="">---请选择---</option>
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
                    <span  style="font-weight:bold">banner图新增</span>
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
                    <span  style="font-weight:bold">用户修改</span>
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
	var seasonList;
      var seasons = new Array();
    $(document).ready(function () {
        $.jgrid.defaults.styleUI = 'Bootstrap';
         postAsync('${ctx}/season/getSeanList',{type:'2'},function(result){seasonList=result.data;})
        $.each(seasonList,function(){
            seasons[this.id] = this.name;
        });
        $.each(seasonList,function(){
            var me = this;
            $("<option value='"+me.id+"'>"+me.name+"</option>").appendTo("#searchSeason");
        });
        $("#table_list").jqGrid({
            datatype: "json",
            url: '${ctx}/show/page?pageSize=5',
            mtype : 'POST',
            height: 300,
            autowidth: true,
            shrinkToFit: true,
            rowNum: 14,
            rowList: [10, 20, 30],
            colNames: ['季节', '图片', '操作'],
            colModel: [
                {
                    name: 'showseason',
                    index: 'showseason',
                    width: 150,
                    formatter : function(cellvalue, options, rowObject){
                       return seasons[cellvalue];
                    }
                },
                {
                    name:'showDataList',
                    index:'showDataList',
                    width : 1000,
                    formatter : function(cellvalue, options, rowObject){
                        var html = '';
                        $.each(cellvalue,function(){
                            html += '<span ><img src="${ctx}/'+this.image+'" width="100px" height="100px"  /></span>';
                           
                        });
                        html += '';
                        return html;
                    }
                },
                {
                    name: 'showseason',
                    index: 'showseason',
                    width: 150,
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
            $('#add-data').html(template('add-tmpl',{'seasonList':seasonList}));
            initImageUpload('add_path1','uploadBtnHolder1','img1');
            initImageUpload('add_path2','uploadBtnHolder2','img2');
            initImageUpload('add_path3','uploadBtnHolder3','img3');
            initImageUpload('add_path4','uploadBtnHolder4','img4');
            initImageUpload('add_path5','uploadBtnHolder5','img5');
            initImageUpload('add_path6','uploadBtnHolder6','img6');
            initImageUpload('add_path7','uploadBtnHolder7','img7');
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
        postAsync('${ctx}/show/getShowBySeasonid',{'showseason':id},function(result){data=result.data});
        $('#upd-data').html(template('upd-tmpl',{'data':data,'seasonList':seasonList}));
        var i = 0;
        $.each(data.showDataList,function(){
            initImageUpload('upd_path'+i,'updBtn'+i,'img'+i);
            i++;
        });
        $("#upd-modal").modal({backdrop: 'static', keyboard: false});
    }

    function update(){
        var param = {};
        $('#updForm .form-control').each(function(){
            var name = $(this).attr('name');
            var value = $(this).val();
             if(param[name]){
                value = param[name]+','+value;
            }
            param[name] = value;
        });
        if(!validate(param)){
            return;
        }
        postAjax('${ctx}/show/update',param,function(result){
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
            if(param[name]){
                value = param[name]+','+value;
            }
            param[name] = value;
        });
        if(!validate(param)){
            return;
        }
        postAjax('${ctx}/show/add',param,function(result){
            if(result.success){
                swal("提示！", "新增成功!", "success");
                $("#add-modal").modal("hide");
                $("#table_list").trigger("reloadGrid");
            }else{
                swal("提示！", result.msg, "error");
            }
        });

    }


    function deleteRow(id){
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
            postAjax('${ctx}/banner/delete',{'id':id},function(result){
                if(result.success){
                    $("#table_list").trigger("reloadGrid");
                    swal("操作成功!", "已成功删除数据！", "success");
                }else{
                    swal("提示信息", "删除失败", "error");
                }
            });
        });
    }


    function validate(param){
        if (!param['showseason']) {
            swal("提示信息", "请选择季节", "error");
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
                <label class="control-label col-md-2">季节:</label>
                <div class="col-md-10">
                   <select name="showseason" class="form-control" placeholder="季节">
                       <option value="">---请选择---</option>
						{{each seasonList as value i}}
                            <option value="{{value.id}}">{{value.name}}</option>
                        {{/each}}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-2">图片1:</label>
                <div class="col-md-10">
                    <div class="img1">
                        <div class="logobox"><div class="resizebox"><img src="${ctx}/assets/img/upload.png" width="100px" alt="" height="100px"/></div></div>
                        <div class="logoupload">
                            <input type="hidden" name="images" id="add_path1" class="form-control"   />
                            <div class="btnbox"><a id="uploadBtnHolder1" class="uploadbtn" href="javascript:;">上传替换</a></div>
                            <div style="clear:both;height:0;overflow:hidden;"></div>
                            <div class="progress-box" style="display:none;">
                                <div class="progress-num">上传进度：<b>0%</b></div>
                                <div class="progress-bar"><div style="width:0%;" class="bar-line"></div></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-2">图片2:</label>
                <div class="col-md-10">
                    <div class="img2">
                        <div class="logobox"><div class="resizebox"><img src="${ctx}/assets/img/upload.png" width="100px" alt="" height="100px"/></div></div>
                        <div class="logoupload">
                            <input type="hidden" name="images" id="add_path2" class="form-control"   />
                            <div class="btnbox"><a id="uploadBtnHolder2" class="uploadbtn" href="javascript:;">上传替换</a></div>
                            <div style="clear:both;height:0;overflow:hidden;"></div>
                            <div class="progress-box" style="display:none;">
                                <div class="progress-num">上传进度：<b>0%</b></div>
                                <div class="progress-bar"><div style="width:0%;" class="bar-line"></div></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-2">图片3:</label>
                <div class="col-md-10">
                    <div class="img3">
                        <div class="logobox"><div class="resizebox"><img src="${ctx}/assets/img/upload.png" width="100px" alt="" height="100px"/></div></div>
                        <div class="logoupload">
                            <input type="hidden" name="images" id="add_path3" class="form-control"   />
                            <div class="btnbox"><a id="uploadBtnHolder3" class="uploadbtn" href="javascript:;">上传替换</a></div>
                            <div style="clear:both;height:0;overflow:hidden;"></div>
                            <div class="progress-box" style="display:none;">
                                <div class="progress-num">上传进度：<b>0%</b></div>
                                <div class="progress-bar"><div style="width:0%;" class="bar-line"></div></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-2">图片4:</label>
                <div class="col-md-10">
                    <div class="img4">
                        <div class="logobox"><div class="resizebox"><img src="${ctx}/assets/img/upload.png" width="100px" alt="" height="100px"/></div></div>
                        <div class="logoupload">
                            <input type="hidden" name="images" id="add_path4" class="form-control"   />
                            <div class="btnbox"><a id="uploadBtnHolder4" class="uploadbtn" href="javascript:;">上传替换</a></div>
                            <div style="clear:both;height:0;overflow:hidden;"></div>
                            <div class="progress-box" style="display:none;">
                                <div class="progress-num">上传进度：<b>0%</b></div>
                                <div class="progress-bar"><div style="width:0%;" class="bar-line"></div></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-2">图片5:</label>
                <div class="col-md-10">
                    <div class="img5">
                        <div class="logobox"><div class="resizebox"><img src="${ctx}/assets/img/upload.png" width="100px" alt="" height="100px"/></div></div>
                        <div class="logoupload">
                            <input type="hidden" name="images" id="add_path5" class="form-control"   />
                            <div class="btnbox"><a id="uploadBtnHolder5" class="uploadbtn" href="javascript:;">上传替换</a></div>
                            <div style="clear:both;height:0;overflow:hidden;"></div>
                            <div class="progress-box" style="display:none;">
                                <div class="progress-num">上传进度：<b>0%</b></div>
                                <div class="progress-bar"><div style="width:0%;" class="bar-line"></div></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-2">图片6:</label>
                <div class="col-md-10">
                    <div class="img6">
                        <div class="logobox"><div class="resizebox"><img src="${ctx}/assets/img/upload.png" width="100px" alt="" height="100px"/></div></div>
                        <div class="logoupload">
                            <input type="hidden" name="images" id="add_path6" class="form-control"   />
                            <div class="btnbox"><a id="uploadBtnHolder6" class="uploadbtn" href="javascript:;">上传替换</a></div>
                            <div style="clear:both;height:0;overflow:hidden;"></div>
                            <div class="progress-box" style="display:none;">
                                <div class="progress-num">上传进度：<b>0%</b></div>
                                <div class="progress-bar"><div style="width:0%;" class="bar-line"></div></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-2">图片7:</label>
                <div class="col-md-10">
                    <div class="img7">
                        <div class="logobox"><div class="resizebox"><img src="${ctx}/assets/img/upload.png" width="100px" alt="" height="100px"/></div></div>
                        <div class="logoupload">
                            <input type="hidden" name="images" id="add_path7" class="form-control"   />
                            <div class="btnbox"><a id="uploadBtnHolder7" class="uploadbtn" href="javascript:;">上传替换</a></div>
                            <div style="clear:both;height:0;overflow:hidden;"></div>
                            <div class="progress-box" style="display:none;">
                                <div class="progress-num">上传进度：<b>0%</b></div>
                                <div class="progress-bar"><div style="width:0%;" class="bar-line"></div></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</script>


<script id="upd-tmpl" type="text/html">
    <div class="row">
    <!-- <input type="hidden" name="id" value="{{data.id}}" class="form-control"> -->
        <div class="col-md-12">
            <div class="form-group">
                <label class="control-label col-md-2">季节:</label>
                <div class="col-md-10">
                   <select name="showseason" class="form-control" placeholder="季节">
                       <option value="">---请选择---</option>
						{{each seasonList as value i}}
							{{if data.showseason == value.id }}
                            <option value="{{value.id}}" selected>{{value.name}}</option>
                            {{else}}
                            <option value="{{value.id}}">{{value.name}}</option>
							{{/if}}
                        {{/each}}
                    </select>
                </div>
            </div>
            {{each data.showDataList as value i}}
                <div class="form-group">
                <label class="control-label col-md-2">图片{{i}}:</label>
                <div class="col-md-10">
                    <div class="img{{i}}">
                        <div class="logobox"><div class="resizebox"><img src="${ctx}/{{value.image}}" width="100px" alt="" height="100px"/></div></div>
                        <div class="logoupload">
                            <input type="hidden" name="ids" value="{{value.id}}" class="form-control">
                            <input type="hidden" name="images" value="{{value.image}}" id="upd_path{{i}}" class="form-control"   />
                            <div class="btnbox"><a id="updBtn{{i}}" class="uploadbtn" href="javascript:;">上传替换</a></div>
                            <div style="clear:both;height:0;overflow:hidden;"></div>
                            <div class="progress-box" style="display:none;">
                                <div class="progress-num">上传进度：<b>0%</b></div>
                                <div class="progress-bar"><div style="width:0%;" class="bar-line"></div></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            {{/each}}
    </div>
</script>


<script type="text/javascript">
    function updateProgress(file,imgClass) {
        $('.'+imgClass+' .progress-box .progress-bar > div').css('width', parseInt(file.percentUploaded) + '%');
        $('.'+imgClass+ ' .progress-box .progress-num > b').html(SWFUpload.speed.formatPercent(file.percentUploaded));
        if(parseInt(file.percentUploaded) == 100) {
            // 如果上传完成了
            $('.'+imgClass+ ' .progress-box').hide();
        }
    }

    function initProgress(imgClass) {
        $('.'+imgClass+ ' .progress-box').show();
        $('.'+imgClass+  ' .progress-box .progress-bar > div').css('width', '0%');
        $('.'+imgClass+  ' .progress-box .progress-num > b').html('0%');
    }

    function successAction(fileInfo,imgId,imgClass) {
        var up_path = fileInfo.path;
        var up_width = fileInfo.width;
        var up_height = fileInfo.height;
        var _up_width,_up_height;
        if(up_width > 120) {
            _up_width = 120;
            _up_height = _up_width*up_height/up_width;
        }
        $("."+imgClass+" .logobox .resizebox").css({width: _up_width, height: _up_height});
        $("."+imgClass+" .logobox .resizebox > img").attr('src', '../'+up_path);
        $("."+imgClass+" .logobox .resizebox > img").attr('width', _up_width);
        $("."+imgClass+" .logobox .resizebox > img").attr('height', _up_height);
        $('#'+imgId).val(up_path);
    }


    function initImageUpload(imgId,uploadBtn,imgClass){
        var settings = {
            flash_url : "${ctx}/assets/js/plugins/swfupload/swfupload.swf",
            flash9_url : "${ctx}/assets/js/plugins/swfupload/swfupload_fp9.swf",
            upload_url: "${ctx}/upload/file",// 接受上传的地址
            file_size_limit : "15MB",// 文件大小限制
            file_types : "*.jpg;*.gif;*.png;*.jpeg;",// 限制文件类型
            file_types_description : "图片",// 说明，自己定义
            file_upload_limit : 100,
            file_queue_limit : 0,
            custom_settings : {},
            debug: false,
            // Button settings
            button_image_url: "${ctx}/assets/js/plugins/swfupload/upload-btn.png",
            button_width: "95",
            button_height: "30 ",
            button_placeholder_id: uploadBtn,
            button_window_mode : SWFUpload.WINDOW_MODE.TRANSPARENT,
            button_cursor : SWFUpload.CURSOR.HAND,
            button_action: SWFUpload.BUTTON_ACTION.SELECT_FILE,

            moving_average_history_size: 40,

            // The event handler functions are defined in handlers.js
            swfupload_preload_handler : preLoad,
            swfupload_load_failed_handler : loadFailed,
            file_queued_handler : fileQueued,
            file_dialog_complete_handler: fileDialogComplete,
            upload_start_handler : function (file) {
                initProgress(imgClass);
                updateProgress(file,imgClass);
            },
            upload_progress_handler : function(file, bytesComplete, bytesTotal) {
                updateProgress(file,imgClass);
            },
            upload_success_handler : function(file, data, response) {
                // 上传成功后处理函数
                var fileInfo = eval("(" + data + ")");
                successAction(fileInfo,imgId,imgClass);
            },
            upload_error_handler : function(file, errorCode, message) {
                alert('上传发生了错误！');
            },
            file_queue_error_handler : function(file, errorCode, message) {
                if(errorCode == -110) {
                    alert('您选择的文件太大了。');
                }
            }
        };
        new SWFUpload(settings);
    }


    $(document).ready(function() {

    });
</script>



</html>
