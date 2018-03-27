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
	  String selected_time = request.getParameter("timecheck");
      String selected_num = request.getParameter("num_select");
      session.setAttribute("selected_time", selected_time);
	  session.setAttribute("people_num", selected_num);
      response.sendRedirect("../reserve/getseat.jsp");
%>  