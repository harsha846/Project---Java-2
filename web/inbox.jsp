<%-- 
    Document   : inbox
    Created on : Jul 31, 2015, 2:19:06 PM
    Author     : Harsha Kandra
--%>
<%@page import="java.sql.*,mypackage.*, com.mysql.jdbc.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/header.jsp"/>
        <div class="row" class="col-lg-3">
          <div style="text-align: center">
            <h1>Inbox</h1>
            <p class="lead">View Conversations | <a href="${pageContext.request.contextPath}/compose.jsp">New Conversation</a></p>
          </div>
        </div>
<%
        if(session.getAttribute("user_id") == null){
            response.sendRedirect("login.jsp");
        }
%>
<% //datatables %>
<table id="messages" class="display" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th>Date</th>
                <th>From</th>
                <th>Actions</th>
            </tr>
        </thead>
 
        <tbody>
        <%
            String q = "SELECT `msg_id`, `msg_time`,`msg_sender`,user_name FROM `message`,user WHERE msg_sender = user_id  and msg_seen = 0 and msg_receiver = "+session.getAttribute("user_id")+" order by msg_time desc";
                //insert
                try{
                   ResultSet rs=MysqlConnect.getDbCon().query(q);
                   int count = 0;
                    while(rs.next()){
                        count++;
                        out.print("<tr><td>"+rs.getString("msg_time")+"</td><td>"+rs.getString("user_name")+"</td>");
        %><td><a href="${pageContext.request.contextPath}<% out.print("/reply.jsp?id="+Integer.toString(rs.getInt("msg_sender"))+"#new\">View</a></td></tr>");
                    }
                    if(count==0){
                         out.print("<tr><h1>No Messages</h1></tr>");
                    }
                }catch(Exception e){
                    out.print(e.getMessage());
                }
                //redirect
           
        %>
        </tbody>
    </table>
  </div>
    <script type="text/javascript" language="javascript" class="init">
        $(document).ready(function () {
            $('#messages').dataTable({
                "order": [[0, "desc"]]
            });
        });
	</script>
<jsp:include page="/WEB-INF/footer.jsp"/>