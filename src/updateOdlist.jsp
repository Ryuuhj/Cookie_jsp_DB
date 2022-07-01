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
		alert("구매 확정 되었습니다");
		history.back();}//자동 뒤로가기
	function error(){
		alert("오류_입력 값이 잘못되었습니다.");//에러 메시지 출력
	}
</script>
</head>
<body>
<%
		request.setCharacterEncoding("EUC-KR");
		String month = request.getParameter("s_month");
		String day = request.getParameter("s_day");	
		String id = request.getParameter("s_id"); 
		if(month!=null && day !=null){
			int m = Integer.parseInt(month);
			int d = Integer.parseInt(day);
			//out.println(month+"/"+day); 디버깅용
	
		Connection conn =null; // DB 커넥션 연결 객체
		String USERNAME = "root";// DBMS접속 시 아이디
		String PASSWORD = "try1234";// DBMS접속 시 비밀번호
		String URL = "jdbc:mysql://localhost:3306/cookiedb?serverTimezone=UTC";// DBMS접속할 db명
		ResultSet rs = null; 
		PreparedStatement pstmt = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			/* System.out.println("DB연결 성공"); */
		} catch (Exception e) {
			/* System.out.println("DB연결 실패 ");*/
		}
		try {
		String SQL = "Update order_list "
					+ "SET confirm = 'O' "
	    			+ "Where vmonth = ? "
	    			+ "AND vday = ? "
	    			+ "AND ID = ? ";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,m); 
			pstmt.setInt(2,d); 
			pstmt.setString(3, id);
			
    		pstmt.executeUpdate(); //sql 실행한 결과-> rs에 저장
    		%>
    		<script>reload();</script>
    		<% 
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
		}else{}
		

		%>
</body>
</html>
