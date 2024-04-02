<%-- 
    Document   : AgencyVerification
    Created on : 17 Dec, 2022, 1:48:52 PM
    Author     : ardra
--%>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP AgencyVerification</title>
    </head>
    <body>
        <%@include  file="headadmin.jsp" %>
        <br>
        <div id="tab" align="center">
            <%
                if (request.getParameter("did") != null) {
                    String up = "update tbl_agency set agency_vstatus= 1 where agency_id='" + request.getParameter("did") + "'";
                    con.executeCommand(up);
                    response.sendRedirect("AgencyVerification.jsp");
                }

                if (request.getParameter("eid") != null) {
                    String up = "update tbl_agency set agency_vstatus= 2 where agency_id='" + request.getParameter("eid") + "'";
                    con.executeCommand(up);
                    response.sendRedirect("AgencyVerification.jsp");
                }
            %>
            <table border="1" align="center">

                <tr>
                    <th>Sl. No.</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Address</th>
                    <th>Contact</th>
                    <th>District</th>
                    <th>Place</th>
                    <th>Type</th>
                    <th>Logo</th>
                    <th>Proof</th>
                    <th>Date of request</th>
                    <th>Action</th>
                </tr>
                <%
                    String select = "select * from tbl_agency s inner join tbl_place p on p.place_id = s.place_id inner join tbl_district d on p.district_id = d.district_id inner join tbl_type t on p.type_id = t.type_id where agency_vstatus = 0";

                    ResultSet rs = con.selectCommand(select);
                    int i = 0;
                    while (rs.next()) {
                        i++;
                %>


                <tr>
                    <td><%=i%></td>
                    <td><%=rs.getString("agency_name")%></td>
                    <td><%=rs.getString("agency_email")%></td>
                    <td><%=rs.getString("agency_address")%></td>
                    <td><%=rs.getString("agency_contact")%></td>
                    <td><%=rs.getString("district_name")%></td>
                    <td><%=rs.getString("place_name")%></td>
                    <td><%=rs.getString("type_name")%></td>
                    <td><img src="../Assets/Files/AgencyLogo/<%=rs.getString("agency_logo")%>" width="120" height="120"/></td>
                    <td><a href="../Assets/Files/AgencyProof/<%=rs.getString("agency_proof")%>"download>Download</a></td>

                    <td><%=rs.getString("agency_doj")%></td>
                    <td>
                        <a href="AgencyVerification.jsp?did=<%=rs.getString("agency_id")%>">Accept</a>
                        <a href="AgencyVerification.jsp?eid=<%=rs.getString("agency_id")%>">Reject</a>
                    </td>
                </tr>
                <%
                    }
                %>




            </table>
        </div>
    </body>
    <%@include file="footadmin.jsp" %>
</html>