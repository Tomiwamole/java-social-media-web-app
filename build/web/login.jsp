<%-- 
    Document   : login
    Created on : Jun 2, 2020, 1:23:44 PM
    Author     : Tommy
--%>

<%@page import="com.chat.getStuff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="styles"></jsp:include>
            <title>Login</title>
        </head>
        <body>
            <div style="margin-top: 10%">
                <div class="container" >
                    <div class="row">
                        <div class="col-md-2"></div>
                        <div class="col-md-8">
                            <h1 class="text-center heading">Login &nbsp;<i class="fa fa-user-o"></i></h1>
                            <div class="container">
                                <div class="form">
                                    <form method="get" action="login_controller">
                                        <div class="row" style="margin-bottom: 30px;">
                                            <div class="col-md-4">
                                                <label>Email:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <input type="email" class="form-control" autocomplete="on" name="email">
                                            </div>
                                        </div>

                                        <div class="row" style="margin-bottom: 30px;">
                                            <div class="col-md-4">
                                                <label>Password:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <input type="password" class="form-control" autocomplete="on" name="password">
                                            </div>
                                        </div>

                                    <%
                                        if (session.getAttribute("logged") != null) {
                                            getStuff obj = new getStuff();
                                            String error = session.getAttribute("logged").toString();
                                            //out.print("("+error+")");
                                            boolean check = obj.checkInt(error);
                                            //out.print(check);
                                            if (!check) {
                                                if (error == "error4") {
                                    %>
                                    <div class="text-center" style="color:red; font-weight: bold; text-decoration: underline">
                                        Could not login. Please try again later😞😥
                                    </div>
                                    <%
                                    } else if (error == "error3") {
                                    %>
                                    <div class="text-center" style="color:red; font-weight: bold; text-decoration: underline">
                                        No account is linked to those details
                                    </div>
                                    <%
                                                }
                                                session.setAttribute("logged", "");
                                            }
                                        }
                                    %>

                                    <div class="" style="margin-bottom: 30px;">
                                        <div class="text-center">
                                            <br>
                                            <input type="submit" class="btn btn-secondary form-control submit" value="Login...">
                                            <br><br>
                                            <h4>Dont have an account? <a href="signup">Create One</a></h4>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2"></div>

                </div>
            </div>
    </body>
</html>
