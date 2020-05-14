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
                    <h2>ProductInfo List</h2>
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
                    <a href='<c:url value="/product-info/add"></c:url>' class="btn btn-app"><i class="fa fa-plus"></i>Add</a>
                    
                    <div class="container" style="padding: 50px">
                    	<form:form modelAttribute="searchForm"
							cssClass="form-horizontal form-label-left"
							servletRelativeAction="/product-info/list/1" method="POST">
							<div class="item form-group">
								<label for="id"
									class="col-form-label col-md-3 col-sm-3 label-align">ID</label>
								<div class="col-md-6 col-sm-6 ">
									<form:input path="id" cssClass="form-control " />
								</div>
							</div>
							<div class="item form-group">
								<label class="col-form-label col-md-3 col-sm-3 label-align"
									for="code">Code 
								</label>
								<div class="col-md-6 col-sm-6 ">
									<form:input path="code" cssClass="form-control " />
								</div>
							</div>
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
                            <th class="column-title"># </th>
                            <th class="column-title">Id</th>
                            <th class="column-title">Code</th>
                            <th class="column-title">Name</th>
                            <th class="column-title">Image </th>
                            <th class="column-title no-link last text-center"  colspan="3"><span class="nobr">Action</span>
                            </th>
                          </tr>
                        </thead>

                        <tbody>
                        <c:forEach items="${products}" var="product" varStatus="loop">
                        
                        <c:choose>
                        	<c:when test="${loop.index %2 == 0 }">
                        		<tr class="even pointer">
                        	</c:when>
                        	<c:otherwise>
                        		<tr class="odd pointer">
                        	</c:otherwise>
                        </c:choose>
                            <td class="">${pageInfo.getOffset() + loop.index+1}</td>
                            <td class="">${product.id}</td>
                            <td class="">${product.code}</td>
                            <td class="">${product.name}</td>
                            <td class=""><img alt="" src='<c:url value="${product.imgUrl}"></c:url>' width="100px" height="100px"></td>
                            <td class="text-center"><a href='<c:url value="/product-info/view/${product.id}"></c:url>' class="btn btn-round btn-info">View</a>
                            </td>
                            <td class="text-center"><a href='<c:url value="/product-info/edit/${product.id}"></c:url>' class="btn btn-round btn-primary">Edit</a>
                            </td>
                            <td class="text-center"><a href="javascript:void(0);" onclick="confirmDelete(${product.id});" class="btn btn-round btn-danger">Delete</a>
                            </td>
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
function confirmDelete(id){
	if(confirm('Do you want delete this record?')){
		window.location.href = '<c:url value="/product-info/delete/" />'+id;
	}
}
function gotoPage(page){
	$('#searchForm').attr('action','<c:url value="/product-info/list/"/>'+page);
	$('#searchForm').submit();
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