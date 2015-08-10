<%-- 
    Document   : reply
    Created on : Jul 31, 2015, 4:41:22 PM
    Author     : Harsha Kandra
--%>

<%@page import="java.sql.*,mypackage.*, com.mysql.jdbc.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/header.jsp"/>
<script src="//tinymce.cachefly.net/4.2/tinymce.min.js"></script>
<script>tinymce.init({selector:'textarea'});</script>
<%
        if(session.getAttribute("user_id") == null){
            response.sendRedirect("login.jsp");
        }
        String otherparty = "";
        String error = "";
        String q = "SELECT user_name from user WHERE user_id = " +request.getParameter("id");
                //insert
                try{
                   ResultSet rs=MysqlConnect.getDbCon().query(q);
                    if(rs.next()){
                        otherparty = rs.getString("user_name");
                    }
                }catch(Exception e){
                    error=e.getMessage();
                }
%>
        <div class="row" class="col-lg-3">
          <div style="text-align: center">
            <h1>Chat with <%=otherparty%></h1>
            <p class="lead"><a href="${pageContext.request.contextPath}/inbox.jsp">Back</a></p>
          </div>
        </div>
<%
        if(session.getAttribute("user_id") == null){
            response.sendRedirect("login.jsp");
        }
        q = "select msg_time,user_name,user_id,msg_text from message,user where msg_sender = user_id and ( (msg_sender="+request.getParameter("id")+" and msg_receiver="+session.getAttribute("user_id")+") or (msg_sender="+session.getAttribute("user_id")+" and msg_receiver="+request.getParameter("id")+") ) order by msg_time asc";
                //insert
                try{
                   ResultSet rs=MysqlConnect.getDbCon().query(q);
                   while(rs.next()){
%>
<div class="panel panel-default"
     <%
                       if(rs.getInt("user_id")==Integer.parseInt(session.getAttribute("user_id").toString())){
                           out.print("style=\"text-align:right\"");
                       }
                       
                       %>
     >
  <div class="panel-heading"><%=rs.getString("user_name")%> on <%=rs.getString("msg_time")%></div>
  <div class="panel-body">
      <%=rs.getString("msg_text")%>
  </div>
</div>
<%
                   }
                }catch(Exception e){
                    error=e.getMessage();
                }
%>
<%
        
        String from=request.getParameter("inputFrom");
        String to=request.getParameter("inputTo");
        String msg=request.getParameter("textArea");
        
        error="";
        
        if(from==null && to==null && msg==null){                     error="";                    }
        else{
            msg=MysqlConnect.getDbCon().SQLEscape(msg);
            if(msg.trim().length()==0){
                error="Message cannot be blank";
            }else{//q = "INSERT INTO `message`(`msg_sender`, `msg_receiver`,`msg_text`) VALUES ("+from+","+to+",'"+msg+"');";
                //insert
                q = "UPDATE `message` set `msg_seen`=1 where `msg_receiver`="+to+" and msg_sender="+from +";";
                //insert
                String q2 = "INSERT INTO `message`(`msg_sender`, `msg_receiver`,`msg_text`) VALUES ("+from+","+to+",'"+msg+"');";
                try{
                   int ok = MysqlConnect.getDbCon().insert(q);
                   ok = MysqlConnect.getDbCon().insert(q2);
                   response.sendRedirect("inbox.jsp");
                }catch(Exception e){
                    error = e.getMessage() + q;
                }
                //redirect
            }
        }
%>
<% if(error.length()>0){
%>
<div id ="new"><hr></div>
<div class="alert alert-dismissible alert-warning">
  <button type="button" class="close" data-dismiss="alert">×</button>
  <h4>Error!</h4>
  <p><%=error%></p>
</div>
<%
}
%>
    <form class="form-horizontal" method="POST" id="new">
                  <fieldset>
                      <legend>Reply to <%=otherparty%></legend>

                        <input class="form-control" id="inputFrom" name="inputFrom" type="hidden" value="<%=session.getAttribute("user_id")%>">
                        <input class="form-control" id="inputTo" name="inputTo" type="hidden" value="<%=request.getParameter("id")%>">

                <div class="form-group">
                    <label for="textArea" class="col-lg-2 control-label">Message</label>
                    <div class="col-lg-10">
                      <textarea name="textArea" class="form-control" rows="3" id="textArea"></textarea>
                      <span class="help-block">Enter your message here</span>
                    </div>
                  </div>
                    <div class="form-group">
                      <div class="col-lg-5 col-lg-offset-2">
                        <button type="reset" class="btn btn-default">Reset</button>
                        <button type="submit" class="btn btn-primary">Send</button>
                      </div>
                    </div>
                  </fieldset>
                </form>
<jsp:include page="/WEB-INF/footer.jsp"/>