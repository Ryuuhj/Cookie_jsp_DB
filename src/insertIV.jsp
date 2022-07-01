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
		alert("추가 완료!");
	}
	function error(){
		alert("추가에 실패했습니다.\n상품에 추가하기 위해선 메뉴정보에 상품등록이 선행되어야 합니다! ");
	}
</script>
</head>
<body>
<div class ="popframe">
<span>상품 추가</span>
<div class = "frm">
<span id="cnt_span" style="font-size: small; color: red;">쿠키 정보가 선행되어야 합니다.<br>메뉴정보 카테고리를 참고하세요.<br></span>
<form action="insertIV.jsp">
<br>
상품 ID <input type="text" name="itemID" placeholder="ex.walnut" required="required"/><br>
상품명 <input type="text" name="itemName" placeholder="ex.월넛 초코칩 쿠키" required="required"/><br>
수량 <input type="number" name="count" min="0" required="required"/><br>
가격 <input type="number" name="price" min="0" required="required"/><br>
<input type="submit" id ="sb" value="INSERT"/>
</form>
</div>
</div>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = request.getParameter("itemID");	
		String name = request.getParameter("itemName");	
		String s_cnt = request.getParameter("count");
		String s_price = request.getParameter("price"); 
		 
		if(s_cnt!=null && s_price !=null){
			
			Connection conn =null; // DB 커넥션 연결 객체
			String USERNAME = "root";// DBMS접속 시 아이디
			String PASSWORD = "try1234";// DBMS접속 시 비밀번호
			String URL = "jdbc:mysql://localhost:3306/cookiedb?serverTimezone=UTC";// DBMS접속할 db명
			ResultSet rs = null; // 정보 담는 객체
			PreparedStatement pstmt = null;
			
			int cnt = Integer.parseInt(s_cnt);
			int price = Integer.parseInt(s_price);
			
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			/* System.out.println("DB연결 성공"); */
		}catch (Exception e) {
			/* System.out.println("DB연결 실패 ");*/
		}
		
		try {
		String SQL = "Insert into cookiestorage values(?,?,?,?) ";
		pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1,id);
		pstmt.setString(2,name);
		pstmt.setInt(3,cnt);
		pstmt.setInt(4,price);
		
    	pstmt.executeUpdate(); //insert 실행한 결과-> 존재하면	
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
		}
		else{}

		%>
</body>
</html>
