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
function openpage(url, title){
	var pop = window.open(url,title,"width=450,height=500,left=400, top=300");
}
function clickBtn(n="all"){ //처음 menu3에 들어왔을 시 우선 all(전부) 출력
    document.getElementById("btnValueSave").value = n;
    document.getElementById("frm").submit();
}
</script>
</head>
<body>
    <jsp:include page="header.jsp" flush="false"/>
  <div class="context">
    <div class="context-top">
    <h3>[메뉴 관리]</h3><br>
    <span>등록 메뉴와 레시피를 저장합니다.<br>
    재고 관리에 상품을 등록하기 위해선 레시피 추가 선행이 필수적으로 요구됩니다.<br>
    등록 후 재고관리 탭에서 상품명을 추가해주세요.<br>
    </span>
    <div>
    <div id ="recipe_left">
    <form action="menu3.jsp" id="frm">
    <input type="button" class = "button" onclick="clickBtn('all');" value="ALL"/>
    <input type="button" class="button" onclick="clickBtn('Vegan');" value="VEGAN"/>
    <input type="button" class="button" onclick="clickBtn('Non-vegan');" value="NON-VEGAN"/>
    <input type="hidden" id="btnValueSave" name="base" value=""/>
    </form> <!-- text없이 button type으로 정보를 전송하고 싶기에 submit대신 button 이벤트에 submit을 추가하고, value를 저장할 input을 hidden타입으로 저장해 정보를
    			담을 그릇으로 사용함 -->
    </div>
    <div id = "recipe_Right">
    <button class="button" onclick="openpage('insertRC.jsp','추가')">ADD RECIPE</button>
    </div>
    </div>
    </div>
    <div class="table_r">
	<div class="table">
	<%
	request.setCharacterEncoding("EUC-KR");
	String v =request.getParameter("base");
	
	//out.println(SO); 
	if (v!=null&&(v.equals("Vegan")||v.equals("Non-vegan"))){
	%>
	<jsp:include page="m3_vegan.jsp" flush="false">
		<jsp:param name="v" value="<%=v%>"/>
	</jsp:include>
	<%
	}else{ //null이거나(처음 접속), all일 경우 모두 전체 테이블 갱신
	%>
	<jsp:include page="m3_all.jsp" flush="false"/>
	<%
	}
	%>
		</div>
	</div>
</div>

</body>
</html>
