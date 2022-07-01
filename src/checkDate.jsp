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
<span>"<%= request.getParameter("GI")%>" 검색결과</span> <!-- input값을 form으로부터 전달 받아 표시함 -->
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
		<td>개수</td>
		<td>지불액</td>
		<td>스티커</td>
		<td>주문확인</td>
		<td>확정</td>
		</tr>
	</thead>
	<tbody>
<%
		request.setCharacterEncoding("EUC-KR");
		String SO = request.getParameter("SO");
		String GI = request.getParameter("GI");//input값을 form으로부터 전달 받아 표시함
	
	
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
				
				String[] num = GI.split("/");
				int m = Integer.parseInt(num[0]);
				int d = Integer.parseInt(num[1]);
				String SQL = "Select O.vmonth, O.vday, C.C_name, C.pnumber, O.shopbag, O.payment, S.item_name, O.volume, O.priceSum, R.base, O.confirm, O.ID  "
				    	+ "From order_list O LEFT OUTER JOIN cookiestorage S "
				    	+ "ON O.item_id = S.item_id "
				   		+ "LEFT OUTER JOIN customer C "
				   	    + "ON O.ID = C.C_id "
				   	    + "LEFT OUTER JOIN recipe R "
				    	+ "ON O.item_id = R.item_id "
				   	    + "Where O.vmonth = ? " //날짜로 검색 했으므로 날짜 조건 부여
				   	    + "and O.vday = ? ";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, m);
			pstmt.setInt(2, d);
			
    		rs = pstmt.executeQuery(); //rs를 통해 쿼리문 결과 접근

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
    		<td><%= rs.getString(7)%></td>
    		<td><%= rs.getInt(8)%></td>
    		<td><%= rs.getInt(9)%></td>
    		<%if(rs.getString(10).equals("Vegan")){ %> <!-- 비건 쿠키일 경우에 포장지에 스티커 부착 체크 -->
    		<td>O</td>
    		<%}else{
    		%><td>X</td><% 
    		} %>
    		<td><%= rs.getString(11)%></td>
    		<%if(rs.getString(11).equals("X")){ %>
    		<td><a href="<%=request.getContextPath()%>/updateOdlist.jsp?s_month=<%=rs.getInt(1)%>&s_day=<%=rs.getInt(2)%>&s_id=<%=rs.getString(12)%>">확정</a></td>
    		<%}else{
    		%>
    		<td>-</td>
    		<% 
    		} %>
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
		</table>
</body>
</html>
