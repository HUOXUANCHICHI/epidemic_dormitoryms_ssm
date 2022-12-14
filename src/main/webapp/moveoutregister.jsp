<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <!-- 引入 Bootstrap -->
    <script src="https://cdn.bootcss.com/jquery/2.2.4/jquery.min.js"></script>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <!-- 引入 font-awesome -->
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <title>宿舍管理系统</title>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-sm-10">

            <!-- 顶部搜索部分 -->
            <div class="panel panel-default">
                <div class="panel-heading">搜索</div>
                <div class="panel-body">
                    <form role="form" class="form-inline" action="${pageContext.request.contextPath}/moveOut/search" method="post">
                        <div class="form-group">
                            <label for="key">字段：</label>
                            <select id="key" name="key" class="form-control">
                                <option value="number">学号</option>
                                <option value="name">姓名</option>
                            </select>
                        </div>
                        <div class="form-group" style="margin-left: 20px">
                            <label for="value">值：</label>
                            <input id="value" type="text" class="form-control" name="value" placeholder="字段值" maxlength="12" style="width: 130px">
                        </div>
                        <div class="form-group " style="margin-left: 20px">
                            <button type="submit" class="btn btn-info ">
										<span style="margin-right: 5px"
                                              class="glyphicon glyphicon-search" aria-hidden="true">
										</span>开始搜索
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            <!-- 列表展示-->
            <div class="table-responsive">
                <table class="table table-hover ">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>宿舍</th>
                        <th>学号</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${pageInfos.list}" var="student">
                        <tr>
                            <td>${student.id}</td>
                            <td>${student.dormitoryName}</td>
                            <td>${student.number}</td>
                            <td>${student.name}</td>
                            <td>${student.gender}</td>
                            <td>${student.state}</td>
                            <td>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-danger"
                                            data-id="${student.id}"
                                            data-number="${student.number}"
                                            data-dormitory-id="${student.dormitoryId}"
                                            data-toggle="modal"
                                            data-target="#delUserModal">
                                        <i class="fa fa-user-o">迁出</i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <!-- 删除模态框示例（Modal） -->
                <form method="post" action="${pageContext.request.contextPath}/moveOut/emigrate"
                      class="form-horizontal" style="margin-top: 0px" role="form"
                      id="form_data" style="margin: 20px;">

                    <div class="modal fade" id="delUserModal" tabindex="-1"
                         role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal"
                                            aria-hidden="true">×</button>
                                    <h4 class="modal-title" id="myModalLabel">用户信息</h4>
                                </div>
                                <div class="modal-body">
                                    <form class="form-horizontal" role="form">

                                        <div class="form-group">
                                            <div class="col-sm-9">
                                                <h3 class="col-sm-18 control-label" id="deleteLabel">删除信息</h3>
                                                <input type="hidden" class="form-control" id="tab"
                                                       name="tab" placeholder="" value="dor_admin">
                                                <input type="hidden" class="form-control" id="id"
                                                       name="studentId" placeholder="">
                                                <input type="hidden" id="dormitoryId" name="dormitoryId">
                                                <input type="hidden" id="studentId" name="studentId">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="reason" class="col-sm-3 control-label">迁出原因</label>
                                            <div class="col-sm-9">
                                                <input id="reason" type="text" required class="form-control"
                                                       name="reason">
                                            </div>
                                        </div>

                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                    <button type="submit" class="btn btn-danger">迁出</button>
                                    <span id="tip"> </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <nav aria-label="Page navigation" style="text-align: center;">
                <ul class="pagination">
                    <li><a href="${pageContext.request.contextPath}/moveOut/listPage?page=1&size=5" aria-label="Previous">首页</a>
                    </li>
                    <li><a href="${pageContext.request.contextPath}/moveOut/listPage?page=${pageInfos.pageNum-1}&size=5">上一页</a>
                    </li>
                    <c:forEach begin="1" end="${pageInfos.pages}" var="pageNumber">
                        <li>
                            <a href="${pageContext.request.contextPath}/moveOut/listPage?page=${pageNumber}&size=5">${pageNumber}</a>
                        </li>
                    </c:forEach>
                    <li><a href="${pageContext.request.contextPath}/moveOut/listPage?page=${pageInfos.pageNum+1}&size=5">下一页</a>
                    </li>
                    <li><a href="${pageContext.request.contextPath}/moveOut/listPage?page=${pageInfos.pages}&size=5"
                           aria-label="Next">尾页</a></li>
                </ul>
            </nav>
        </div>
    </div>
</div>

<script>
    $('#delUserModal').on('show.bs.modal', function(event) {
        const button = $(event.relatedTarget);
        const id = button.data('id');
        const number = button.data('number');
        const dormitoryId = button.data('dormitory-id');
        const modal = $(this);
        modal.find('.modal-title').text('学生迁出登记')
        modal.find('#deleteLabel').text('将迁出学号为  ' + number + ' 的学生')
        modal.find('#number').val(number)
        modal.find('#dormitoryId').val(dormitoryId)
        modal.find('#id').val(id)
    })
</script>

</body>

</html>