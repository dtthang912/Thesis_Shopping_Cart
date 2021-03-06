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
						<li><a href="${appPath}/employee/manageComment">Manage
								comment</a></li>
						<li class="active"><a href="${appPath}/employee/manageEvent">Manage
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
		<form:form action="${appPath}/employee/manageEvent"
			modelAttribute="eventForm" method="post">
			<div class="top-10">
				<div class="col-md-11">
					<table class="table table-hover table-striped">
						<thead>
							<tr>
								<th></th>
								<th>Event ID</th>
								<th>Name</th>
								<th>Description</th>
								<th>Date start</th>
								<th>Date end</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="event" items="${eventList}"
								varStatus="status">
								<tr>
									<td><form:checkbox path="selectedIds[${status.index}]"
											value="${event.id}" /></td>
									<%-- 										</c:if>
									</c:forEach> --%>
									<td>${fn:escapeXml(event.id)}</td>
									<td>${fn:escapeXml(event.name)}</td>
									<td>${fn:escapeXml(event.description)}</td>
									<td>${fn:escapeXml(event.dateStart)}</td>
									<td>${fn:escapeXml(event.dateEnd)}</td>							
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div class="row top-10">
				<div class="col-md-6 col-md-offset-3">
					<div class="form-group">
						<form:button type="submit" class="btn btn-default" name="method"
							onclick="return checkCheckbox();" value="edit">
									Edit
								</form:button>
						<form:button type="submit" class="btn btn-default" name="method"
							onclick="return checkDelete();" value="delete">
									Delete
								</form:button>
						<a
							href="manageEvent?method=showAdd&ePage=${eventForm.ePage}"
							class="btn btn-default"> Add </a>
					</div>
				</div>
			</div>
			<%-- 				</c:if>
			</c:forEach> --%>
			<form:hidden path="ePage" />
		</form:form>
	</div>
	<div class="text-center">
		<ul class="page-display pagination">
			<c:if test="${eventForm.ePage > 1}">
				<li><a
					href="${appPath}/employee/manageEvent?method=list&ePage=${eventForm.ePage - 1}">Prev</a></li>
			</c:if>
			<c:forEach var="pageIndex" items="${requestScope.pageIndexes }">
				<c:choose>
					<c:when test="${eventForm.ePage eq pageIndex}">
						<li class="current-page active"><a href="#">${pageIndex}</a></li>
					</c:when>
					<c:otherwise>
						<li><a class="other-display-pages"
							href="${appPath}/employee/manageEvent?method=list&ePage=${pageIndex}">${pageIndex}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if
				test="${requestScope.pageIndexes[fn:length(requestScope.pageIndexes) - 1] > eventForm.ePage}">
				<li><a
					href="${appPath}/employee/manageEvent?method=list&ePage=${eventForm.ePage + 1}">Next</a></li>
			</c:if>
		</ul>
	</div>
</body>
</html>