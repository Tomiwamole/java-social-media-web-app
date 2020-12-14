<%-- 
    Document   : send_friendrequest
    Created on : Jun 7, 2020, 9:44:27 PM
    Author     : Tommy
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.chat.connect"%>
<%@page import="com.chat.getStuff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            getStuff obj = new getStuff();
            connect conn = new connect();
            String id = request.getParameter("id");
            int realid = Integer.parseInt(session.getAttribute("logged").toString());
            
            String query = "INSERT INTO REQUESTS(ID, \"FIRST\", \"SECOND\") VALUES(?, ?, ?)";
            PreparedStatement stmt = conn.conn().prepareStatement(query);
            stmt.setInt(1, obj.getLastId("REQUESTS"));
            stmt.setInt(2, realid);
            stmt.setString(3, id);
            stmt.execute();
            response.sendRedirect("profile?id="+id);
            
        %>
    </body>
</html>
