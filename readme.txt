80%에 최적화

예매(숫자는 실행 순서)
	0. reserve/response-success.jsp
		영화 포스터들이 나열되어 있다. 
		이중 하나의 포스터를 골라 예매하기 버튼을 누르면,
		해당 포스터의 title을 post에 담아 jsp로 보낸다.
	1. reserve/reserve_start.jsp
		포스터의 title을 받아, session의 title로 저장해둔다.
		(예를들면, session.setAttribute(title, title); 이렇게)
	2. reserve/checktime.jsp 
		이제 시간을 고른다. session의 title 값을 바탕으로 영화 정보 출력.
		남은 좌석 및 해당 영화의 상영시간을 출력해둠.
		옆에 checkbox를 누르면, 해당 체크박스의 시간값을 jsp로 보낸다.
		(checkbox들 중에서 하나만 선택할 수 있도록 함수 구현해 두었다. onecheckbox)

	3. reserve/set_time.jsp
		시간을 받아, session의 selectedtime으로 저장해둔다.
		session.setAttribute("selected_time", selected_time); 이렇게 저장해둠

	4. reserve/getseat.jsp(미완)
		수량 고르기
	5. reserve/set_seat.jsp(..)
		수량 저장해두기
	7. reserve/choose_seat.jsp(..)
		좌석고르기
	8. ....

	p.f) 
		영화의 타이틀을 가져오고 싶다면 session.getAttribute("title");
		영화의 상영시간을 가져오고 싶다면 session.getAttribute("selected_time");
		을 이용하면 됨.

취소
	0.mypage/mypage.jsp
		id에 따라, 영화 에매 정보 출력
		checktime.jsp와 마찬가지로 옆에 checkbox구현
		submit을 누르면, 해당 title과 상영시간 정보가 다음 jsp파일로 넘어간다.
		(보내는 형식은 String으로 ('영화제목','상영시간')과 같은 방식으로 보냄
		예를 들면. '범죄도시,09:00')
	1.cancel/cancel.jsp
		받은 영화 예매 정보를 split(')를 이용해서 잘라서, 영화 제목과 상영시간을 
		각각 String title. String showtime에 저장해두었다.
		
	2. ...

		
이 외에 수정한 것

	버튼에 마우스 오버하면 효과 : 커서 바뀌게 하기와 버튼의 크기 바꾸기
	세션 : sessin에 ID정보가 없을 경우, '로그인 정보가 없습니다.'alert띄우고 index.html로 이동.
"
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

" 이 코드를 jsp파일 맨 위에 써두면, 그 페이지에서도 다음과 같은 기능이 구현된다.(예시, response-success.jsp)



사랑해용!!!!