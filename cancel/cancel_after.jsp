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
		<title> 영화 예매 사이트 - 시간 고르기 </title>
        <link rel="stylesheet" type="text/css" href="../style/background.css">     
        <link rel="stylesheet" type="text/css" href="../style/line.css">
        <link rel="stylesheet" type="text/css" href="../style/reserve.css"> 
        <link rel="stylesheet" type="text/css" href="../style/moviebox.css"> 
        <link rel="stylesheet" type="text/css" href="../style/seat-table.css">
        <link rel="stylesheet" type="text/css" href="../style/nextbutton_colorinfo.css"> 
        <link rel="stylesheet" type="text/css" href="../style/homebutton.css">
        <link rel="stylesheet" type="text/css" href="../style/colorinfo.css">
        
        <script>
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

     String title = (String)session.getAttribute("cancel_title");
     String showtime = (String)session.getAttribute("cancel_showtime");

      sqlStr = "SELECT * FROM movies WHERE title =\'" + title+ "\' Order by showtime ASC";
      rset = stmt.executeQuery(sqlStr); 
%>
	
<%
	if(rset.next()){
		title = rset.getString("title");
		String imageurl = rset.getString("imageroot");
%>		
		document.write("<div class=\"moviebox\">");
		document.write("<image src=\""+"<%=imageurl%>"+
		"\" class=\"poster\" alt=\""+"<%=title%>"+"\">");
		document.write("<div class = \"movie-title\">"+"<%=title%>"+"</div>");
		document.write("<Button class = \"reserve-disable-button\" onclick=\"reserve(\'<%=title%>\');\" disabled=\"true\">취소완료</Button>");
		document.write("</div>");
<%
	}
%>

<%    
      rset.close();
%>
        	}

        	function oneCheckbox(a){
        		var obj = document.getElementsByName("timecheck");
				for(var i=0; i<obj.length; i++){
					if(obj[i] != a){
						obj[i].checked = false;
            		}
       			}
        	}
        	
			var even_color = "#99d9ea";
			var odd_color = "#d3eff2";
			var selected_seat = 0;
			
			function changeColor(obj){
				if(obj.style.backgroundColor != "pink"){
					obj.style.backgroundColor = "pink";
					selected_seat=selected_seat-1;
				}
				else{
					selected_seat=selected_seat+1;
					if(obj.parentNode.className == "even-row")
						obj.style.backgroundColor = even_color;
					else if(obj.parentNode.className == "odd-row")
						obj.style.backgroundColor = odd_color;
				}
			}

		function do_cancel(s){
					var form = document.createElement("form");

					form.setAttribute("charset", "UTF-8");
					form.setAttribute("method", "Post"); // Get 또는 Post 입력
					form.setAttribute("action", "../cancel/cancelproc.jsp");

					var hiddenField = document.createElement("input");
					hiddenField.setAttribute("type", "hidden");
					hiddenField.setAttribute("name", "cancellist");
					hiddenField.setAttribute("value", s);
					form.appendChild(hiddenField);

					document.body.appendChild(form);
					form.submit();
		}
	
		 function reserve(){
            var c = "";
            if(selected_seat == 0){
               alert("취소할 좌석을 선택하지 않으셨습니다.");
               return false;
            }
            else{
               var alphas = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
                  for(var i=1; i<=12; i++){
                     for(var j=1; j<=13; j++){
                        var seat = document.getElementById(alphas[i-1] + j.toString());
                        if((seat.style.backgroundColor != "pink")&&(seat.style.backgroundColor != "rgb(189, 189, 189)") )
                           c += " "+seat.id;
                     }
                  }
                 do_cancel(c);                      
            }
         }
			        	
        </script>

	</head>
	<body>
		<div id = "title-section">
	    	<div id = "reserve-title">
               예매취소
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
				<%= title %> - <%= showtime %> (취소완료)
			</div>
			<div id="wrap_tabble_and_button">
			<div id="screen">
				Screen
			</div>
			<table id="seat_table">
				<script>
<%
    sqlStr = "SELECT * FROM reservations WHERE title =\'" + title + "\'" + "and showtime =\'" + 
    			showtime + "\'";
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
                           document.write("<td \"");
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
					<div id="gray"></div><div class="explain">&nbsp;&nbsp;:&nbsp;예약된&nbsp;좌석</div>
				</div>
				<div class="acolor">
					<div id="blue1"></div><div class="f">&nbsp;</div><div id="blue2"></div><div class="explain">&nbsp;&nbsp;:&nbsp;빈&nbsp;좌석</div>
				</div>				
			</div>
			 </div>
		</div>		
		</div>
	</body>
</html>