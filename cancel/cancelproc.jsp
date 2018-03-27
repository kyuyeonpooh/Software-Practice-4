<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

 
<%
     String seatlist = request.getParameter("cancellist");
     String title = (String)session.getAttribute("cancel_title");
     String showtime = (String)session.getAttribute("cancel_showtime");

     String id = (String)session.getAttribute("id");
      String[] seat = seatlist.split(" ");
%>

  <%
      Class.forName("com.mysql.jdbc.Driver");
      Connection conn = DriverManager.getConnection(
          "jdbc:mysql://localhost:3306/cinema", "root", "vnqrbdus96"); 
      Statement stmt = conn.createStatement();
      String sqlStr="";
      int result;
  %>

   <%
      for(int i = 1; i < seat.length; i++){
           sqlStr = "DELETE FROM reservations WHERE id =\'" + id + "\' and showtime=\'"+ showtime
           +"\' and title = \'"+title+"\' and selectseat = \'"+seat[i]+"\'";
           result = stmt.executeUpdate(sqlStr);

           sqlStr = "UPDATE movies SET remainseat = remainseat + 1 WHERE "
            + "title = \'" + title +"\'"
            + " and showtime = \'" + showtime +"\'";
         result = stmt.executeUpdate(sqlStr);
      }
   
   %>
        
<%
      stmt.close();
      conn.close();
%>

<script>
    alert("<%=title%> - <%=showtime%>: <%=seat.length-1%>석이 취소되었습니다.");
    location.href= "../cancel/cancel_after.jsp"; 
</script>
