<%-- 
    Document   : signup_controller
    Created on : Jun 4, 2020, 12:30:39 AM
    Author     : Tommy
--%>

<%@page import="java.lang.NullPointerException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.chat.connect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.chat.getStuff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Signup Controller</title>
    </head>
    <body>
        <%
            getStuff obj = new getStuff();
            connect conn = new connect();
            int id = obj.getLastId("USERS");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String about = request.getParameter("about");
            //String dob = request.getParameter("dob");
            String gender = request.getParameter("gender");

            try {
                String query = "SELECT * FROM users WHERE EMAIL = '" + email + "'";
                ResultSet rs = obj.select(query);
                int num = obj.getTotalRows(rs);
                if (num == 0) {
                    query = "INSERT INTO users(ID, NAME, EMAIL, USERNAME, ABOUT, PASSWORD, GENDER, ACTIVE) VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement stmt = conn.conn().prepareStatement(query);
                    stmt.setInt(1, id);
                    stmt.setString(2, name);
                    stmt.setString(3, email);
                    stmt.setString(4, username);
                    stmt.setString(5, about);
                    stmt.setString(6, password);
                    stmt.setString(7, gender);
                    stmt.setInt(8, 1);
                    int action = stmt.executeUpdate();
                    if (action > 0) {
                        out.print("hi");
                        session.setAttribute("logged", id);
                        response.sendRedirect("index");
                    } else {
                        session.setAttribute("logged", "error1");
                        response.sendRedirect("signup");
                    }
                } else {
                    session.setAttribute("logged", "error2");
                    response.sendRedirect("signup");
                }
            } catch (SQLException | NullPointerException ex) {
                session.setAttribute("logged", "error1");
                response.sendRedirect("signup");
            }

        %>
    </body>
</html>
