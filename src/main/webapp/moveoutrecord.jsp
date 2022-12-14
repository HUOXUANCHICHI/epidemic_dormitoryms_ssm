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
                    <form role="form" class="form-inline" action="${pageContext.request.contextPath}/moveOut/recordSearch" method="post">
                        <div class="form-group">
                            <label for="key">字段：</label>
                            <select id="key" name="key" class="form-control">
                                <option value="studentName">学生</option>
                                <option value="dormitoryName">宿舍</option>
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
                        <th>学生</th>
                        <th>宿舍</th>
                        <th>迁出原因</th>
                        <th>迁出日期</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${pageInfos.list}" var="moveout">
                        <tr>
                            <td>${moveout.id}</td>
                            <td>${moveout.studentName}</td>
                            <td>${moveout.dormitoryName}</td>
                            <td>${moveout.reason}</td>
                            <td>${moveout.createDate}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

            </div>
            <nav aria-label="Page navigation" style="text-align: center;">
                <ul class="pagination">
                    <li><a href="${pageContext.request.contextPath}/moveOut/record?page=1&size=5" aria-label="Previous">首页</a>
                    </li>
                    <li><a href="${pageContext.request.contextPath}/moveOut/record?page=${pageInfos.pageNum-1}&size=5">上一页</a>
                    </li>
                    <c:forEach begin="1" end="${pageInfos.pages}" var="pageNumber">
                        <li>
                            <a href="${pageContext.request.contextPath}/moveOut/record?page=${pageNumber}&size=5">${pageNumber}</a>
                        </li>
                    </c:forEach>
                    <li><a href="${pageContext.request.contextPath}/moveOut/record?page=${pageInfos.pageNum+1}&size=5">下一页</a>
                    </li>
                    <li><a href="${pageContext.request.contextPath}/moveOut/record?page=${pageInfos.pages}&size=5"
                           aria-label="Next">尾页</a></li>
                </ul>
            </nav>
        </div>
    </div>
</div>

</body>

</html>