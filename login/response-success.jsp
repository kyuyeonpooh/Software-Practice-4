<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import = "java.sql.*" %>
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
<meta charset="utf-8">
<html>    
	<head>
		<title> 영화 예매 사이트 - 메인</title>
        <link rel="stylesheet" type="text/css" href="../style/background.css">     
        <link rel="stylesheet" type="text/css" href="../style/line.css">
        <link rel="stylesheet" type="text/css" href="../style/reserve.css"> 
        <link rel="stylesheet" type="text/css" href="../style/moviebox.css"> 
        <link rel="stylesheet" type="text/css" href="../style/homebutton.css">         
        <script>
        	function logout(){
				alert("로그아웃 되었습니다.");
				location.href="../index.html";                        
        	}
        </script>

	</head>
	<body>
		<div id = "title-section">
	    	<div id = "reserve-title">
               <div class="title">예매하기</div>
        	</div>
        	<img id="homebutton" src="../image/home1.png"
			onmouseover="this.src='../image/home2.png'"
			onmouseout="this.src='../image/home1.png'"
			href="../login/response-success.jsp"
        	>
        	<div id = "info">
        		<center id="Nim">
        			<%= session.getAttribute("name") %>&nbsp;&nbsp;님
        		</center>
        		<hr id = "line">
        		<Button onclick="location.href='../mypage/mypage.jsp';">내 정보</Button>
        		<Button onclick="location.href='../login/logout.jsp';">로그아웃</Button>
        	</div>
		</div>

        <div id = "white-line">
        </div>

		<center>

		<script>
				function make_movies(){
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
	  String title="";
	  String prev_title="";
	  String imageurl="";

      sqlStr = "SELECT * FROM movies order by title ASC, showtime ASC";
      rset = stmt.executeQuery(sqlStr); 
%>
	
<%
	while(rset.next()){
		title = rset.getString("title");
		imageurl = rset.getString("imageroot");
		if(!(prev_title.equals("")) && (title.equals(prev_title)))
			continue;
%>		
		document.write("<div class=\"moviebox\">");
		document.write("<image src=\""+"<%=imageurl%>"+
		"\" class=\"poster\" alt=\""+"<%=title%>"+"\">");
		document.write("<div class = \"movie-title\">"+"<%=title%>"+"</div>");
		document.write("<Button class = \"reserve-button\" onclick=\"reserve(\'<%=title%>\');\">예매하기</Button>");
		document.write("</div>");
<%
		prev_title = title;
	}
%>
5
<%    
      rset.close();
      stmt.close();
      conn.close();  
%>
				}

				function reserve(s){
					var form = document.createElement("form");

					form.setAttribute("charset", "UTF-8");
					form.setAttribute("method", "Post"); // Get 또는 Post 입력
					form.setAttribute("action", "../reserve/reserve_start.jsp");

					var hiddenField = document.createElement("input");
					hiddenField.setAttribute("type", "hidden");
					hiddenField.setAttribute("name", "title");
					hiddenField.setAttribute("value", s);
					form.appendChild(hiddenField);

					document.body.appendChild(form);
					form.submit();
				}
			make_movies();
		</script>
		</center>
	</body>
</html>