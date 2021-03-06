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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript"
	src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
<script src="${appPath}/resources/js/js1.js"></script>
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
						<li><a href="${appPath}/employee/manageEvent">Manage
								event</a></li>
						<li><a href="${appPath}/employee/manageSaleProduct">Manage
								sale product</a></li>
						<li><a href="${appPath}/employee/statistics">Statistics</a></li>
					</c:if>
					<c:if test="${role == 'ONLINE_SELLER'}">
						<li class="active"><a href="${appPath}/employee/manageOrder">Manage
								order</a></li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
		<div class="message">
			<form:errors path="*" />
		</div>
		<div class="top-10">
			<div class="col-md-11">
				<table class="table table-hover table-striped">
					<thead>
						<tr>
							<th>Order ID</th>
							<th>Username</th>
							<th>Name</th>
							<th>Time</th>
							<th>Order detail</th>
							<th>Total price</th>
							<th>Status</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="order" items="${orderList}" varStatus="status">
							<c:set var="totalPrice" value="0" />
							<tr>
								<td>${fn:escapeXml(order.id)}</td>
								<td>${fn:escapeXml(order.customer.userName)}</td>
								<td>${fn:escapeXml(order.customer.lName)}
									${fn:escapeXml(order.customer.mName)}
									${fn:escapeXml(order.customer.fName)}</td>
								<td>${fn:escapeXml(order.date)}</td>
								<td><c:forEach var="lineItem" items="${order.lineItems}">
								${fn:escapeXml(lineItem.product.productTranslationList[0].name)} <b class="em">x ${fn:escapeXml(lineItem.quantity)}</b><br>
										<c:set var="totalPrice"
											value="${totalPrice + lineItem.quantity * lineItem.price}" />
									</c:forEach></td>
								<td>${fn:escapeXml(totalPrice)}</td>
								<td><b class="em">${fn:escapeXml(order.status)}</b></td>
								<td><form:form action="${appPath}/employee/manageOrder"
										modelAttribute="orderForm" method="post">
										<form:select path="status" onchange="submit()">
											<option ${order.status == 'SUBMITTED' ? 'selected' : ''}>SUBMITTED</option>
											<option ${order.status == 'SHIPPED' ? 'selected' : ''}>SHIPPED</option>
											<option ${order.status == 'RECEIVED' ? 'selected' : ''}>RECEIVED</option>
											<option ${order.status == 'CANCELED' ? 'selected' : ''}>CANCELED</option>
										</form:select>
										<form:hidden path="page" />
										<form:hidden path="orderId" value="${order.id}" />
									</form:form></td>
							</tr>

						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="text-center">
		<ul class="page-display pagination">
			<c:if test="${orderForm.page > 1}">
				<li><a
					href="${appPath}/employee/manageOrder?page=${orderForm.page - 1}">Prev</a></li>
			</c:if>
			<c:forEach var="pageIndex" items="${requestScope.pageIndexes }">
				<c:choose>
					<c:when test="${orderForm.page eq pageIndex}">
						<li class="current-page active"><a href="#">${pageIndex}</a></li>
					</c:when>
					<c:otherwise>
						<li><a class="other-display-pages"
							href="${appPath}/employee/manageOrder?page=${pageIndex}">${pageIndex}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if
				test="${requestScope.pageIndexes[fn:length(requestScope.pageIndexes) - 1] > orderForm.page}">
				<li><a
					href="${appPath}/employee/manageOrder?page=${orderForm.page + 1}">Next</a></li>
			</c:if>
		</ul>
	</div>
</body>
</html>