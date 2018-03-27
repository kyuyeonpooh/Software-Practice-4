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
	  String title = request.getParameter("title");
      session.setAttribute("title", title);
      response.sendRedirect("../reserve/checktime.jsp");
%>  