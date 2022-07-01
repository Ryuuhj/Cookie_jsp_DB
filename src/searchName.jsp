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

<span>"<%= request.getParameter("sch_i")%>"검색 결과</span>
	<table width = 100% border="1">
	<thead>
		<tr>
		<td>ID</td>
		<td>Password</td>
		<td>이름</td>
		<td>전화번호</td>
		<td>생년월일</td>
		</tr>
	</thead>
	<tbody>
	<%
	
	//out.println(sch);
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
		//out.println("dd");
	}
	try {
		request.setCharacterEncoding("EUC-KR");
		String sch = request.getParameter("sch");
		String sch_i = request.getParameter("sch_i");
		
		String SQL = "Select * from customer "
		    	+ "Where C_name Like ? "; //글차 포함하는 모든 결과 배출
		//out.println("dd");
		pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1,"%"+sch_i+"%");
		//out.println(sch_i);
		rs = pstmt.executeQuery(); //sql 실행한 결과-> rs에 저장

		while(rs.next()) { 
    		String pn1 = rs.getString(4).substring(2,6);
    		String pn2 = rs.getString(4).substring(6,10);
    		%>
    		<tr>
    		<td><%= rs.getString(1)%></td>
    		<td><%= rs.getString(2)%></td>
    		<td><%= rs.getString(3)%></td>
    		<td><%="010-"+pn1+"-"+pn2%></td>
    		<td><%= rs.getInt(5)%></td>
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
