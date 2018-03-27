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
	  String img = "../image/" + request.getParameter("movie-img");
	  
%>  

  <%
      Class.forName("com.mysql.jdbc.Driver");
      Connection conn = DriverManager.getConnection(
          "jdbc:mysql://localhost:3306/cinema", "root", "vnqrbdus96"); 
      Statement stmt = conn.createStatement();
      String sqlStr;
      int recordUpdated;
      int result;
  %>

	<%
		sqlStr = "INSERT INTO movies VALUES ("
      			+ "\'" + title + "\',"
      			+ "\'" + time + "\',"
      			+ "\'" + img + "\'," + "156)";
     	result = stmt.executeUpdate(sqlStr);
	%>
		  
	<%
      stmt.close();
      conn.close();
    %>
<script>
    location.href="movie-add.jsp";
</script>

    	  	  