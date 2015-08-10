<%-- 
    Document   : login
    Created on : Jul 31, 2015, 10:08:28 AM
    Author     : Harsha Kandra
--%>

<%@page import="java.sql.*,mypackage.*, com.mysql.jdbc.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/header.jsp"/>
        <div class="row" class="col-lg-3">
          <div style="text-align: center">
            <h1>Login</h1>
          </div>
        </div>
<%
        if(session.getAttribute("user_id") != null){
            response.sendRedirect("loggedin.jsp");
        }
                    String user=request.getParameter("inputEmail");
                    String pass=request.getParameter("inputPassword");
                    
                    
                    String error = "";
                    if(pass!=null){
                        pass = MysqlConnect.getDbCon().SQLEscape(pass);
                    }
                    String q = "select * from user where (user_email = '" + user + "' or user_name = '" + user + "') and user_pass = md5('" + pass +"')";
                    try{
                         ResultSet rs=MysqlConnect.getDbCon().query(q);
                         if(rs.next()){
                            session = request.getSession();
                            session.setAttribute("user_id", Integer.toString(rs.getInt("user_id")));
                            session.setAttribute("user_name", rs.getString("user_name"));
                            session.setAttribute("user_photo", rs.getString("user_photo"));
                            session.setAttribute("user_pass", rs.getString("user_pass"));
                            //setting session to expiry in 30 mins
                            session.setMaxInactiveInterval(30*60);
                            //Cookie user_id = new Cookie("user_id", user);
                            //user_id.setMaxAge(30*60);
                            //response.addCookie(user_id);
                            response.sendRedirect("index.jsp");
                         }else{
                             error = "No matching records found";
                         }
                    }catch(Exception e){
                        error = e.getMessage();
                    }
                    
                    if(user==null && pass==null){
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

                <form class="form-horizontal" method="POST">
                  <fieldset>
                    <legend>Login to your account</legend>
                    <div class="form-group">
                      <label for="inputEmail" class="col-lg-2 control-label">Email</label>
                      <div class="col-lg-3">
                        <input style="background-image: url(&quot;data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAASCAYAAABSO15qAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3QsPDhss3LcOZQAAAU5JREFUOMvdkzFLA0EQhd/bO7iIYmklaCUopLAQA6KNaawt9BeIgnUwLHPJRchfEBR7CyGWgiDY2SlIQBT/gDaCoGDudiy8SLwkBiwz1c7y+GZ25i0wnFEqlSZFZKGdi8iiiOR7aU32QkR2c7ncPcljAARAkgckb8IwrGf1fg/oJ8lRAHkR2VDVmOQ8AKjqY1bMHgCGYXhFchnAg6omJGcBXEZRtNoXYK2dMsaMt1qtD9/3p40x5yS9tHICYF1Vn0mOxXH8Uq/Xb389wff9PQDbQRB0t/QNOiPZ1h4B2MoO0fxnYz8dOOcOVbWhqq8kJzzPa3RAXZIkawCenHMjJN/+GiIqlcoFgKKq3pEMAMwAuCa5VK1W3SAfbAIopum+cy5KzwXn3M5AI6XVYlVt1mq1U8/zTlS1CeC9j2+6o1wuz1lrVzpWXLDWTg3pz/0CQnd2Jos49xUAAAAASUVORK5CYII=&quot;); background-repeat: no-repeat; background-attachment: scroll; background-position: right center; cursor: auto;" class="form-control" id="inputEmail" name="inputEmail" placeholder="Email or Username" type="text" minlength="4" required>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputPassword" class="col-lg-2 control-label">Password</label>
                      <div class="col-lg-3">
                        <input style="background-image: url(&quot;data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAASCAYAAABSO15qAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3QsPDhss3LcOZQAAAU5JREFUOMvdkzFLA0EQhd/bO7iIYmklaCUopLAQA6KNaawt9BeIgnUwLHPJRchfEBR7CyGWgiDY2SlIQBT/gDaCoGDudiy8SLwkBiwz1c7y+GZ25i0wnFEqlSZFZKGdi8iiiOR7aU32QkR2c7ncPcljAARAkgckb8IwrGf1fg/oJ8lRAHkR2VDVmOQ8AKjqY1bMHgCGYXhFchnAg6omJGcBXEZRtNoXYK2dMsaMt1qtD9/3p40x5yS9tHICYF1Vn0mOxXH8Uq/Xb389wff9PQDbQRB0t/QNOiPZ1h4B2MoO0fxnYz8dOOcOVbWhqq8kJzzPa3RAXZIkawCenHMjJN/+GiIqlcoFgKKq3pEMAMwAuCa5VK1W3SAfbAIopum+cy5KzwXn3M5AI6XVYlVt1mq1U8/zTlS1CeC9j2+6o1wuz1lrVzpWXLDWTg3pz/0CQnd2Jos49xUAAAAASUVORK5CYII=&quot;); background-repeat: no-repeat; background-attachment: scroll; background-position: right center;" class="form-control" id="inputPassword" name="inputPassword" placeholder="Password" type="password" required>
                      </div>
                    </div>

                    <div class="form-group">
                      <div class="col-lg-5 col-lg-offset-1">
                        <button type="reset" class="btn btn-default">Reset</button>
                        <button type="submit" class="btn btn-primary">Login</button>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-lg-3">
                          <a class="form-control" href="${pageContext.request.contextPath}/forgot.jsp">Forgot Password?</a>
                      </div>
                    </div>
                  </fieldset>
                </form>
            
      
<jsp:include page="/WEB-INF/footer.jsp"/>
