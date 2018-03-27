<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import = "java.sql.*" %>

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

<html>    
	<head>
		<title> 영화 예매 사이트 - 좌석 고르기 </title>
        <link rel="stylesheet" type="text/css" href="../style/background.css">     
        <link rel="stylesheet" type="text/css" href="../style/line.css">
        <link rel="stylesheet" type="text/css" href="../style/reserve.css"> 
        <link rel="stylesheet" type="text/css" href="../style/moviebox.css"> 
        <link rel="stylesheet" type="text/css" href="../style/seat-table.css"> 
        <link rel="stylesheet" type="text/css" href="../style/homebutton.css">  
        <link rel="stylesheet" type="text/css" href="../style/colorinfo.css">  
                
        <script>
			var even_color = "#99d9ea";
			var odd_color = "#d3eff2";
			var total_seat = parseInt(<%=session.getAttribute("people_num")%>);
			var selected_seat = 0;

			function changeOpacity(){
				if(selected_seat == total_seat)
					document.getElementById("next").style.opacity = 1.0;
				else
					document.getElementById("next").style.opacity = 0.5;
			}

			function seatnumCheck(){
				if(selected_seat == total_seat)
					return false;
				return true;
			}

			function reserve(){
				var s = "";
				if(selected_seat != total_seat){
					alert("좌석을 모두 선택하지 않으셨습니다.");
					return false;
				}
				else{
					var alphas = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
            		for(var i=1; i<=12; i++){
            			for(var j=1; j<=13; j++){
            				var seat = document.getElementById(alphas[i-1] + j.toString());
            				if(seat.style.backgroundColor == "pink")
            					s += " " + seat.id;
            			}
            		}               			
               }
                var form = document.createElement("form");
				form.setAttribute("charset", "UTF-8");
				form.setAttribute("method", "post"); // Get 또는 Post 입력
				form.setAttribute("action", "reserve-insert.jsp");
				var hiddenField = document.createElement("input");
				hiddenField.setAttribute("type", "hidden");
				hiddenField.setAttribute("name", "seatlist");
				hiddenField.setAttribute("value", s);
				form.appendChild(hiddenField);
				document.body.appendChild(form);
				form.submit();
            }


			function changeColor(obj){
				if(obj.style.backgroundColor != "pink"){
					if(seatnumCheck() == true){
						obj.style.backgroundColor = "pink";
						selected_seat++;
						changeOpacity();
					}
					else{
						alert(<%=session.getAttribute("people_num")%> + "자리 까지 선택하실 수 있습니다.");
					}
				}
				else{
					if(obj.parentNode.className == "even-row")
						obj.style.backgroundColor = even_color;
					else if(obj.parentNode.className == "odd-row")
						obj.style.backgroundColor = odd_color;
					selected_seat--;
					changeOpacity();
				}
			}

        	function logout(){
				alert("로그아웃 되었습니다.");
				location.href="../index.html";                        
        	}

        	function draw_movie_box(){
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
%>

<%    
      rset.close();
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
			<div id = "chooseseat">
				<%=session.getAttribute("title")%> - <%=session.getAttribute("selected_time")%>
				(<%=session.getAttribute("people_num")%>명)
			</div>
			<div id="screen">
				Screen
			</div>
			<table id="seat_table">
				<script>
<%
    sqlStr = "SELECT * FROM reservations WHERE title =\'" + title + "\'" + "and showtime =\'" + session.getAttribute("selected_time") + "\'";
    rset = stmt.executeQuery(sqlStr); 
	String selected_list = "";
	
	while(rset.next()){
		selected_list += " " + rset.getString("selectseat");
	}
%>
					var seats = "<%=selected_list%>";
					var arr = seats.split(" ");
					var alphas = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
					for(var i=1; i<=12; i++){
						if(i % 2 == 0)
							document.write("<tr class='even-row'>");
						else
							document.write("<tr class='odd-row'>");
						for(var j=0; j<=13; j++){
							var seatname = alphas[i-1] + j.toString();
							var already = false;
							if(j == 0){
								document.write("<th>" + alphas[i-1] + "</th>");
							}
							else{
								
								for(var k=1; k < arr.length; k++){
									if(seatname == arr[k]){
										already = true;
										break;
									}									
								}
								if(already){
									document.write("<td style=\'background-color: #bdbdbd; \' ");
									document.write("id=\'" + alphas[i-1] + j.toString()  + "\'>");
									document.write("X</td>");
								}
								else{
									document.write("<td onclick=\'changeColor(this);\' ");
									document.write("id=\'" + alphas[i-1] + j.toString()  + "\'>");
									document.write(j + "</td>");
								}								
								
							}
						}
						document.write("</tr>");
					}
				</script>
			</table>

			<div id="colorinfo">
				<div class="acolor">
					<div id="gray">X</div><div class="explain">&nbsp;&nbsp;:&nbsp;예약된&nbsp;좌석</div>
				</div>
				<div class="acolor">
					<div id="pink"></div><div class="explain">&nbsp;&nbsp;:&nbsp;선택된&nbsp;좌석</div>
				</div>
				<div class="acolor">
					<div id="blue1"></div><div class="f">&nbsp;</div><div id="blue2"></div><div class="explain">&nbsp;&nbsp;:&nbsp;빈&nbsp;좌석</div>
				</div>				
			</div>
		</div>
		<Button type="button" onclick="reserve();" id="next">예<br>매<br>하<br>기</Button>
		</div>
	</body>
</html>