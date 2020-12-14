<%-- 
    Document   : post_controller
    Created on : Jun 4, 2020, 10:17:04 PM
    Author     : Tommy
--%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="com.chat.connect"%>
<%@page import="com.chat.getStuff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Post</title>
    </head>
    <body>
        <%
            getStuff obj = new getStuff();
            connect conn = new connect();
            
            java.util.Date utilDate = new java.util.Date();
            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
            java.sql.Time sqlTime = new java.sql.Time(utilDate.getTime());
            
            /**
            LocalDateTime now = LocalDateTime.now();
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-mm-dd");
            String date = dtf.format(now);
            
            dtf = DateTimeFormatter.ofPattern("hh:mm:ss");
            String time = dtf.format(now);
            * */
            int id = obj.getLastId("POST");
            String poster = session.getAttribute("logged").toString();
            String content = request.getParameter("content");
            String status = request.getParameter("status");
            if(status == null){
                status = "1";
            }else{
                status = "2";
            }
            
            String query = "INSERT INTO POST(ID, POSTER, CONTENT, STATUS, DATE, TIME) VALUES(?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.conn().prepareStatement(query);
            stmt.setInt(1, id);
            stmt.setString(2, poster);
            stmt.setString(3, content);
            stmt.setString(4, status);
            stmt.setDate(5, sqlDate );
            stmt.setTime(6, sqlTime);
            stmt.executeUpdate();
            response.sendRedirect("index");
            
        %>
    </body>
</html>
