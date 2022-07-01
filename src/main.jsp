<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "manageWeb.DB"%>
<%@ page import = "manageWeb.InfoData" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>쿠키 예약 관리 페이지</title>
<link rel="stylesheet" href="style.css">
<script type="text/javascript">
	// 돔이 레디가 됐을 때 -> 처음 로딩 시점에 첫 번재 select option값-> 갱신이므로
	document.addEventListener("DOMContentLoaded", function(){
		setup(); //처음부터 input 생성
	});

	function setup() {
		var op = document.getElementById("condition");
		var opInput = document.getElementById("op_input");
		var sbb = document.getElementById("subB");
		
		if(op.options[op.selectedIndex].value =='all'){ //첫번째 option 선택시
			opInput.style.display = "none"; //input 숨기기위해 style에서 display 속성 수정 (input 안보이게)
			sbb.disabled = false;
		}else if (op.options[op.selectedIndex].value =='date'){ //날짜 선택시
			opInput.style.display = "inline-block"; //input 보이고
			opInput.setAttribute('placeholder','00/00'); //placeholder로 검색 양식 표시
			opInput.setAttribute('required',true); 
			sbb.disabled = false;
			opInput.disabled = false;
		}else if(op.options[op.selectedIndex].value =='name'){
			opInput.style.display = "inline-block"; 
			opInput.setAttribute('placeholder','이름을 입력하세요');
			opInput.setAttribute('required',true);
			sbb.disabled = false;
			opInput.disabled = false;
		}else if(op.options[op.selectedIndex].value ==''){
			opInput.style.display = "none";
			opInput.disabled = true;
			sbb.disabled = true;
		}
	}
	function reload() {
		document.location.reload();
	}

</script>
</head>
<body>
   <jsp:include page="header.jsp" flush="false"/>

<div class="context">
	<div class="context-top">
		<div class = "search">
	    <form id="selection" name = 'selection' method="get" action='./main.jsp'>
	    	<select id="condition" name='condition' onchange="setup();">
	    	<option value = '' selected="selected">---</option>
	    	<option value = 'all'>갱신</option>
	    	<option value = 'date'>날짜</option><!-- 날짜는 문자열로 받아올테니 /기준으로 슬라이싱해서 인트형 전환후 각각 저장하면 될듯 -->
	    	<option value = 'name'>주문자명</option>
	    	</select>
	    	<input type="text" id='op_input' name="input" placeholder='날짜[00/00]' />
	    	<input type="submit" id="subB" value="go"/> <!-- 버튼에 jsp 갱신시키는 이벤트 추가해야될듯 -->
	    </form>
		</div>
	</div>
	<div class = "table">
	<%
	request.setCharacterEncoding("EUC-KR");
	
	String SO =request.getParameter("condition");
	String GI = request.getParameter("input"); 
	//out.println(SO); 
	if (SO!=null &&SO.equals("date")){
	%>
		<jsp:include page="./checkDate.jsp" flush="false">
		<jsp:param name="SO" value="<%=SO%>"/>
		<jsp:param name="GI" value="<%=GI%>"/> 
	</jsp:include>
	<%}
	else if (SO!=null&&SO.equals("name")){
	%>
	<jsp:include page="./checkName.jsp" flush="false">
		<jsp:param name="SO" value="<%=SO%>"/>
		<jsp:param name="GI" value="<%=GI%>"/> 
	</jsp:include>
	<%
	}else{ //null이거나(처음 접속), all일 경우 모두 전체 테이블 갱신
	%>
	<jsp:include page="./showAll.jsp" flush="false"/>
	<%
	}
	%>
	</div>
	
</div>
</body>
</html>
