80%�� ����ȭ

����(���ڴ� ���� ����)
	0. reserve/response-success.jsp
		��ȭ �����͵��� �����Ǿ� �ִ�. 
		���� �ϳ��� �����͸� ��� �����ϱ� ��ư�� ������,
		�ش� �������� title�� post�� ��� jsp�� ������.
	1. reserve/reserve_start.jsp
		�������� title�� �޾�, session�� title�� �����صд�.
		(�������, session.setAttribute(title, title); �̷���)
	2. reserve/checktime.jsp 
		���� �ð��� ����. session�� title ���� �������� ��ȭ ���� ���.
		���� �¼� �� �ش� ��ȭ�� �󿵽ð��� ����ص�.
		���� checkbox�� ������, �ش� üũ�ڽ��� �ð����� jsp�� ������.
		(checkbox�� �߿��� �ϳ��� ������ �� �ֵ��� �Լ� ������ �ξ���. onecheckbox)

	3. reserve/set_time.jsp
		�ð��� �޾�, session�� selectedtime���� �����صд�.
		session.setAttribute("selected_time", selected_time); �̷��� �����ص�

	4. reserve/getseat.jsp(�̿�)
		���� ����
	5. reserve/set_seat.jsp(..)
		���� �����صα�
	7. reserve/choose_seat.jsp(..)
		�¼�����
	8. ....

	p.f) 
		��ȭ�� Ÿ��Ʋ�� �������� �ʹٸ� session.getAttribute("title");
		��ȭ�� �󿵽ð��� �������� �ʹٸ� session.getAttribute("selected_time");
		�� �̿��ϸ� ��.

���
	0.mypage/mypage.jsp
		id�� ����, ��ȭ ���� ���� ���
		checktime.jsp�� ���������� ���� checkbox����
		submit�� ������, �ش� title�� �󿵽ð� ������ ���� jsp���Ϸ� �Ѿ��.
		(������ ������ String���� ('��ȭ����','�󿵽ð�')�� ���� ������� ����
		���� ���. '���˵���,09:00')
	1.cancel/cancel.jsp
		���� ��ȭ ���� ������ split(')�� �̿��ؼ� �߶�, ��ȭ ����� �󿵽ð��� 
		���� String title. String showtime�� �����صξ���.
		
	2. ...

		
�� �ܿ� ������ ��

	��ư�� ���콺 �����ϸ� ȿ�� : Ŀ�� �ٲ�� �ϱ�� ��ư�� ũ�� �ٲٱ�
	���� : sessin�� ID������ ���� ���, '�α��� ������ �����ϴ�.'alert���� index.html�� �̵�.
"
<%
	if(session.getAttribute("id")==null){
%>
		<script>
  			  alert('�α��� ������ �������� �ʽ��ϴ�.');
    		  location.href = "../index.html"; 
		</script>
<%
	}
%>

" �� �ڵ带 jsp���� �� ���� ��θ�, �� ������������ ������ ���� ����� �����ȴ�.(����, response-success.jsp)



����ؿ�!!!!