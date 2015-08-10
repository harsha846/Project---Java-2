<%-- 
    Document   : forgot
    Created on : Jul 31, 2015, 7:22:58 PM
    Author     : Harsha Kandra
--%>

<%@page import="java.sql.*,mypackage.*, com.mysql.jdbc.Connection, org.apache.commons.mail.*;"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/header.jsp"/>
        <div class="row" class="col-lg-3">
          <div style="text-align: center">
            <h1>Password Recovery</h1>
          </div>
        </div>
<%
        if(session.getAttribute("user_id") != null){
            response.sendRedirect("loggedin.jsp");
        }
                    String user=request.getParameter("inputEmail");

                    String error = "";
                    String good = "";
                    String q = "select * from user where (user_email = '" + user + "' or user_name = '" + user + "')";
                    try{
                         ResultSet rs=MysqlConnect.getDbCon().query(q);
                         if(rs.next()){
                            String server =  "http://"+request.getServerName() +":"+ request.getServerPort() + request.getContextPath();
                            //String msgBody = "Dear "+ rs.getString("user_name")+", \nClick here to reset your password : <a href=\"";
                            //msgBody+=server+"/reset.jsp?u="+Integer.toString(rs.getInt("user_id"))+"&code="+rs.getString("user_pass");
                            //msgBody+= "\">Reset</a>\nThank You!\n\nAdd admin@harsha.com to your contact list to make sure future emails won't be in spam";
                            //javaMail mailer = new javaMail();
                           //mailer.recoveryMail(rs.getString("user_email"), rs.getString("user_name"), Integer.toString(rs.getInt("user_id")), rs.getString("user_pass"), "http://www.harsha.com");
                            //SendMail sendmail = new SendMail("admin@harsha.com",rs.getString("user_email"),"Password Reset for " + rs.getString("user_name"),msgBody);
                            //sendmail.send();
                            String msgBody = "Dear "+ rs.getString("user_name")+", \nVisit this link to reset your password : ";
                            msgBody+=server+"/reset.jsp?u="+Integer.toString(rs.getInt("user_id"))+"&code="+rs.getString("user_pass");
                            msgBody+= "\nThank You!\n\nAdd admin@harsha.com to your contact list to make sure future emails won't be in spam";
                            
                            Email email = new SimpleEmail();
                            //HtmlEmail email = new HtmlEmail();
                            email.setHostName("mail.weclick.lk");
                            email.setSmtpPort(25);
                            email.setAuthenticator(new DefaultAuthenticator("harsha@weclick.lk", "9Sy9gdShib1sr0jwojdh"));
                            email.setSSLOnConnect(true);
                            email.setFrom("admin@harsha.com");
                            email.setSubject("Password Reset for " + rs.getString("user_name"));
                            email.setMsg(msgBody);
                            //email.setHtmlMsg("<html>"+msgBody+"</html>");
                            email.addTo(rs.getString("user_email"));
                            email.send();

                            
                            good = "Password recovery information has been emailed to " + rs.getString("user_email") + "<br>Make sure you check SPAM folders also";
                         }else{
                             error = "No matching records found";
                         }
                    }catch(Exception e){
                        error = e.getMessage();
                    }
                    
                    if(user==null){
                        error="";
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
<% if(good.length()>0){
%>
<div class="alert alert-dismissible alert-success">
  <button type="button" class="close" data-dismiss="alert">×</button>
  <h4>Success!</h4>
  <p><%=good%></p>
</div>
<%
}
%>
                <form class="form-horizontal" method="POST">
                  <fieldset>
                    <legend>Help us dentify your account</legend>
                    <div class="form-group">
                      <label for="inputEmail" class="col-lg-2 control-label">Email or Username</label>
                      <div class="col-lg-3">
                        <input style="background-image: url(&quot;data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAASCAYAAABSO15qAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3QsPDhss3LcOZQAAAU5JREFUOMvdkzFLA0EQhd/bO7iIYmklaCUopLAQA6KNaawt9BeIgnUwLHPJRchfEBR7CyGWgiDY2SlIQBT/gDaCoGDudiy8SLwkBiwz1c7y+GZ25i0wnFEqlSZFZKGdi8iiiOR7aU32QkR2c7ncPcljAARAkgckb8IwrGf1fg/oJ8lRAHkR2VDVmOQ8AKjqY1bMHgCGYXhFchnAg6omJGcBXEZRtNoXYK2dMsaMt1qtD9/3p40x5yS9tHICYF1Vn0mOxXH8Uq/Xb389wff9PQDbQRB0t/QNOiPZ1h4B2MoO0fxnYz8dOOcOVbWhqq8kJzzPa3RAXZIkawCenHMjJN/+GiIqlcoFgKKq3pEMAMwAuCa5VK1W3SAfbAIopum+cy5KzwXn3M5AI6XVYlVt1mq1U8/zTlS1CeC9j2+6o1wuz1lrVzpWXLDWTg3pz/0CQnd2Jos49xUAAAAASUVORK5CYII=&quot;); background-repeat: no-repeat; background-attachment: scroll; background-position: right center; cursor: auto;" class="form-control" id="inputEmail" name="inputEmail" placeholder="Email or Username" type="text" minlength="4" pattern="[0-9|a-z|A-Z]{1,10}|[0-9|a-z|A-Z|_-]{1,}\@[0-9|a-z|A-Z|_-]{3,}\.[0-9|a-z|A-Z|_-]{1,}" required>
                      </div>
                    </div>

                    <div class="form-group">
                      <div class="col-lg-5 col-lg-offset-1">
                        <button type="reset" class="btn btn-default">Reset</button>
                        <button type="submit" class="btn btn-primary">Check</button>
                      </div>
                    </div>
                  </fieldset>
                </form>
            
      
<jsp:include page="/WEB-INF/footer.jsp"/>
