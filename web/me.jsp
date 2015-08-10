<%-- 
    Document   : me
    Created on : Jul 31, 2015, 12:38:22 PM
    Author     : Harsha Kandra
--%>

<%@page import="java.io.InputStream"%>
<%@page import="java.sql.*,mypackage.*, com.mysql.jdbc.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/header.jsp"/>
        <div class="row" class="col-lg-3">
          <div style="text-align: center">
            <h1>My Profile</h1>
            <p class="lead">Update your profile</p>
          </div>
        </div>
<%
        if(session.getAttribute("user_id") == null){
            response.sendRedirect("login.jsp");
        }

                    //String tempURL=request.getParameter("tempURL");
                    String error = "";
                    
                    String image = "";
                    String q = "select user_photo from user where user_id = " + session.getAttribute("user_id") ;
                    try{
                         ResultSet rs=MysqlConnect.getDbCon().query(q);
                         if(rs.next()){
                            image = rs.getString("user_photo");
                         }else{
                            //error = "No matching records found";
                         }
                    }catch(Exception e){
                        error = e.getMessage();
                    }
                    
                    if(image==null){
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

                <form class="form-horizontal" method="POST" enctype="multipart/form-data" action="upload">
                  <fieldset>
                    <legend>Profile Picture</legend>
                    <div id="disp_tmp_path"></div>
                    <br>
                    <% if(image.length()==0){ %>
                    <img src="${pageContext.request.contextPath}/resources/users/grey_profile.jpg" width="200" />
                    <% }else{ %>
                    <img src="${pageContext.request.contextPath}/resources/users/<%=image%>" width="200" />
                    <% } %>
                    <br>
                    <div id="imageError" style="display:none" class="alert alert-dismissible alert-danger">
                      <button type="button" class="close" data-dismiss="alert">×</button>
                      <strong>Error!</strong> Valid images only
                    </div>
                    <input type="file" id="inputImage" name="inputImage" value="" />
                    <br>
                    <input type="hidden" id="tempURL" />
                    <div class="form-group">
                      <div class="col-lg-5 ">
                        <button type="reset" class="btn btn-default">Reset</button>
                        <button id="send_btn" type="submit" class="btn btn-primary" onclick="return validateImage()">Save Changes</button>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-lg-3">
                          <a class="form-control" href="${pageContext.request.contextPath}/reset.jsp?u=<%=session.getAttribute("user_id")%>&code=<%=session.getAttribute("user_pass")%>">Change Password?</a>
                      </div>
                    </div>
                  </fieldset>
                </form>
            
<script>
  
    function validateImage(){

      var file = $('input[type=file]#inputImage').val();
      var exts = ['png','gif','jpg'];//extensions
      //the file has any value?
      if ( file ) {
        // split file name at dot
        var get_ext = file.split('.');
        // reverse name to check extension
        get_ext = get_ext.reverse();
        // check file type is valid as given in 'exts' array
        if ( $.inArray ( get_ext[0].toLowerCase(), exts ) > -1 ){
          //$("#imagePreview").css("display", "block");
          $("#imageError").css("display", "none");
          //alert($('input[type=file]').val());
          return true;
        } else {
          //$("#imagePreview").css("display", "none");
          $("#imageError").css("display", "block");
          return false;
        }
      }else{
          return true;
      }

        
        
    }

 
  $( document ).ready(function() {
    $('#inputImage').change( function(event) {
    var tmppath = URL.createObjectURL(event.target.files[0]);
        $("img").fadeIn("fast").attr('src',URL.createObjectURL(event.target.files[0]));

        //$("#disp_tmp_path").html("Temporary Path(Copy it and try pasting it in browser address bar) --> <strong>["+tmppath+"]</strong>");
        //$("#tempURL").val(tmppath);
    });
  });
 

</script>
<jsp:include page="/WEB-INF/footer.jsp"/>