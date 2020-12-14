<%-- 
    Document   : profile
    Created on : Jun 3, 2020, 5:07:35 PM
    Author     : Tommy
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.chat.getStuff"%>
<%@page import="com.chat.connect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            getStuff obj = new getStuff();
            connect conn = new connect();
            String id = request.getParameter("id");
            int realid = Integer.parseInt(session.getAttribute("logged").toString());
            List arr = obj.getUser("*", "ID", id);

        %>
        <jsp:include page="styles"></jsp:include>
        <title><% out.print(arr.get(1));%>'s Profile</title>
    </head>
    <body>
        <jsp:include page="navbar"></jsp:include>

            <div class="container posts">
                <div class="row">
                <jsp:include page="sideprofile"></jsp:include>

                    <div class="col-md-6" style="overflow:auto;">
                        <div class="card">
                            <div class="card-header" style="padding: 7px;">
                                <div class="text-center" style="font-size: 30px;">
                                    <b><%=arr.get(1)%></b>&nbsp;(<%=arr.get(3)%>)<br>
                                <small>[<%=arr.get(4)%>]</small>
                            </div>
                            <div class="text-right">
                                <%

                                    if (realid != Integer.parseInt(id)) {
                                        int count = obj.getTotalRows(obj.select("SELECT * FROM FRIENDS WHERE FRIEND = " + id + " AND \"USER\" = " + realid));
                                        if (count == 1) {
                                            //out.print("SELECT * FROM FRIENDS WHERE FRIEND = " + id + " AND \"USER\" = "+realid);
                                %>
                                <div class="row">
                                    <div class="col-md-6 text-left">
                                        <a href="chat?id=<%=id%>" class="btn btn-secondary">Message</a>
                                    </div>
                                    <div class="col-md-6 text-right">
                                        <input type="submit"  class="btn btn-secondary" value="Friends" disabled="">
                                    </div>
                                </div>

                                <%
                                } else {
                                    int counte = obj.getTotalRows(obj.select("SELECT * FROM REQUESTS WHERE \"FIRST\" = " + realid + " AND \"SECOND\" = " + id));
                                    //out.print("SELECT * FROM REQUESTS WHERE \"FIRST\" = " + realid + " AND \"SECOND\" = " + id);
                                    if (counte == 1) {
                                %>
                                <input type="submit" class="btn btn-secondary btn-secondary" value="Friend Request Sent" disabled="">
                                <%
                                } else {
                                %>
                                <a href="send_friendrequest?id=<%=id%>"  class="btn btn-secondary btn-secondary">Send Friend Request</a>
                                <%
                                            }
                                        }
                                    }

                                %>

                            </div>
                        </div>
                    </div>

                    <%                        
                        String query = "SELECT * FROM POST WHERE POSTER = " + id + " ORDER BY ID DESC";
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
                                String comsql = "SELECT * FROM COMMENTS WHERE POST = " + rs.getInt("ID")+" ORDER BY ID DESC";
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

                                <%
                                    int count = obj.getTotalRows(obj.select("SELECT * FROM FRIENDS WHERE FRIEND = " + id + " AND \"USER\" = " + realid));
                                    if (count == 0 && realid != Integer.parseInt(id)) {
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
                                <%
                                    if (realid == Integer.parseInt(id)) {
                                        %>
                                        <a href="deletepost?id=<%=rs.getString("ID")%>" class="btn btn-secondary btn-sm" style="margin-top: 10px;">Delete Post</a>
                                        <%
                                    }
                                %>
                                
                                
                            </div>

                        </div>
                    </div>
                    <%
                        }
                    %>

                </div>

                <jsp:include page="sidefriend"></jsp:include>
            </div>
        </div>

        <div style="margin-bottom: 100px"></div>
    </body>
</html>
