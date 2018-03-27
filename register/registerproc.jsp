<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

  <%
  	  String usrname = request.getParameter("n");
	  String id = request.getParameter("id");
	  String pwd = request.getParameter("password");
	  String phone = request.getParameter("contact");			
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
      int result;
  %>

	<%
	  sqlStr = "SELECT * FROM members WHERE id =\'" + id + "\'";
      rset = stmt.executeQuery(sqlStr); 
      if(rset.next()){
	  	  response.sendRedirect("register-fail.html");
		} else {
		sqlStr = "INSERT INTO members VALUES ("
      			+ "\'" + id + "\',"
      			+ "\'" + pwd + "\',"
      			+ "\'" + usrname + "\',"
      			+ "\'" + phone + "\',"
      			+ "0)";
     	result = stmt.executeUpdate(sqlStr);
	}
	%>
		  
	<%
	  rset.close(); 
      stmt.close();
      conn.close();
    %>
    
<script>
    alert('회원가입에 성공하였습니다.');
    location.href = "../index.html"; 
</script>
