<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>쿠키 예약 관리 페이지</title>
<link rel="stylesheet" href="style.css">
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function(){
	setup(); //처음부터 input 생성
}); 

function setup() {
	var op = document.getElementById("selection");
	var ip = document.getElementById("search_input");
	var sbb = document.getElementById("subB");
	
	if(op.options[op.selectedIndex].value ==""){ //첫번째 option 선택시
		ip.setAttribute('disabled',true); 
		sbb.disabled = true;
	}else{ 
		ip.disabled = false;
		sbb.disabled = false;
	}
} 
function openpage(url, title){
	var pop = window.open(url,title,"width=450,height=500,left=400, top=300");
}
function reload() {
	location.href="menu4.jsp";
}
</script>
</head>
<body>
    <jsp:include page="header.jsp" flush="false"/>
    
  <div class="context">
    <div class="context-top">
    <h3 id="m4h3">[전체 회원 목록]   </h3>
    <button onclick="reload();">갱신</button>
    <button onclick="openpage('deleteCS.jsp','회원 삭제')">회원 삭제</button>
    <div class="bar">
    <form name = 'selection' method="get" action='menu4.jsp' onchange="setup();">
	    	<select id ="selection" name="search" onchange="setup();">
	    	<option value = "">-항목 선택-</option>
	    	<option value = 'cname'>이름</option>
	    	<option value = 'cid'>아이디</option>
	    	</select>
	    	<input type="text" id='search_input' name="input" required="required" />
	    	<input id="subB" type="submit" value="검색"/>
	    </form>
    </div>
    </div>
    <div class = "table">
	<%
	request.setCharacterEncoding("EUC-KR");
	String sch =request.getParameter("search");
	String sch_i = request.getParameter("input"); 
	//out.println("menu4 "+sch_i);
	if (sch!=null &&sch.equals("cname")){
		//out.println("menu4 "+sch_i);%>
	
		<jsp:include page="./searchName.jsp" flush="false">
		<jsp:param name="sch" value="<%=sch%>"/>
		<jsp:param name="sch_i" value="<%=sch_i%>"/> 
		
	</jsp:include>
	<%}
	else if (sch!=null&&sch.equals("cid")){
	%>
	<jsp:include page="./searchID.jsp" flush="false">
		<jsp:param name="sch" value="<%=sch%>"/>
		<jsp:param name="sch_i" value="<%=sch_i%>"/> 
	</jsp:include>
	<%}
	else{ //null(처음 접속)
	%>
	<jsp:include page="./customerTable.jsp" flush="false"/>
	<%
	}
	%>
	</div>
	</div>
    
</body>
</html>
