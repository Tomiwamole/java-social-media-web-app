<%-- 
    Document   : login_controller
    Created on : Jun 4, 2020, 12:30:49 AM
    Author     : Tommy
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.chat.getStuff"%>
<%@page import="com.chat.connect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Controller</title>
    </head>
    <body>
        <%
            getStuff obj = new getStuff();
            connect conn = new connect();

            int id = 0;
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            try {
                String query = "SELECT * FROM users WHERE EMAIL = ? AND PASSWORD = ?";
                PreparedStatement stmt = conn.conn().prepareStatement(query);
                stmt.setString(1, email);
                stmt.setString(2, password);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    id = rs.getInt("ID");
                    session.setAttribute("logged", id);
                    query = "UPDATE USERS SET ACTIVE = 1 WHERE ID = " + id;
                    Statement stmts = conn.conn().createStatement();
                    stmts.executeUpdate(query);
                    response.sendRedirect("index");
                } else {
                    session.setAttribute("logged", "error3");
                    response.sendRedirect("login");
                }
            } catch (SQLException | NullPointerException ex) {
                session.setAttribute("logged", "error4");
                response.sendRedirect("login");
            }

        %>
    </body>
</html>
