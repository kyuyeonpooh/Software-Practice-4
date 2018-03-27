<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<meta charset="utf-8">
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
	session.removeAttribute("id");
	session.removeAttribute("name");
	session.invalidate();

%>

<script>
    alert('로그아웃 되었습니다.');
    location.href = "../index.html"; 
 </script>

