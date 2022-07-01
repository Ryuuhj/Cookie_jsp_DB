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
<%request.setCharacterEncoding("EUC-KR"); %>
<span>"<%= request.getParameter("GI")%>" 검색결과</span>
	<table width = 100% border="1">
	<thead>
		<tr>
		<td>방문월</td>
		<td>방문일</td>
		<td>성명</td>
		<td>연락처</td>
		<td>쇼핑백</td>
		<td>지불수단</td>
		<td>제품명</td> 
		<td>총 개수</td>
		<td>총 지불액</td>
		<td>주문확인</td>
		
		</tr>
	</thead>
	<tbody>
<%
		request.setCharacterEncoding("EUC-KR");
		String SO = request.getParameter("SO");
		String GI = request.getParameter("GI"); 
	
	
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
			String SQL = "Select O.vmonth, O.vday, C.C_name, C.pnumber, O.shopbag, O.payment, S.item_name, Sum(volume), Sum(priceSum), O.confirm "
			    	+ "From order_list O LEFT OUTER JOIN cookiestorage S "
			    	+ "ON O.item_id = S.item_id "
			    	+ "LEFT OUTER JOIN customer C "
			    	+ "ON O.ID = C.C_id "
			    	+ "Where C.C_name Like ? " //이름으로 검색했으므로 날짜 별로 묶어줌
			    	+ "Group By O.vmonth, O.vday ";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%"+GI+"%");
			
    		rs = pstmt.executeQuery(); //sql 실행한 결과-> rs에 저장

    		while(rs.next()) { 
    			String pn1 = rs.getString(4).substring(2,6);
	    		String pn2 = rs.getString(4).substring(6,10);
	    		%>
    		<tr><td><%= rs.getInt(1)%></td>
    		<td><%= rs.getInt(2)%></td>
    		<td><%= rs.getString(3)%></td>
    		<td><%="010-"+pn1+"-"+pn2%></td>
    		<td><%= rs.getString(5)%></td>
    		<td><%= rs.getString(6)%></td>
    		<td><%= rs.getString(7)%> 외...</td>
    		<td><%= rs.getInt(8)%></td>
    		<td><%= rs.getInt(9)%></td>
    		<td><%= rs.getString(10)%></td>
    		</tr>
    		</tbody>
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
