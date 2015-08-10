<%-- 
    Document   : reset
    Created on : Jul 31, 2015, 7:34:58 PM
    Author     : Harsha Kandra
--%>

<%@page import="java.sql.*,mypackage.*, com.mysql.jdbc.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/header.jsp"/>
        <div class="row" class="col-lg-3">
          <div style="text-align: center">
            <h1>Reset Password</h1>
          </div>
        </div>
<%
        if(request.getParameter("u") == null && request.getParameter("code") == null){
            response.sendRedirect("error.jsp");
        }
            String error = "";
            String pass1=request.getParameter("inputPassword1");
            String pass2=request.getParameter("inputPassword2");

                    //different passwords
                    if(!(pass1==null && pass2==null) && pass1.compareTo(pass2)!=0){
                        error = error + "\nPasswords don't match";
                    }
                    
                    //taken username
                    String q = "select * from user where user_id = " + request.getParameter("u") + " and user_pass='" + request.getParameter("code")  + "'";
                    try{
                         ResultSet rs=MysqlConnect.getDbCon().query(q);
                         if(rs.next()){
                             
                         }else{
                             response.sendRedirect("error.jsp");
                         }
                    }catch(Exception e){
                        error = e.getMessage();
                    }
                    
                    if(pass1==null && pass2==null){
                        error="";
                    }else if(error.length()==0){
                        q = "update `user` set `user_pass`=md5('"+MysqlConnect.getDbCon().SQLEscape(pass1)+"') where user_id = " + request.getParameter("u");
                        try{
                             int rs=MysqlConnect.getDbCon().insert(q);
                             response.sendRedirect("logout.jsp");
                        }catch(Exception e){
                            error = e.getMessage();
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
                    <legend>Enter New Password</legend>
                    <div class="form-group">
                      <label for="inputPassword1" class="col-lg-2 control-label">New Password</label>
                      <div class="col-lg-3">
                          <input style="background-image: url(&quot;data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAASCAYAAABSO15qAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3QsPDhss3LcOZQAAAU5JREFUOMvdkzFLA0EQhd/bO7iIYmklaCUopLAQA6KNaawt9BeIgnUwLHPJRchfEBR7CyGWgiDY2SlIQBT/gDaCoGDudiy8SLwkBiwz1c7y+GZ25i0wnFEqlSZFZKGdi8iiiOR7aU32QkR2c7ncPcljAARAkgckb8IwrGf1fg/oJ8lRAHkR2VDVmOQ8AKjqY1bMHgCGYXhFchnAg6omJGcBXEZRtNoXYK2dMsaMt1qtD9/3p40x5yS9tHICYF1Vn0mOxXH8Uq/Xb389wff9PQDbQRB0t/QNOiPZ1h4B2MoO0fxnYz8dOOcOVbWhqq8kJzzPa3RAXZIkawCenHMjJN/+GiIqlcoFgKKq3pEMAMwAuCa5VK1W3SAfbAIopum+cy5KzwXn3M5AI6XVYlVt1mq1U8/zTlS1CeC9j2+6o1wuz1lrVzpWXLDWTg3pz/0CQnd2Jos49xUAAAAASUVORK5CYII=&quot;); background-repeat: no-repeat; background-attachment: scroll; background-position: right center;" class="form-control" id="inputPassword1" name="inputPassword1" placeholder="Password" type="password" type="text" minlength=6 maxlength=20 title="6 to 20 characters" required>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="inputPassword2" class="col-lg-2 control-label">New Password Again</label>
                      <div class="col-lg-3">
                        <input style="background-image: url(&quot;data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAASCAYAAABSO15qAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3QsPDhss3LcOZQAAAU5JREFUOMvdkzFLA0EQhd/bO7iIYmklaCUopLAQA6KNaawt9BeIgnUwLHPJRchfEBR7CyGWgiDY2SlIQBT/gDaCoGDudiy8SLwkBiwz1c7y+GZ25i0wnFEqlSZFZKGdi8iiiOR7aU32QkR2c7ncPcljAARAkgckb8IwrGf1fg/oJ8lRAHkR2VDVmOQ8AKjqY1bMHgCGYXhFchnAg6omJGcBXEZRtNoXYK2dMsaMt1qtD9/3p40x5yS9tHICYF1Vn0mOxXH8Uq/Xb389wff9PQDbQRB0t/QNOiPZ1h4B2MoO0fxnYz8dOOcOVbWhqq8kJzzPa3RAXZIkawCenHMjJN/+GiIqlcoFgKKq3pEMAMwAuCa5VK1W3SAfbAIopum+cy5KzwXn3M5AI6XVYlVt1mq1U8/zTlS1CeC9j2+6o1wuz1lrVzpWXLDWTg3pz/0CQnd2Jos49xUAAAAASUVORK5CYII=&quot;); background-repeat: no-repeat; background-attachment: scroll; background-position: right center;" class="form-control" id="inputPassword2" name="inputPassword2" placeholder="Password Again" type="password" minlength=6 maxlength=20 title="6 to 20 characters" required>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-lg-5 col-lg-offset-1">
                        <button type="reset" class="btn btn-default">Reset</button>
                        <button type="submit" class="btn btn-primary">Change</button>
                      </div>
                    </div>
                  </fieldset>
                </form>
            
      
<jsp:include page="/WEB-INF/footer.jsp"/>
