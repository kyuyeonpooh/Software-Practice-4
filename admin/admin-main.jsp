<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import = "java.sql.*" %>
<%
	if(session.getAttribute("id")==null || !session.getAttribute("id").equals("admin")){
%>
		<script>
  			  alert('관리자가 아닙니다.');
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
        <link rel="stylesheet" type="text/css" href="../style/navi-bar.css">
        <link rel="stylesheet" type="text/css" href="../style/table.css"> 
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
          <div id = "reserve-title3">
               관리자 페이지
           </div>

		<a href="../admin/admin-main.jsp">
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
         <div id="navi-wrapper">
           <ul id="navi-bar">
               <li>
                  <center>
                   <a id="main" href="admin-main.jsp" style="background-color: white; color: #52c0dc;">
                   회원 관리
                   </a>
                   </center>
               </li>
               <li>
                  <center>
                   <a id="list" href="movie-list.jsp">영화 목록</a>
                   </center>
               </li>
               <li>
                  <center>
                   <a id="add" href="movie-add.jsp">영화 추가</a>
                   </center>
               </li>
               <li>
                  <center>
                   <a id="delete" href="movie-delete.jsp">영화 삭제</a>
                   </center>
               </li>
           </ul>
           </div>
   
           <div class="content-zone">
              <table border="1" id="member-list">
              <tr>
                 <th>이름</th>
                 <th>아이디</th>
                 <th>예매 횟수</th>
              </tr>
              <%
               Class.forName("com.mysql.jdbc.Driver");
               Connection conn = DriverManager.getConnection(
               "jdbc:mysql://localhost:3306/cinema", "root", "vnqrbdus96");
               Statement stmt = conn.createStatement();
               String sqlStr = "SELECT * FROM members";
               ResultSet rset = stmt.executeQuery(sqlStr);
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
                  <td class="name"><%= rset.getString("n") %></td>
                  <td class="id"><%= rset.getString("id") %></td>
                  <td class="cnt"><%= rset.getString("reservecnt") %></td>
               </tr>
            <%
               }
            %>  
              </table>                    
           </div>
           
      </div>
   </body>
</html>