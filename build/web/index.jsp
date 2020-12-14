<%-- 
    Document   : index.jsp
    Created on : Jun 2, 2020, 1:26:04 PM
    Author     : Tommy
--%>

<%@page import="java.util.List"%>
<%@page import="com.chat.getStuff"%>
<%@page import="com.chat.connect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%if (session.getAttribute("logged") == null || session.getAttribute("logged") == "") {
                response.sendRedirect("login");
            }%>
        <jsp:include page="styles"></jsp:include>
            <title>Tom Chat</title>

        </head>
        <body>
        <%
            getStuff obj = new getStuff();
            connect conn = new connect();
            int realid = Integer.parseInt(session.getAttribute("logged").toString());
            //out.print(session.getAttribute("logged").toString());
        %>
        <jsp:include page="navbar"></jsp:include>
            <div class="container posts">
                <div class="row">
                <jsp:include page="sideprofile"></jsp:include>

                    <div class="col-md-6" style="overflow:auto;">
                        <div class="card">
                            <div class="card-header" style="padding: 7px;">
                                <b>Create A New Post</b>
                            </div>
                            <div class="card-body" style="padding: 7px;">
                                <form method="post" action="post_controller">
                                    <textarea class="form-control" rows="2" placeholder="Talk about how you feel.." name="content" required=""></textarea>
                                    Privacy Status:
                                    <input type="checkbox" class="custom-checkbox" name="status">&nbsp;Everyone
                                    <input type="checkbox" class="custom-checkbox" checked="" disabled="">&nbsp;Friends
                                    <hr>
                                    <div class="text-center">
                                        <input type="submit" class="btn btn-secondary" value="Post...">
                                    </div>
                                </form>
                            </div>
                        </div>

                    <%
                        String query = "SELECT * FROM POST WHERE STATUS = 2 OR POSTER = " + realid + " OR POSTER IN "
                                + "(SELECT FRIEND FROM FRIENDS WHERE \"USER\" = " + realid + ") ORDER BY ID DESC";
                        Statement stmt = conn.conn().createStatement();
                        ResultSet rs = stmt.executeQuery(query);
                        if (obj.getTotalRows(rs) == 0) {
                    %>
                    <br>
                    <div class="text-center"><h1 class="heading">No Posts Yet</h1></div>
                    <%
                        }
                        rs = stmt.executeQuery(query);
                        while (rs.next()) {
                            List arr = obj.getUser("*", "ID", rs.getString("poster"));
                    %>
                    <div class="card">
                        <div class="card-body" style="padding: 10px;">

                            <div class="row">
                                <div class="col-md-6">
                                    <a href="profile?id=<% out.print(arr.get(0));%>" class="poster"><% out.print(arr.get(1));%></a>
                                </div>
                                <div class="col-md-6 text-right">
                                    <span><%=rs.getString("date")%> <%=rs.getString("time")%></span>
                                </div>
                            </div>
                            <hr>

                            <div class="text-center"><%=rs.getString("content")%></div>
                            <hr>

                            <%
                                String likesql = "SELECT * FROM LIKES WHERE POST = " + rs.getInt("ID");
                                ResultSet res = obj.select(likesql);
                                int likes = obj.getTotalRows(res);
                                String comsql = "SELECT * FROM COMMENTS WHERE POST = " + rs.getInt("ID") + " ORDER BY ID DESC";
                                res = obj.select(comsql);
                                int comments = obj.getTotalRows(res);
                            %>

                            <div class="row">
                                <div class="col-md-6">
                                    <!--
                                    <b><%=likes%></b> Likes -->
                                </div>
                                <div class="col-md-6 text-right">
                                    <b><%=comments%></b> comments
                                </div>
                            </div>
                            <hr>

                            <div class="comments">

                                <%
                                    res = obj.select(comsql);
                                    while (res.next()) {
                                        int commenter = res.getInt("commenter");
                                        List ar = obj.getUser("*", "ID", String.valueOf(commenter));
                                %>
                                <a href="profile?id=<%=ar.get(0)%>" class="poster"><%=ar.get(1)%></a> =>
                                <%=res.getString("comment")%>&nbsp;<b>(<%=res.getString("date")%> <%=res.getString("time")%>)</b><br>
                                <%
                                    }

                                %>

                                <%                                    int count = obj.getTotalRows(obj.select("SELECT * FROM FRIENDS WHERE FRIEND = " + rs.getString("poster") + " AND \"USER\" = " + realid));
                                    if (count == 0 && realid != Integer.parseInt(rs.getString("poster"))) {
                                %>
                                <form>
                                    <input type="search" class="form-control" name="comment" placeholder="You must be friends to comment..." autocomplete="off" disabled="">
                                </form>
                                <%
                                } else {
                                %>
                                <form method="post" action="comment_controller?id=<%=rs.getString("ID")%>">
                                    <input type="search" class="form-control" name="comment" placeholder="Write a comment...Press Enter to Post" autocomplete="off" name="comment">
                                </form>
                                <%
                                    }
                                %>

                            </div>

                        </div>
                    </div>
                    <%                        }
                    %>



                </div>

                <jsp:include page="sidefriend"></jsp:include>
            </div>
        </div>

        <div style="margin-bottom: 100px"></div>
    </body>
</html>
