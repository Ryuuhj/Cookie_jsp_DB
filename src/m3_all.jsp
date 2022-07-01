<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="style.css">
</head>
<body>
	<table width = 100% border="1">
	<thead>
		<tr>
		<td>상품 ID</td>
		<td>상품명</td>
		<td>재료</td>
		<td>특징</td>
		</tr>
	</thead>
	<tbody>
<%
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
			
			String SQL = "Select R.item_id, C.item_name, SR.ingredient, R.ingredient, R.base "
		    		+ "From recipe R "
		    		+ "LEFT OUTER JOIN cookiestorage C "
		    		+ "ON R.item_id = C.item_id "
		    		+ "LEFT OUTER JOIN recipe SR "
				   	+ "ON R.base = SR.item_id "	    		
		    		+ "Where exists (select * "
		    		+ "from recipe R "
		    		+ "where R.base = SR.item_id) "
		    		+ "order by R.item_id";
			pstmt = conn.prepareStatement(SQL);
			
    		rs = pstmt.executeQuery(); //sql 실행한 결과-> rs에 저장

    		while(rs.next()) { 
    		%>
    		<tr><td><%= rs.getString(1)%></td>
    		<%
    		if(rs.getString(2)!=null){ 
    		%>
    		<td><%= rs.getString(2)%></td>
    		<%}
    		else{
    		%>
    		<td>-</td>
    		<%
    		} %>
    		<td><%= rs.getString(3)+", "+rs.getString(4)%></td>
    		<td><%= rs.getString(5)%></td>
    		</tr>
    		
    		<% 
    		}
		}
    	catch (Exception e) {
    		out.println(e.getMessage());
    		e.printStackTrace();
    	}finally{
    		if(rs!= null) try{rs.close();} catch(SQLException e){}
    		if(pstmt!=null)try{pstmt.close();}catch(SQLException e){}
    		if(conn!=null)try{conn.close();}catch(SQLException e){}
    		}
		%>
		</tbody>
		
		</table>
		
		
</body>
</html>
