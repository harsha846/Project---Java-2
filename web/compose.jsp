<%-- 
    Document   : compose
    Created on : Jul 31, 2015, 2:19:06 PM
    Author     : Harsha Kandra
--%>
<%@page import="java.sql.*,mypackage.*, com.mysql.jdbc.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/header.jsp"/>
<script src="//tinymce.cachefly.net/4.2/tinymce.min.js"></script>
<script>tinymce.init({selector:'textarea'});</script>

        <div class="row" class="col-lg-3">
          <div style="text-align: center">
            <h1>Inbox</h1>
            <p class="lead"><a href="${pageContext.request.contextPath}/inbox.jsp">View Conversations</a> | New Conversation</p>
          </div>
        </div>
<%
        if(session.getAttribute("user_id") == null){
            response.sendRedirect("login.jsp");
        }
        
        String from=request.getParameter("inputFromID");
        String to=request.getParameter("inputTo");
        String msg=request.getParameter("textArea");
        
        String error="";
        
        if(from==null && to==null && msg==null){                     error="";                    }
        else{
            msg=MysqlConnect.getDbCon().SQLEscape(msg);
            if(msg.trim().length()==0){
                error="Message cannot be blank";
            }else{
                String q = "UPDATE `message` set `msg_seen`=1 where `msg_receiver`="+to+" and msg_sender="+from +";";
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
<div class="alert alert-dismissible alert-warning">
  <button type="button" class="close" data-dismiss="alert">×</button>
  <h4>Error!</h4>
  <p><%=error%></p>
</div>
<%
}
%>
<form class="form-horizontal" method="POST">
                  <fieldset>
                    <div class="form-group">
                      <label for="inputFrom" class="col-lg-2 control-label">From</label>
                      <div class="col-lg-3">
                        <input class="form-control" id="inputFrom" name="inputFrom" type="text" disabled value="<%=session.getAttribute("user_name")%>">
                        <input class="form-control" id="inputFromID" name="inputFromID" type="hidden" value="<%=session.getAttribute("user_id")%>">
                      </div>
                    </div>
                    <div class="form-group">
                        <label for="select" class="col-lg-2 control-label">To</label>
                        <div class="col-lg-3">
                          <select class="form-control" name="inputTo" id="inputTo">
                              <%
                                String q = "select user_id,user_name from user where user_id <> " + session.getAttribute("user_id") + "";
                                try{
                                     ResultSet rs=MysqlConnect.getDbCon().query(q);
                                     while(rs.next()){
                                          out.print( "<option value=\"" + Integer.toString(rs.getInt("user_id")) + "\">" + rs.getString("user_name") + "</option>");
                                     }
                                }catch(Exception e){
                                    out.print(e.getMessage());
                                }
                              %>
                          </select>
                        </div>
                  </div>
                <div class="form-group">
                    <label for="textArea" class="col-lg-2 control-label">Message</label>
                    <div class="col-lg-10">
                      <textarea name="textArea" class="form-control" rows="3" id="textArea"></textarea>
                      <span class="help-block">Enter your message here</span>
                    </div>
                  </div>
                    <div class="form-group">
                      <div class="col-lg-5 col-lg-offset-1">
                        <button type="reset" class="btn btn-default">Reset</button>
                        <button type="submit" class="btn btn-primary">Send</button>
                      </div>
                    </div>
                  </fieldset>
                </form>
<jsp:include page="/WEB-INF/footer.jsp"/>
