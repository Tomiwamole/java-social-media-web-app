<%-- 
    Document   : people
    Created on : Jun 3, 2020, 9:33:37 PM
    Author     : Tommy
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page import="com.chat.connect"%>
<%@page import="com.chat.getStuff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            getStuff obj = new getStuff();
            connect conn = new connect();
            int realid = Integer.parseInt(session.getAttribute("logged").toString());
            List arr = obj.getUser("*", "ID", String.valueOf(realid));

        %>
        <jsp:include page="styles"></jsp:include>
            <title>Tom Chat | People</title>

        </head>
        <body>
        <jsp:include page="navbar"></jsp:include>
            <div class="container posts">
                <div class="row">
                <jsp:include page="sideprofile"></jsp:include>

                    <div class="col-md-6" style="overflow:auto;">
                        <!--
                        <div class="card">
                            <div class="card-header" style="padding: 7px;">
                                <div class="text-center" style="font-size: 25px;">
                                    <b><%=arr.get(1)%>'s Friends</b><br>
                            </div>
                        </div>
                        <div class="card-body" style="padding: 7px;">
                            <%
                                String query = "SELECT * FROM FRIENDS WHERE FRIEND = " + realid + "";
                                int count = obj.getTotalRows(obj.select(query));
                                if (count == 0) {
                            %>
                            <br>
                            <div class="text-center"><h2 style="font-weight: bold;">No friends yet </h2></div>
                            <%
                            } else {
                            %>
                            <table class="table table-borderless">
                                <tbody>
                                    <%
                                        ResultSet rs = obj.select(query);
                                        int num = 0;
                                        while (rs.next()) {
                                            int other = rs.getInt("USER");
                                            arr = obj.getUser("*", "ID", String.valueOf(other));
                                            if (num % 3 == 0) {
                                    %>
                                    <tr>
                                        <%
                                                    num++;
                                                }

                                            }
                                        %>
                                </tbody>
                            </table>
                            <%
                                }
                            %>
                            <table class="table table-borderless">
                                <tbody>

                                <td>Tomiwa Amole</td>
                                <td>Erioluwa Amole</td>
                                <td>Christ Browns</td>
                                </tr>
                                <tr>
                                    <td>Joseph Maryann</td>
                                    <td>Moe Joe</td>
                                    <td>Mick Jacka</td>
                                </tr>
                                <tr>
                                    <td>July Dooley</td>
                                    <td>Vikey Gyam</td>
                                    <td>Selly Momtex</td>
                                </tr>
                                </tbody>
                            </table>

                        </div>
                    </div>
                        -->

                    <div class="card">
                        <div class="card-header" style="padding: 7px;">
                            <div class="text-center" style="font-size: 25px;">
                                <b>People You may Know</b><br>
                            </div>
                        </div>
                        <div class="card-body" style="padding: 7px;">
                            <ul class="list-group list-group-flush" style="border:0px solid white">
                                <%
                                    String sql = "SELECT DISTINCT FRIEND FROM FRIENDS WHERE \"USER\" != " + realid + " AND FRIEND != " + realid;
                                    //out.print(sql);
                                    ResultSet rs = obj.select(sql);
                                    while (rs.next()) {
                                        ResultSet res = obj.select("SELECT * FROM \"USERS\" WHERE ID =" + rs.getString("FRIEND"));
                                        while (res.next()) {
                                %>
                                <li class="list-group-item">
                                    <a href="profile?id=<%=res.getString("ID")%>" class="nolink"><%=res.getString("NAME")%></a>
                                </li>
                                <%
                                        }
                                    }
                                    //out.print(sql);
%>

                            </ul>
                        </div>
                    </div>
                </div>

                <jsp:include page="sidefriend"></jsp:include>
            </div>
        </div>

        <div style="margin-bottom: 100px"></div>
    </body>
</html>
