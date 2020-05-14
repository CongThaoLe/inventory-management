<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<div class="right_col" role="main">
	<div class="">
		<div class="page-title">
			<div class="title_left">
				<h2>${titlePage}</h2>
			</div>
		</div>
		<div class="clearfix"></div>
		<div class="row">
			<div class="col-md-12 col-sm-12 ">
				<div class="x_panel">
					<div class="x_title">
						<h2>
							Form Design <small>different form elements</small>
						</h2>
						<ul class="nav navbar-right panel_toolbox">
							<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
							</li>
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown" role="button" aria-haspopup="true"
								aria-expanded="false"><i class="fa fa-wrench"></i></a>
								<ul class="dropdown-menu" role="menu">
									<li><a class="dropdown-item" href="#">Settings 1</a></li>
									<li><a class="dropdown-item" href="#">Settings 2</a></li>
								</ul></li>
							<li><a class="close-link"><i class="fa fa-close"></i></a></li>
						</ul>
						<div class="clearfix"></div>
					</div>
					<div class="x_content">
						<br />
						<form:form modelAttribute="modelForm"
							cssClass="form-horizontal form-label-left"
							servletRelativeAction="/category/save" method="POST">
							<form:hidden path="id"/>
							<form:hidden path="createDate"/>
							<form:hidden path="activeFlag"/>

							<div class="item form-group">
								<label class="col-form-label col-md-3 col-sm-3 label-align"
									for="code">Code <span class="required">*</span>
								</label>
								<div class="col-md-6 col-sm-6 ">
									<form:input path="code" cssClass="form-control " disabled="${viewOnly}"/>
									<div class="has-error">
										<form:errors path="code" cssClass="help-block"></form:errors>
									</div>
								</div>
							</div>
							<div class="item form-group">
								<label class="col-form-label col-md-3 col-sm-3 label-align"
									for="name">Name <span class="required">*</span>
								</label>
								<div class="col-md-6 col-sm-6 ">
									<form:input path="name" cssClass="form-control " disabled="${viewOnly}"/>
									<div class="has-error">
										<form:errors path="name" cssClass="help-block"></form:errors>
									</div>
								</div>
							</div>
							<div class="item form-group">
								<label for="description"
									class="col-form-label col-md-3 col-sm-3 label-align">Description</label>
								<div class="col-md-6 col-sm-6 ">
									<form:input path="description" cssClass="form-control " disabled="${viewOnly}"/>
									<div class="has-error">
										<form:errors path="description" cssClass="help-block"></form:errors>
									</div>
								</div>
							</div>
							<div class="ln_solid"></div>
							<div class="item form-group">
								<div class="col-md-6 col-sm-6 offset-md-3">
									<button class="btn btn-primary" type="button" onclick="cancel()">Cancel</button>
									<c:if test="${!viewOnly}">
										<button class="btn btn-primary" type="reset">Reset</button>
										<button type="submit" class="btn btn-success">Submit</button>
									</c:if>
								</div>
							</div>

						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	$('#categorylistId').addClass('current-page').siblings().removeClass('current-page');
	var parent = $('#categorylistId').parents('li');
	parent.addClass('active').siblings().removeClass('active');
	$('#categorylistId').parents().show();
});
function cancel() {
	window.location.href = '<c:url value="/category/list"/>'
}
</script>