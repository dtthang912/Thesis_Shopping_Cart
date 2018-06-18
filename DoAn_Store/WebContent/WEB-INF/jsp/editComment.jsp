<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="appPath" value="/DoAn_Store" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="${appPath}/resources/js/js1.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript"
	src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
<script
	src="//cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/e8bddc60e73c1ec2475f827be36e1957af72e2ea/src/js/bootstrap-datetimepicker.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.7.14/css/bootstrap-datetimepicker.min.css">
<link rel="stylesheet" type="text/css"
	href="${appPath}/resources/css/css1.css">
<title>E-shop</title>
</head>
<body>
	<nav class="navbar navbar-default navbar-statictop">
	<div class="container">
		<ul class="nav navbar-nav navbar-right">
			<li><a class="logout" href="${appPath}/employee/logout">Logout</a></li>
		</ul>
	</div>
	</nav>
	<div class="container-fluid well">
		<div class="col-md-1 sidebar">
			<ul class="nav nav-sidebar">
				<li><a href="${appPath}/employee">Home</a></li>
				<c:forEach var="role" items="${employee.roleList}">
					<c:if test="${role == 'ADMIN'}">
						<li><a
							href="${appPath}/employee/manageCustomer">Manage customer</a></li>
						<li class="active"><a href="${appPath}/employee/manageComment">Manage
								comment</a></li>
						<li><a href="${appPath}/employee/manageEvent">Manage
								event</a></li>
						<li><a href="${appPath}/employee/manageSaleProduct">Manage
								sale product</a></li>
						<li><a href="${appPath}/employee/statistics">Statistics</a></li>
					</c:if>
					<c:if test="${role == 'ONLINE_SELLER'}">
						<li><a href="${appPath}/employee/manageOrder">Manage
								order</a></li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
		<div class="message">
			<form:errors path="*" />
		</div>
		<form:form action="${appPath}/employee/manageComment"
			modelAttribute="commentForm" method="post">
			<form:hidden path="selectedIds" />
			<div class="top-10">
				<div class="col-md-11">
					<table class="table table-hover table-striped">
						<thead>
							<tr>
								<th>Comment ID</th>
								<td>Product Id</td>
								<th>Product name</th>
								<th>Username</th>
								<th>Content</th>
								<th>Time</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="comment" items="${commentForm.commentList}"
								varStatus="status">
								<tr>
									<form:hidden path="commentList[${status.index}].id" />
									<td>${fn:escapeXml(comment.id)}</td>
									<td>${fn:escapeXml(comment.product.id)}</td>
									<td>${fn:escapeXml(comment.product.productTranslationList[0].name)}</td>
									<td>${fn:escapeXml(comment.customer.userName)}</td>
									<td>
										<div class="form-group">
											<form:input type="text"
												cssClass=" form-control
												input-sm"
												path="commentList[${status.index}].content" required="true" />
										</div>
									</td>
									<td>${fn:escapeXml(comment.time)}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div class="row top-10">
				<div class="col-md-6 col-md-offset-4">
					<div class="form-group">
						<form:button name="method" type="submit" class="btn btn-default"
							value="update">
							Update
						</form:button>
						<a href="manageComment?method=list&cPage=${commentForm.cPage}"
							class="btn btn-default">Cancel</a>
					</div>
				</div>
			</div>
			<form:hidden path="cPage" />
		</form:form>
	</div>
</body>
</html>