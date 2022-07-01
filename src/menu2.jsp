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
</script>
</head>
<body>
    <jsp:include page="header.jsp" flush="false"/>
    
  <div class="context">
    <div class="context-top">
    <h3>[현재 판매중인 상품 재고]</h3><br>
    <button onclick="openpage('updateIV.jsp','업데이트');">상품 업데이트</button>
    <button onclick="openpage('deletIV.jsp','삭제')">상품 삭제</button>
    <button onclick="openpage('insertIV.jsp','추가')">상품 추가</button>
    </div>
    <div class="table_o">
	<div class="table">
		<span> </span>
		<table border="1">
		<thead>
		<tr>
		<td>상품 ID</td>
		<td>상품명</td>
		<td>재고 수량</td>
		<td>가격</td>
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
			String SQL = "Select * from cookiestorage"; //전체 테이블 출력
			    
			pstmt = conn.prepareStatement(SQL);
			
    		rs = pstmt.executeQuery(); 

    		while(rs.next()) { %>
    		<tr>
    		<td><%= rs.getString(1)%></td>
    		<td><%= rs.getString(2)%></td>
    		<td><%= rs.getInt(3)%></td>
    		<td><%= rs.getInt(4)%></td>
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
		</div>
	</div>
</div>

</body>
</html>
