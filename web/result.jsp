<%-- 
    Document   : result
    Created on : Jul 31, 2015, 10:02:52 PM
    Author     : Harsha Kandra
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/header.jsp"/>
        <div class="row" class="col-lg-3">
          <div style="text-align: center">
            <h1>${requestScope["message"]}</h1>
          </div>
        </div>
<jsp:include page="/WEB-INF/footer.jsp"/>