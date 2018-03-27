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

<%
	  String id = (String)session.getAttribute("id");
	  String name="name";
	  String contact="contact";
%>  

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
      sqlStr = "SELECT * FROM members WHERE id =\'" + id+"\'";
      rset = stmt.executeQuery(sqlStr); 
%>
	
<%
	if(rset.next()){
          name = rset.getString("n");
          contact = rset.getString("contact");
	} 
%>

<meta charset="utf-8">
<html>
    <head>
        <title>영화 예매 사이트 - 마이페이지</title>
        <link rel="stylesheet" type="text/css" href="../style/background.css">     
        <link rel="stylesheet" type="text/css" href="../style/line.css">
        <link rel="stylesheet" type="text/css" href="../style/signin.css">    
        <link rel="stylesheet" type="text/css" href="../style/table.css"> 
        <link rel="stylesheet" type="text/css" href="../style/reserve.css"> 
        <link rel="stylesheet" type="text/css" href="../style/homebutton.css"> 
                                
        <script>
            function do_withdrawal(){
                document.form2.submit();
            }

            function oneCheckbox(a){
        		var obj = document.getElementsByName("reservedinfo");
        		var cancel_button = document.getElementById("cancel");
        		cancel_button.style.opacity = 0.5;
				for(var i=0; i<obj.length; i++){
					if(obj[i] != a){
						obj[i].checked = false;
            		}
       			}

       			for(var i=0; i<obj.length; i++){
       				if(obj[i].checked){    					
       					cancel_button.style.opacity = 1.0;
       				}
       			}
        	}

        	function check_validation(){
        		var isChecked = false;
        		var obj = document.getElementsByName("reservedinfo");
				for(var i=0; i<obj.length; i++){
					if(obj[i].checked)
						isChecked = true;
       			}
       			if(isChecked){
       				document.cancel_time.submit();
       			}       				
       			else{
       				alert("시간을 선택하지 않으셨습니다.");
       			}
       				
       			
        	}
        </script>
    </head>

    <body>
		<div id="title-section2">
        <div id = "reserve-title2">
               마이페이지
        </div>
		<a href="../login/response-success.jsp">
        	<img id="homebutton" src="../image/home1.png"
			onmouseover="this.src='../image/home2.png'"
			onmouseout="this.src='../image/home1.png'"
        	>
        </a>

        </div>

        <div id = "white-line">
        </div>
        <div id="wrapper">
        <form method="post" action="../mypage/withdrawal.jsp" name="form2">  
          <div id="register-section">
            <div class = "input-box">
                이름<br>
                <input type="text" name="n" id="n" readonly/>
            </div>
        
            <div class = "input-box">
                아이디<br> 
                <input type="text" name ="id" id="id" readonly/>
            </div>

             <div class = "input-box">
                연락처<br> 
                <input type="text" name="contact" id="contact" readonly/>
             </div>

             <div id = "submit2">
                <input type="button" value="회원탈퇴" style="cursor:pointer;" onclick="do_withdrawal();">
             </div>
           </div>
        </form>
        	<div id="register-section2">
        	<form method="POST" action="../cancel/cancel.jsp"  name="cancel_time">
        	<div class="input-box2">
        			예약 정보<br>
        	  <table border="1" id="member-list">
              <tr>
                 <th style="width: 350px;">영화</th>
                 <th style="width: 200px;">상영시간</th>
                 <th style="width: 150px;">좌석수</th>
                 <th style="width: 100px;">취소</th>
              </tr>
              <%
      		   sqlStr = "SELECT * FROM reservations WHERE id =\'" +id+ "\' Order by title ASC, showtime ASC";
               rset = stmt.executeQuery(sqlStr);
            %>
            <%
               int count = 0;
               int seatcnt = 1;
			   int breakpt = 0;
			   int i = 0;

               String title="";
               String showtime="";
               String prev_title="";
               String prev_showtime="";

               while (rset.next()) {
				  title = rset.getString("title");
				  showtime = rset.getString("showtime");
				  prev_title = title;
            	  prev_showtime = showtime;				  
               	  
               	 seatcnt = 1;
               	 for(i=0 ; (title.equals(prev_title)) && (showtime.equals(prev_showtime)) ; i++, seatcnt++){
						prev_title = title;
            			prev_showtime = showtime;

						if(rset.next()){
							title = rset.getString("title");
				  			showtime = rset.getString("showtime");
						}
						else{
							breakpt = 1;
							break;
						}
               	  }
               	  if(breakpt!=1)	seatcnt--;

                  count += 1;
            %>
            <%
               if(count % 2 == 0)
                  out.print("<tr class='even-row'>");
               else
                  out.print("<tr class='odd-row'>");
            %>
                  <td class="title"><%= prev_title %></td>
                  <td class="showtime"><%= prev_showtime %></td>
                  <td class="seat"><%= seatcnt %></td>
                  
                  <td class="check">
                  <input type="checkbox" id="reservedinfo" name="reservedinfo" 
                  	value="<%= prev_title %>,<%= prev_showtime %>" onclick="oneCheckbox(this);">
               	  </td>
               </tr>
            <%
            		if(breakpt==1)	break;
            		rset.previous();
               }
            %>
            <%    
      			rset.close();
      			stmt.close();
      			conn.close();  
			%>  
              </table>  
        	</div>
        	<Button type="button" id="cancel" onclick="check_validation()">취<br>소</Button>
        	</form>
        	</div>
		</div>
        <script>
            document.getElementById("n").value = "<%= name %>";
            document.getElementById("id").value = "<%= id %>";
            document.getElementById("contact").value = "<%= contact %>";
        </script> 
    </body>
</html>

