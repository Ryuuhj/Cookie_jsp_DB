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
<span>검색 결과</span>
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
			String SQL = "Select O.vmonth, O.vday, C.C_name, C.pnumber, O.shopbag, O.payment, S.item_name, O.volume, O.priceSum, R.base, O.confirm, O.ID "
		    			+ "From order_list O LEFT OUTER JOIN cookiestorage S " //O.id는 확인 버튼을 통한 정보 전송에 필요하기에 추출
		    			+ "ON O.item_id = S.item_id "
		    			+ "LEFT OUTER JOIN customer C "
		    	    	+ "ON O.ID = C.C_id "
						+ "LEFT OUTER JOIN recipe R "
		    	    	+ "ON O.item_id = R.item_id ";
			
			pstmt = conn.prepareStatement(SQL);
    		rs = pstmt.executeQuery(); //sql 실행한 결과-> rs로 접근

    		while(rs.next()) { 	
    			String pn1 = rs.getString(4).substring(2,6);
	    		String pn2 = rs.getString(4).substring(6,10); //전화번호 substring으로 나눔
	    		%>
    		<tr><td><%= rs.getInt(1)%></td>
    		<td><%= rs.getInt(2)%></td>
    		<td><%= rs.getString(3)%></td>
    		<td><%="010-"+pn1+"-"+pn2%></td> <!-- 나눈 것은 -을 중간에 넣어 가독성 높임 -->
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
    		<td><button type="button" onclick="location.href='<%=request.getContextPath()%>/updateOdlist.jsp?s_month=<%=rs.getInt(1)%>&s_day=<%=rs.getInt(2)%>&s_id=<%=rs.getString(12)%>'">V</button></td><!-- 확인 버튼에 링크 연결해서 update처리하는 jsp로 이동, 이동할 때 처리할 튜플 구분위한 정보 같이 데리고 감 -->
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
		</tbody>
		
		</table>
		
		
</body>
</html>
