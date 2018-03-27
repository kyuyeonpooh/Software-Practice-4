<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<%
	if(session.getAttribute("id")==null){
%>
		<script>
  			  alert('로그인 정보가 존재하지 않습니다.');
    		  location.href = "../index.html"; 
		</script>
<%
	}
%>
<%
	  String id = request.getParameter("id");
	  String pass = request.getParameter("password");
			
%>  

<%@ page import = "java.sql.*" %>
<%
      Class.forName("com.mysql.jdbc.Driver");
      Connection conn = DriverManager.getConnection(
          "jdbc:mysql://localhost:3306/cinema", "root", "vnqrbdus96"); 
      Statement stmt = conn.createStatement();
      String sqlStr;
      int recordUpdated;
      ResultSet rset;
%>

<%
      sqlStr = "SELECT * FROM members WHERE id =\'" + id+"\'";
      rset = stmt.executeQuery(sqlStr); 
%>
	
<%
	if(rset.next() && rset.getString("pwd").equals(pass)){
          session.setAttribute("id", id);
          session.setAttribute("pwd", pass);
          session.setAttribute("name", rset.getString("n"));
          if(rset.getString("id").equals("admin"))
          	response.sendRedirect("../admin/admin-main.jsp");
          else		
	  	  	response.sendRedirect("response-success.jsp");
	} else {
		
	}
%>

<%    
      rset.close();
      stmt.close();
      conn.close();  
%>

<script>
    alert('아이디와 비밀번호가 일치하지 않습니다.');
    location.href = "../index.html"; 
</script>
