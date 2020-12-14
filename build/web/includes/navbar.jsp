<%-- 
    Document   : navbar
    Created on : Jun 3, 2020, 7:49:35 AM
    Author     : Tommy
--%>

<%@page import="com.chat.connect"%>
<%@page import="com.chat.getStuff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Navbar</title>
        <%
            getStuff obj = new getStuff();
            connect conn = new connect();
            String id = session.getAttribute("logged").toString();
        %>
    </head>
    <body>
        <nav class="navbar navbar-expand-sm bg-light justify-content-center navbar-light fixed-bottom">
            <a class="navbar-brand" href="index">TomChat</a>
            
            <form class="form-inline" action="/action_page.php" style="padding-left: 10px; padding-right: 10px;">
                <div class="input-group">
                    <input class="form-control" type="search" placeholder="Search...">
                    <div class="input-group-append">
                        <button class="btn btn-secondary" type="submit"><i class="fa fa-search"></i></button>
                    </div>
                </div>
            </form>
            <!-- Links -->
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="profile?id=<%=id%>" >Profile</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="index">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="people">Find People</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="messages">Messages</a>
                </li>
                <!--
                <li class="nav-item">
                    <a class="nav-link" href="#">Settings</a>
                </li> -->
                <li class="nav-item">
                    <a class="nav-link" href="logout">Logout</a>
                </li>

            </ul>

        </nav>
    </body>
</html>
