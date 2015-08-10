<%-- 
    Document   : logout
    Created on : Jul 31, 2015, 12:02:02 PM
    Author     : Harsha Kandra
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/header.jsp"/>
        <div class="row" class="col-lg-3">
          <div style="text-align: center">
            <h1>Logging out</h1>
            <p class="lead">please wait</p>
          </div>
        </div>
<jsp:include page="/WEB-INF/footer.jsp"/>
<%
//log out
        //invalidate the session if exists
        session = request.getSession(false);
        if(session != null){
            session.invalidate();
        }
        response.sendRedirect("login.jsp");
%>
