<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>.</title>
<link rel="stylesheet" href="style.css">
<script type="text/javascript">
	function reload(){
		opener.location.reload();
		alert("삭제 완료!");
	}
	function error(){
		alert("존재하지 않는 회원입니다.");
	}
</script>
</head>
<body>
<div class ="popframe" style="background-color: cornflowerblue;">
<span>회원 삭제</span>
<div class = "frm">
<form action="deleteCS.jsp">
회원 ID<br><br> <input type="text" name="C_ID" required="required"/><br><br>
<span style="font-size: 9pt; color: white; font-family: Gmarket ,sans-serif;">삭제할 회원 아이디를 입력하세요</span>
<input type="submit" id ="sb" value="DELETE"/>
</form>
	</div>
</div>

<%
		request.setCharacterEncoding("EUC-KR");
		String id = request.getParameter("C_ID");	
		//out.println("잘 받았나? "+id);
		
		if(id!=null){
		Connection conn =null; // DB 커넥션 연결 객체
		String USERNAME = "root";// DBMS접속 시 아이디
		String PASSWORD = "try1234";// DBMS접속 시 비밀번호
		String URL = "jdbc:mysql://localhost:3306/cookiedb?serverTimezone=UTC";// DBMS접속할 db명
		ResultSet rs = null; // 정보 담는 객체
		PreparedStatement pstmt = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			/* System.out.println("DB연결 성공"); */
		} catch (Exception e) {
			/* System.out.println("DB연결 실패 ");*/
		}
		try {
		String SQL = "delete from customer "
	    		+ "Where C_id = ? ";
		pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1,id); 
		
    	int k = pstmt.executeUpdate(); //sql 실행한 결과-> rs에 저장

    	if(k!=0){
    	%>
    	<script>reload();</script>
    	<% 
    	}else{
    	%>
        <script>error();</script>    
        <% 
    	}  	
	}
    	catch (Exception e) {
    		//System.out.print(e.getMessage());
    		e.printStackTrace();
    		%>
    		<script>error();</script>
    		<% 
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
