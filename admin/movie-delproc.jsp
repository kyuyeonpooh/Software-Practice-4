<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
	if(session.getAttribute("id")==null || !session.getAttribute("id").equals("admin")){
%>
		<script>
  			  alert('관리자가 아닙니다.');
    		  location.href = "../index.html"; 
		</script>
<%
	}
%>
<%
  	  String title = request.getParameter("movie-title");
	  String time = request.getParameter("movie-time");
%>  

  <%
      Class.forName("com.mysql.jdbc.Driver");
      Connection conn = DriverManager.getConnection(
          "jdbc:mysql://localhost:3306/cinema", "root", "vnqrbdus96"); 
      Statement stmt = conn.createStatement();
      String sqlStr;
      int result;
  %>

	<%
		sqlStr = "DELETE FROM movies WHERE title =\'" + title +"\'"
					+ " and " +  "showtime = \'" + time + "\'";
     	result = stmt.executeUpdate(sqlStr);

	%>
		  
	<%
	  if(result == 0){
	  	response.sendRedirect("movie-delete-fail.jsp");
	  }
	  sqlStr = "DELETE FROM reservations WHERE title =\'" + title +"\'"
					+ " and " +  "showtime = \'" + time + "\'";
      result = stmt.executeUpdate(sqlStr);
      stmt.close();
      conn.close();
    %>
<script>
	alert('영화가 성공적으로 삭제되었습니다.')
    location.href="movie-delete.jsp";
</script>

    	  	  