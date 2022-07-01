<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>레시피 추가</title>
<link rel="stylesheet" href="style.css">
<script type="text/javascript">
	function reload(){
		opener.location.reload();
		alert("추가 완료!");
	}
	function error(){
		alert("추가에 실패했습니다.\n 동일한 ID를 가진 상품이 존재합니다. ");
	}
</script>
</head>
<body>
<div class ="popframe" style="background-color: darkorange;">
<span>레시피 추가[제품등록]</span>
<div class = "frm">
<span id="cnt_span" style="font-size: small; color:white;">목록에 등록할 상품 정보를 입력하세요.<br></span>
<form action="insertRC.jsp">
<br>
상품 ID <input type="text" name="itemID" placeholder="ex.walnut" style="width: 100%" required="required"/><br>
재료 <textarea name="igredient" style="width: 100%" required="required"></textarea><br>
분류 <input type="radio" name="base" value="Vegan" required/>비건
<input type="radio" name="base" value="Non-vegan"/>논비건
<br>
<input type="submit" id ="sb" value="INSERT"/>
</form>
</div>
</div>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = request.getParameter("itemID");	
		String ingd = request.getParameter("igredient");	
		String base = request.getParameter("base");
		
	if(id!=null && ingd !=null){		
		Connection conn =null; // DB 커넥션 연결 객체
		String USERNAME = "root";// DBMS접속 시 아이디
		String PASSWORD = "try1234";// DBMS접속 시 비밀번호
		String URL = "jdbc:mysql://localhost:3306/cookiedb?serverTimezone=UTC";// DBMS접속할 db명
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			/* System.out.println("DB연결 성공"); */
		}catch (Exception e) {
			/* System.out.println("DB연결 실패 ");*/
		}
		
		try {
		
		String SQL = "Insert into recipe values(?,?,?)";
		pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1,id);
		pstmt.setString(2,ingd);
		pstmt.setString(3,base);

    	int i = pstmt.executeUpdate(); //insert 실행한 결과-> 존재하면	
    	
    		if(i!=0){ //insert가 제대로 실행됐을 경우
    		%>
    			<script>reload();</script>
    		<% 	
    		}
		}
    	catch (Exception e) {
    		//System.out.print(e.getMessage());
    		e.printStackTrace(); 
    		%> 
    		<script>error();</script> 
    		<%  //업데이트가 제대로 실행되지 않은 경우
    	}finally{
    		if(rs!= null) try{rs.close();} catch(SQLException e){}
    		if(pstmt!=null)try{pstmt.close();}catch(SQLException e){}
    		if(conn!=null)try{conn.close();}catch(SQLException e){}
    	}
	}
		else{}
		

		%>
</body>
</html>
