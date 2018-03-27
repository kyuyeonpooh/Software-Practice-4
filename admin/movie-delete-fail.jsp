<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
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
    <link rel="stylesheet" type="text/css" href="../style/movie-input.css">
    <link rel="stylesheet" type="text/css" href="../style/homebutton.css">

    <script>
        function check_validation(){
           if(document.getElementById("movie-title").value == ""){
              alert("영화 제목이 입력되지 않았습니다.");
              document.getElementById("movie-title").focus();
              return false;
           }
           else if(document.getElementById("movie-time").value == ""){
              alert("상영 시간이 입력되지 않았습니다.");
              document.getElementById("movie-time").focus();
              return false;
           }
           else{ 		
                document.moviedel.action = "movie-delproc.jsp";
                document.moviedel.submit();
           }
        }
    </script>
</head>

<body>
    <div id="title-section">
        <div id="reserve-title3">
            관리자 페이지
        </div>

		<a href="../admin/admin-main.jsp">
        	<img id="homebutton" src="../image/home1.png"
			onmouseover="this.src='../image/home2.png'"
			onmouseout="this.src='../image/home1.png'"
        	>
        </a>
        
        <div id="info">
            <center id="Nim">
                <%= session.getAttribute("name") %>&nbsp;&nbsp;님
            </center>
            <hr id="line">
            <Button onclick="location.href='../mypage/mypage.jsp';">내 정보</Button>
            <Button onclick="location.href='../login/logout.jsp';">로그아웃</Button>
        </div>
    </div>

    <div id="white-line">
    </div>

    <div id="wrapper">
        <div id="navi-wrapper">
            <ul id="navi-bar">
                <li>
                    <center>
                        <a id="main" href="admin-main.jsp">회원 관리</a>
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
                        <a id="delete" href="movie-delete.jsp" style="background-color: white; color: #52c0dc;">영화 삭제</a>
                    </center>
                </li>
            </ul>
        </div>
        <div class="content-zone">
            <form method="post" name="moviedel" id="form1">
                <div class="input-set">
        영화제목<input type="text" name="movie-title" id="movie-title" placeholder="삭제할 영화 제목을 입력하세요 ">
  </div>
  <div class="input-set">
        상영시간<input type="time" name="movie-time" id="movie-time">
  </div>
  <div class="warnings">
        입력한 정보에 해당하는 상영중인 영화가 없습니다.
  </div>
  <div class="input-set">
        <input type="button" id="submit-button" onclick="check_validation();" value="영화 삭제">
  </div>
          </form>
        </div>           
      </div>
   </body>
</html>