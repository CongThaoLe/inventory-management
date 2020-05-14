<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
                     <ul class="pagination pagination-lg pager">
                      	<c:forEach begin="1" end="${pageInfo.totalPages}" varStatus="loop">
                      		<c:choose>
                      			<c:when test="${pageInfo.indexPage == loop.index }">
                      				<li class="active paginate_button "><a href="javascript:void(0);">${loop.index}</a></li>
                      			</c:when>
                      			<c:otherwise>
                      				<li><a href="javascript:void(0);" onclick="gotoPage(${loop.index});">${loop.index}</a></li>
                      			</c:otherwise>
                      		</c:choose>
                      	</c:forEach>
                      </ul>