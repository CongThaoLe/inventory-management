<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>

<div class="right_col" role="main">

            <div class="row" style="display: block;">

              <div class="clearfix"></div>

              <div class="col-md-12 col-sm-12  ">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Menu List</h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <a class="dropdown-item" href="#">Settings 1</a>
                            <a class="dropdown-item" href="#">Settings 2</a>
                          </div>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>

                  <div class="x_content">
                  <a href='<c:url value="/menu/permission"></c:url>' class="btn btn-app"><i class="fa fa-plus"></i>Permission</a>
                    
                    <div class="container" style="padding: 50px">
                    	<form:form modelAttribute="searchForm"
							cssClass="form-horizontal form-label-left"
							servletRelativeAction="/menu/list/1" method="POST">
							<div class="item form-group">
								<label class="col-form-label col-md-3 col-sm-3 label-align"
									for="name">Name 
								</label>
								<div class="col-md-6 col-sm-6 ">
									<form:input path="name" cssClass="form-control " />
								</div>
							</div>
							<div class="item form-group">
								<div class="col-md-6 col-sm-6 offset-md-3">
										<button type="submit" class="btn btn-success">Search</button>
								</div>
							</div>

						</form:form>
                    </div>
                    
                    <div class="table-responsive">
                      <table class="table table-striped jambo_table bulk_action">
                        <thead>
                          <tr class="headings">
                            <th rowspan="2" class="column-title" style="border-left: 2px solid"># </th>
                            <th rowspan="2" class="column-title" style="border-left: 2px solid">Url</th>
                            <th rowspan="2" class="column-title" style="border-left: 2px solid">Status</th>
                            <th colspan="${roles.size()}" class="column-title text-center" style="border-left: 2px solid">Role</th>
                            </th>
                          </tr>
                          <tr>
                          	<c:forEach var="role" items="${roles}">
                          		<th class="column-title" style="border-left: 2px solid">${role.roleName}</th>
                          	</c:forEach>
                          </tr>
                        </thead>

                        <tbody>
                        <c:forEach items="${menuList}" var="menu" varStatus="loop">
                        
                        <c:choose>
                        	<c:when test="${loop.index %2 == 0 }">
                        		<tr class="even pointer">
                        	</c:when>
                        	<c:otherwise>
                        		<tr class="odd pointer">
                        	</c:otherwise>
                        </c:choose>
                            <td class="">${pageInfo.getOffset() + loop.index+1}</td>
                            <td class="">${menu.url}</td>
                            <c:choose>
                            	<c:when test="${menu.activeFlag==1}">
                            		<td><a href="javascript:void(0);" onclick="confirmChange(${menu.id},${menu.activeFlag});" class="btn btn-round btn-danger">Disable</a></td>
                            	</c:when>
                            	<c:otherwise>
                            		<td><a href="javascript:void(0);" onclick="confirmChange(${menu.id},${menu.activeFlag});" class="btn btn-round btn-primary">Enable</a></td>
                            	</c:otherwise>
                            </c:choose>
                            <c:forEach items="${menu.mapAuth}" var="auth">
                            	<c:choose>
                            		<c:when test="${auth.value==1}">
                            			<td><i class="fa fa-check" style="color: green;"></i></td>
                            		</c:when>
                            		<c:otherwise>
                            			<td><i class="fa fa-times" style="color: red;"></i></td>
                            		</c:otherwise>
                            	</c:choose>
                            </c:forEach>
                          </tr>
                        </c:forEach>
                        </tbody>
                      </table>
                      <jsp:include page="../layout/paging.jsp"></jsp:include>
                    </div>
							
						
                  </div>
                </div>
              </div>
            </div>
          </div>
<script type="text/javascript">
function gotoPage(page){
	$('#searchForm').attr('action','<c:url value="/menu/list/"/>'+page);
	$('#searchForm').submit();
}
function confirmChange(id,flag){
	var msg = flag==1? 'Do you want disable this menu?' : 'Do you want anable this menu?';
	if(confirm(msg)){
		window.location.href='<c:url value="/menu/change-status/" />'+id;
	}
}
$(document).ready(function(){
	processMessage();
});
function processMessage(){
	var msgSuccess = '${msgSuccess}';
	var msgError = '${msgError}';
	if(msgSuccess){
		new PNotify({
            title: 'Success',
            type: 'success',
            text: msgSuccess,
            styling: 'bootstrap3',
        });
	};
	if(msgError){
		 new PNotify({
            title: 'Error',
            type: 'error',
            text: msgError,
            styling: 'bootstrap3'
        });
	}
}
</script>