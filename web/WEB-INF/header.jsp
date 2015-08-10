<%-- 
    Document   : header
    Created on : Jul 31, 2015, 9:43:09 AM
    Author     : Harsha Kandra
--%>
<%@page import="java.sql.*,mypackage.*, com.mysql.jdbc.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>HarshaCMS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link rel="stylesheet" href="http://bootswatch.com/assets/css/bootswatch.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/jquery.dataTables.css"> 
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" language="javascript" src="${pageContext.request.contextPath}/resources/jquery.dataTables.js"></script>
  </head>
  <body>
    <div class="navbar navbar-default navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <a href="${pageContext.request.contextPath}" class="navbar-brand">HarshaCMS</a>
          <button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#navbar-main">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
        </div>
<%
        session = request.getSession(false);
        if(session.getAttribute("user_id") != null){ //logged in menu
            int msgcount=0;
            String q="select count(*) c from message where msg_seen=0 and msg_receiver="+session.getAttribute("user_id").toString();
        try{
                ResultSet rs=MysqlConnect.getDbCon().query(q);
                if(rs.next()){
                    msgcount=rs.getInt("c");
                }
                }catch(Exception e){
                    msgcount = 0;
                }
%>

        <div class="navbar-collapse collapse" id="navbar-main">
          <ul class="nav navbar-nav">
            <li><a href="${pageContext.request.contextPath}/me.jsp">Logged in as <span class="badge"><%=session.getAttribute("user_name")%></span></a></li>
            <li><a href="${pageContext.request.contextPath}/inbox.jsp">Messages <span class="badge"><%=msgcount%></span></a></li>
          </ul>

          <ul class="nav navbar-nav navbar-right">
            <li>
                <p class="navbar-btn">
                    <a href="${pageContext.request.contextPath}/logout.jsp" class="btn btn-danger" style="margin-left: 5px">Logout</a>
                </p>
            </li>
          </ul>

        </div>

<%
        }else{ //not logged in
%>
        <div class="navbar-collapse collapse" id="navbar-main">
          <ul class="nav navbar-nav">
            <li>
              <a href="${pageContext.request.contextPath}">Home</a>
            </li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <li>
                <p class="navbar-btn">
                    <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-primary">Sign Up Now!</a>
                </p>
            </li>
            <li>
                <p class="navbar-btn">
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-success" style="margin-left: 5px">Login</a>
                </p>
            </li>
          </ul>

        </div>
<% } %>
        
      </div>
    </div>


    <div class="container">
