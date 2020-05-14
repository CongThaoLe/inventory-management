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
                    <h2>Product In Stock List</h2>
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
                    <div class="container" style="padding: 50px">
                    	<form:form modelAttribute="searchForm"
							cssClass="form-horizontal form-label-left"
							servletRelativeAction="/product-in-stock/list/1" method="POST">
							<div class="item form-group">
								<label for="productInfo.code"
									class="col-form-label col-md-3 col-sm-3 label-align">Code</label>
								<div class="col-md-6 col-sm-6 ">
									<form:input path="productInfo.code" cssClass="form-control " />
								</div>
							</div>
							<div class="item form-group">
								<label class="col-form-label col-md-3 col-sm-3 label-align"
									for="productInfo.category.name">Category 
								</label>
								<div class="col-md-6 col-sm-6 ">
									<form:input path="productInfo.category.name" cssClass="form-control " />
								</div>
							</div>
							<div class="item form-group">
								<label class="col-form-label col-md-3 col-sm-3 label-align"
									for="productInfo.name">Name 
								</label>
								<div class="col-md-6 col-sm-6 ">
									<form:input path="productInfo.name" cssClass="form-control " />
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
                            <th class="column-title">Category</th>
                            <th class="column-title">Code</th>
                            <th class="column-title">Name</th>
                            <th class="column-title">Image </th>
                            <th class="column-title">Qty </th>
                            <th class="column-title">Price </th>

                            </th>
                          </tr>
                        </thead>

                        <tbody>
                        <c:forEach items="${productInStocks}" var="productInStock" varStatus="loop">
                        
                        <c:choose>
                        	<c:when test="${loop.index %2 == 0 }">
                        		<tr class="even pointer">
                        	</c:when>
                        	<c:otherwise>
                        		<tr class="odd pointer">
                        	</c:otherwise>
                        </c:choose>
                            <td class="">${pageInfo.getOffset() + loop.index+1}</td>
                            <td class="">${productInStock.id}</td>
                            <td class="">${productInStock.productInfo.category.name}</td>
                            <td class="">${productInStock.productInfo.code}</td>
                            <td class="">${productInStock.productInfo.name}</td>
                            <td class=""><img alt="" src='<c:url value="${productInStock.productInfo.imgUrl}"></c:url>' width="100px" height="100px"></td>
                            <td class="">${productInStock.qty}</td>
                            <td class="">${productInStock.price}</td>
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
	$('#searchForm').attr('action','<c:url value="/product-in-stock/list/"/>'+page);
	$('#searchForm').submit();
}
</script>