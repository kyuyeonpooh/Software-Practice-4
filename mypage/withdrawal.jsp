<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

 
<%
	  String id = request.getParameter("id");	
%>  

<%@ page import = "java.sql.*" %>
<%
      Class.forName("com.mysql.jdbc.Driver");
      Connection conn = DriverManager.getConnection(
          "jdbc:mysql://localhost:3306/cinema", "root", "vnqrbdus96"); 
      Statement stmt = conn.createStatement();
      String sqlStr;
      int recordUpdated;
      int rset;
%>

<%
      sqlStr = "DELETE FROM members WHERE id =\'" + id+"\'";
      stmt.executeUpdate(sqlStr); 

      session.removeAttribute("id");
	  session.removeAttribute("name");
	  session.invalidate();
%>
	
<%    
      stmt.close();
      conn.close();  
%>

<script>
    alert('그동안 이용해주셔서 감사합니다');
    location.href = "../index.html"; 
</script>

