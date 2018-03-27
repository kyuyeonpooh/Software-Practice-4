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
	  String seatlist = request.getParameter("seatlist");
      String[] seat = seatlist.split(" ");
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
		for(int i = 1; i < seat.length; i++){
			try{
				sqlStr = "INSERT INTO reservations VALUES ("
      					+ "\'" + session.getAttribute("id") + "\',"
      					+ "\'" + session.getAttribute("title") + "\',"
      					+ "\'" + session.getAttribute("selected_time") + "\',"
      					+ "\'" + seat[i] + "\')";
     			result = stmt.executeUpdate(sqlStr);
			} catch(Exception e){
				
			}
     		sqlStr = "UPDATE movies SET remainseat = remainseat - 1 WHERE "
				+ "title = \'" + session.getAttribute("title") +"\'"
				+ " and showtime = \'" + session.getAttribute("selected_time") +"\'";
			result = stmt.executeUpdate(sqlStr);
		}
		sqlStr = "UPDATE members SET reservecnt = reservecnt + 1 WHERE "
				+ "id = \'" + session.getAttribute("id") +"\'";
			result = stmt.executeUpdate(sqlStr);

	%>

<html>    
	<head>
		<title> 영화 예매 사이트 - 예매완료 </title>
        <link rel="stylesheet" type="text/css" href="../style/background.css">     
        <link rel="stylesheet" type="text/css" href="../style/line.css">
        <link rel="stylesheet" type="text/css" href="../style/reserve.css"> 
        <link rel="stylesheet" type="text/css" href="../style/moviebox.css"> 
        <link rel="stylesheet" type="text/css" href="../style/table.css"> 
		<link rel="stylesheet" type="text/css" href="../style/homebutton.css">  
        
        <script>
        function draw_movie_box(){
<%
      ResultSet rset;
%>
<%
	  String title=(String)session.getAttribute("title");
	  String imageurl="";

      sqlStr = "SELECT * FROM movies WHERE title =\'" + title+ "\' Order by showtime ASC";
      rset = stmt.executeQuery(sqlStr); 
%>	
<%
	if(rset.next()){
		title = rset.getString("title");
		imageurl = rset.getString("imageroot");
%>	
		document.write("<div class=\"moviebox\">");
		document.write("<image src=\""+"<%=imageurl%>"+
		"\" class=\"poster\" alt=\""+"<%=title%>"+"\">");
		document.write("<div class = \"movie-title\">"+"<%=title%>"+"</div>");
		document.write("<Button class = \"reserve-disable-button2\" onclick=\"reserve(\'<%=title%>\');\" disabled=\"true\">예매중</Button>");
		document.write("</div>");
<%
	}
	rset.close();
	stmt.close();
    conn.close();
%>
	}
        </script>
	
	</head>


	<body>
		<div id = "title-section">
	    	<div id = "reserve-title">
               예매하기
        	</div>
        	<a href="../login/response-success.jsp">
        	<img id="homebutton" src="../image/home1.png"
			onmouseover="this.src='../image/home2.png'"
			onmouseout="this.src='../image/home1.png'"
        	>
        	</a>
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
		
		<div id="wrapper">
		<div id = "showmovie">				
			<center>
			<script>draw_movie_box();</script>
			</center>
		</div>

		<div id = "vertical-line">
		</div>
		
		<div id = "showmovieinfo">
		<div id = "timetable">
				예매 완료
			</div>
			<table id="reserveinfo">
				<tr>
					<th>제목</th>
					<td><%=session.getAttribute("title")%></td>
				</tr>
				<tr>
					<th>상영시간</th>
					<td><%=session.getAttribute("selected_time")%></td>
				</tr>
				<tr>
					<th>좌석</th>
					<td>
						<script>
							var s = "<%=seatlist%>";
							var arr = s.split(" ");
							document.write(arr[1]);
							for(var i=2; i<arr.length; i++){
								document.write(", " + arr[i]);
							}
						</script>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>