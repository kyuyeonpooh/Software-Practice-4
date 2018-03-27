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
        <link rel="stylesheet" type="text/css" href="../style/table.css"> 
        <link rel="stylesheet" type="text/css" href="../style/homebutton.css">  

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

        	function oneCheckbox(a){
        		var obj = document.getElementsByName("timecheck");
        		var next_button = document.getElementById("next");
        		next_button.style.opacity = 0.5;
				for(var i=0; i<obj.length; i++){
					if(obj[i] != a){
						obj[i].checked = false;
            		}
       			}
       			for(var i=0; i<obj.length; i++){

       				if(obj[i].checked){
       					
       					next_button.style.opacity = 1.0;
       				}
       			}
        	}

        	function check_validation(){
        		var isChecked = false;
        		var obj = document.getElementsByName("timecheck");
				for(var i=0; i<obj.length; i++){
					if(obj[i].checked)
						isChecked = true;
       			}
       			if(isChecked){
       				document.time_checker.submit();
       			}       				
       			else{
       				alert("시간을 선택하지 않으셨습니다.");
       			}
       				
       			
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
			<form method="post" name="time_checker" action="set_time.jsp">
			<div id=wrap>
			<div id = "timetable">
				상영 시간표
			</div>

			  <table border="1" id="member-list">
              <tr>
                 <th>상영 시간</th>
                 <th>남은 좌석</th>
                 <th>체크</th>
              </tr>
            <%
      		   sqlStr = "SELECT * FROM movies WHERE title =\'" + title+ "\' Order by showtime ASC";
               rset = stmt.executeQuery(sqlStr);
            %>
            <%
               int count = 0;
               while (rset.next()) {
                  count += 1;
            %>
            <%
               if(count % 2 == 0)
                  out.print("<tr class='even-row'>");
               else
                  out.print("<tr class='odd-row'>");
            %>
                  <td class="showtime"><%= rset.getString("showtime") %></td>
                  <td class="remainseat"><%= rset.getString("remainseat") %></td>
                  <td class="check">
                  	<input type="checkbox" class="timecheck-box" name="timecheck" 
                  	value="<%= rset.getString("showtime") %>" onclick="oneCheckbox(this);">
                  </td>
               </tr>
            <%
               }
                rset.close();
         		stmt.close();
      			conn.close();  
            %>  
              </table>
              <div id="num_box">
              	인원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              	<select id="people-num" name="num_select" size="1">
              		<option>1</option>
              		<option>2</option>
              		<option>3</option>
              		<option>4</option>
              		<option>5</option>
              		<option>6</option>
              		<option>7</option>
              		<option>8</option>
              		<option>9</option>
              	</select>
              </div>
			  </div>
              <Button type="button" onclick="check_validation();" id="next">다<br>음<br>으<br>로</Button>
              </form>
		</div>
		
		</div>
	</body>
</html>