<%-- 
    Document   : loggedin
    Created on : Jul 31, 2015, 11:02:09 AM
    Author     : Harsha Kandra
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/header.jsp"/>
        <div class="row" class="col-lg-3">
          <div style="text-align: center">
            <h1>You're already logged in</h1>
            <p class="lead">Click <a href="${pageContext.request.contextPath}/logout.jsp">here</a> to logout</p>
          </div>
        </div>
<jsp:include page="/WEB-INF/footer.jsp"/>
