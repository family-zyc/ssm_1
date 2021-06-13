<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Yuchao
  Date: 2021/6/8
  Time: 14:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.6.0.min.js" ></script>
    <%--引入bootstrap样式--%>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" />
    <script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js" ></script>
</head>
<body>

    <!-- 员工添加的模态框 -->
    <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                </div>
                <div class="modal-body">
                    <%--表单--%>
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="empName" id="empName_add_input" placeholder="empName">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="email" id="email_add_input" placeholder="email@zyc.com">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-4">
                                <select class="form-control" name="dId" id="dept_add_select"></select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
                </div>
            </div>
        </div>
    </div>

    <%--员工修改模态框--%>
    <div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">员工修改</h4>
                </div>
                <div class="modal-body">
                    <%--表单--%>
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <p class="form-control-static" id="empName_update_static"></p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="email" id="email_update_input" placeholder="email@zyc.com">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-4">
                                <select class="form-control" name="dId" id="dept_update_select"></select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
                </div>
            </div>
        </div>
    </div>

    <%--搭建显示页面--%>
    <div class="container">
        <%--标题--%>
        <div class="row">
            <div class="col-md-12">
                <h1>SSM-CRUD</h1>
            </div>
        </div>
        <%--按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
                <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
            </div>
        </div>
        <%--显示表格数据--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="emps_table">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="check_all"></th>
                            <th>#</th>
                            <th>empName</th>
                            <th>gender</th>
                            <th>email</th>
                            <th>deptName</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
        </div>
        <%--显示分页信息--%>
        <div class="row">
            <%--分页文字信息--%>
            <div class="col-md-6" id="page_info"></div>
            <%--分页条信息--%>
            <div class="col-md-6" id="page_nav"></div>
        </div>

        <script type="text/javascript">

            var pages;  //记录总页数
            var currentPage; //记录当前页

            //页面加载后执行的函数
            $(function () {
               to_page(1);
            });


            //发送ajax请求，返回员工信息
            function to_page(pn) {
                $.ajax({
                    url:"${APP_PATH}/emps",
                    data:"pn=" + pn,
                    type:"get",
                    success:function (data) {
                        // console.log(data);
                        //记录全局页面数
                        pages = data.extend.pageInfo.pages;
                        //1.解析并显示员工数据
                        build_emps_table(data);
                        //2.解析并显示分页信息
                        build_page_info(data);
                        build_page_nav(data);
                    }
                });
            }
            // 显示员工列表
            function build_emps_table(data){
                //清空数据
                $("#emps_table tbody").empty();

                var emps = data.extend.pageInfo.list;
                $.each(emps,function (index,item) {
                    var checkBoxTd = $("<td><input type='checkbox' class='check_item' /></td>");
                    var empIdTd = $("<td></td>").append(item.empId);
                    var empNameTd = $("<td></td>").append(item.empName);
                    var genderTd = $("<td></td>").append(item.gender=='M'?'男':'女');
                    var emailTd = $("<td></td>").append(item.email);
                    var deptNameTd = $("<td></td>").append(item.department.deptName);
                    var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                        .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
                    //为编辑按钮添加一个属性，表示当前员工id
                    editBtn.attr("edit-id",item.empId);
                    var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                        .append($("<span></span>").addClass("glyphicon glyphicon-trash ")).append("删除");
                    //为删除按钮添加一个属性，表示当前员工id
                    delBtn.attr("delete-id",item.empId);
                    var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

                    $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(genderTd)
                        .append(emailTd).append(deptNameTd).append(btnTd)
                        .appendTo("#emps_table tbody");

                });
            }
            //显示分页信息
            function build_page_info(data){
                //清空数据
                $("#page_info").empty();

                $("#page_info").append("当前页："+ data.extend.pageInfo.pageNum +
                    ";总页数：" +  data.extend.pageInfo.pages +
                    ";总记录数：" + data.extend.pageInfo.total);
                //记录全局当前页
                currentPage = data.extend.pageInfo.pageNum;
            }
            // 显示分页条
            function build_page_nav(data) {
                //清空数据
                $("#page_nav").empty();

                var ul = $("<ul></ul>").addClass("pagination");
                var firstPage = $("<li></li>").append($("<a></a>").attr("href","#").append("首页"));
                var previousPage = $("<li></li>").append($("<a></a>").attr("href","#").append("&laquo;"));
                if(data.extend.pageInfo.hasPreviousPage == false){  //判断是否有上一页
                    firstPage.addClass("disabled");
                    previousPage.addClass("disabled");
                }else{
                    //添加点击事件
                    firstPage.click(function () {
                        to_page(1);
                    });
                    previousPage.click(function () {
                        to_page(data.extend.pageInfo.pageNum - 1);
                    });
                }

                var lastPage = $("<li></li>").append($("<a></a>").attr("href","#").append("末页"));
                var NextPage = $("<li></li>").append($("<a></a>").attr("href","#").append("&raquo;"));
                if(data.extend.pageInfo.hasNextPage == false){  //判断是否有下一页
                    lastPage.addClass("disabled");
                    NextPage.addClass("disabled");
                }else{
                    //添加点击事件
                    NextPage.click(function () {
                        to_page(data.extend.pageInfo.pageNum + 1);
                    });
                    lastPage.click(function () {
                        to_page(data.extend.pageInfo.pages);
                    });
                }

                ul.append(firstPage).append(previousPage);
                $.each(data.extend.pageInfo.navigatepageNums,function (index, value) {
                    var numPage = $("<li></li>").append($("<a></a>").attr("href","#").append(value));
                    if(data.extend.pageInfo.pageNum == value){
                        numPage.addClass("active");
                    }
                    //添加点击事件
                    numPage.click(function () {
                        to_page(value);
                    });
                    ul.append(numPage);
                });
                ul.append(NextPage).append(lastPage);

                $("<nav></nav>").append(ul).appendTo("#page_nav");
            }


            //表单重置
            function reset_form(ele){
                //清空表单数据
                $(ele)[0].reset();
                //清空表单样式
                $(ele).find("*").removeClass("has-error has-success");
                $(ele).find(".help-block").text("");
            }
            //弹出添加模态框
            $("#emp_add_modal_btn").click(function () {
                //清空表单数据、表单样式
                reset_form("#empAddModal form");

                //发送ajax请求，查询部门信息，显示在下拉列表中
                getDepts("#dept_add_select");
                //弹出模态框
                $("#empAddModal").modal({
                    backdrop:'static'
                });
            });
            //查出所有的部门信息,显示在下拉列表中
            function getDepts(ele){
                //清空数据
                $(ele).empty();
                $.ajax({
                   url:'${APP_PATH}/depts',
                   type:'GET',
                   success:function (data) {
                       // console.log(data);
                       $.each(data.extend.depts,function (index, item) {
                           var optionEle = $("<option></option>").append(item.deptName).attr("value",item.deptId);
                           optionEle.appendTo(ele);
                       })
                   }
                });
            }


            //后端校验用户名是否可用
            $("#empName_add_input").blur(function () {
                var empName = this.value;
                $.ajax({
                    url:'${APP_PATH}/checkUserName',
                    data:'empName=' + empName,
                    type:"POST",
                    success:function (data) {
                        if(data.code == 100){  //成功
                            show_validate_msg("#empName_add_input","success","用户名可用");
                            $("#emp_save_btn").attr("ajax-va","success"); //给保存按钮添加属性
                        }else{ //失败
                            show_validate_msg("#empName_add_input","error",data.extend.va_msg);
                            $("#emp_save_btn").attr("ajax-va","error"); //给保存按钮添加属性
                        }
                    }
                });
            });
            //添加员工
            $("#emp_save_btn").click(function () {
                //1.前端校验数据
                if(!validata_add_form()){
                    return false;
                }
                //判断之前的ajax用户名校验是否成功
                if($(this).attr("ajax-va") == "error"){
                    show_validate_msg("#empName_add_input","error","用户名不可用");
                    return false;
                }
                //2.提交保存
                $.ajax({
                    url:'${APP_PATH}/emp',
                    data:$("#empAddModal form").serialize(),
                    type:"POST",
                    success:function (data) {
                        // console.log(data);
                        if(data.code == 100){ //success
                            //1.关闭模态框
                            $('#empAddModal').modal('hide');
                            //2.查询最后一页记录
                            to_page(pages + 1);
                        }else{ //fail
                            // show error message to page
                            if(undefined != data.extend.errorFields.email){
                                //show email error message
                                show_validate_msg("#email_add_input","error",data.extend.errorFields.email);
                            }
                            if(undefined != data.extend.errorFields.empName){
                                //show empName error message
                                show_validate_msg("#empName_add_input","error",data.extend.errorFields.empName);
                            }
                        }

                    }
                });
            });
            //校验表单数据
            function validata_add_form(){
                //校验姓名
                var empName = $("#empName_add_input").val();
                var regName = /(^[a-zA-Z0-9_-]{2,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
                if(!regName.test(empName)){
                    show_validate_msg("#empName_add_input","error","用户名可以是2~5位中文或2~16位英文和数字的组合");
                    return false;
                }else{
                    show_validate_msg("#empName_add_input","success","");
                }
                //校验邮箱
                var email = $("#email_add_input").val();
                var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                if(!regEmail.test(email)){
                    show_validate_msg("#email_add_input","error","邮箱格式不正确");
                    return false;
                }else{
                    show_validate_msg("#email_add_input","success","");
                }
                return true;
            }
            //校验成功失败处理
            function show_validate_msg(ele, status, msg){
                //清除当前元素class
                $(ele).parent().removeClass("has-success has-error");
                $(ele).next("span").text("");

                if("success" == status){
                    $(ele).parent().addClass("has-success");
                    $(ele).next("span").text(msg);
                }else if("error" == status){
                    $(ele).parent().addClass("has-error");
                    $(ele).next("span").text(msg);
                }
            }


            // 绑定编辑员工事件
            $(document).on("click",".edit_btn",function () {
                //1.查出部门信息，显示部门信息
                getDepts("#dept_update_select");
                //2.查出员工信息，显示员工信息
                getEmp($(this).attr("edit-id"));
                //3.弹出模态框
                $("#empUpdateModal").modal({
                    backdrop:'static'
                });
            });
            //查询员工信息
            function getEmp(id) {
                $.ajax({
                    url:'${APP_PATH}/emp/' + id,
                    type:'GET',
                    success:function (data) {
                        // console.log(data);
                        var emp = data.extend.emp;
                        $("#empName_update_static").text(emp.empName);
                        $("#email_update_input").val(emp.email);
                        $("#empUpdateModal input[name=gender]").val([emp.gender]);
                        $("#dept_update_select").val([emp.dId]);
                        $("#emp_update_btn").attr("update-id",id); //给更新按钮添加员工id属性
                    }
                });
            }
            //更新员工
            $("#emp_update_btn").click(function () {
                //1.校验邮箱
                var email = $("#email_update_input").val();
                var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                if(!regEmail.test(email)){
                    show_validate_msg("#email_update_input","error","邮箱格式不正确");
                    return false;
                }else{
                    show_validate_msg("#email_update_input","success","");
                }
                //2.提交数据更新
                $.ajax({
                    url:'${APP_PATH}/emp/' + $(this).attr("update-id"),
                    data:$('#empUpdateModal form').serialize(),
                    type:'PUT',
                    success:function (data) {
                        // console.log(data);
                        //1.关闭模态框
                        $("#empUpdateModal").modal("hide");
                        //2.回到本页面
                        to_page(currentPage);
                    }
                });
            });


            //绑定删除员工事件
            $(document).on("click",".delete_btn",function () {
                var empName = $(this).parents("tr").find("td:eq(2)").text();
                var empId = $(this).attr("delete-id");
                if(confirm("确定删除【" +empName+"】吗？")){
                    $.ajax({
                       url:'${APP_PATH}/emp/' + empId,
                        type:"DELETE",
                        success:function (data) {
                            // console.log(data);
                            alert(data.mg);
                            //回到本页
                            to_page(currentPage);
                            $("#check_all").prop("checked",false);
                        }
                    });
                }
            });
            //全选/全不选
            $("#check_all").click(function () {
                $(".check_item").prop("checked",$(this).prop("checked"));
            });
            //check_item
            $(document).on("click",".check_item",function () {
                //判断选中的个数是否是全部复选框的个数
                var flag = $(".check_item:checked").length == $(".check_item").length;
                $("#check_all").prop("checked",flag);
            });
            //删除所有
            $("#emp_delete_all_btn").click(function () {
                var empNames = "";
                var del_ids = "";
                $.each($(".check_item:checked"),function () {
                    //组装需要删除的员工name
                    empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
                    //组装需要删除的员工id
                    del_ids += $(this).parents("tr").find("td:eq(1)").text() + "-";
                });
                empNames = empNames.substring(0,empNames.length-1);
                del_ids = del_ids.substring(0,empNames.length-1);
                if(confirm("确认删除【" +empNames+ "】吗？")){
                    $.ajax({
                       url:'${APP_PATH}/emp/' + del_ids,
                       type:"DELETE",
                       success:function (data) {
                           alert(data.msg);
                           //回到本页
                           to_page(currentPage);
                           $("#check_all").prop("checked",false);
                       }
                    });
                }
            });
            
        </script>
    </div>

</body>
</html>
