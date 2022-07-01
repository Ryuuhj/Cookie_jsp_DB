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
	function setup() {
		var op = document.getElementById("condition");
		var caption = document.getElementById("cnt_span");
		
		if(op.options[op.selectedIndex].value =='price'){ //첫번째 option 선택시
			caption.style.display = "none"; //설명 숨기기위해 style에서 display 속성 수정
		}else if (op.options[op.selectedIndex].value =='cnt'){ //날짜 선택시
			caption.style.display = "inline-block"; //input 보이게
		}
	}
	function reload(){
		opener.location.reload();
		alert("업데이트 완료!");
	}
	function error(){
		alert("오류_입력 값이 잘못되었습니다.");
	}
</script>
</head>
<body>
<div class ="popframe">
<span>상품 업데이트</span>
<div class = "frm">
<form action="updateIV.jsp">
상품 ID<br><br> <input type="text" name="itemID" placeholder="ex.walnut" required="required"/><br><br>
<span style="margin-right:10px">변경 항목  </span><br><br>
<select id="condition" name='condition' onchange="setup();" required="required">
	    	<option value = 'cnt'>수량</option>
	    	<option value = 'price'>가격</option>
</select>
<input id = "input1" type="number" name='changeq' required="required" min="-10000"/><br>
<span id="cnt_span" style="font-size: x-small; color: gray;">n개 추가일 경우) n <br> n개 차감일 경우) -n</span>
<input type="submit" id ="sb" value="UPDATE"/>
</form>
</div>
</div>
<%
request.setCharacterEncoding("EUC-KR");
		String id = request.getParameter("itemID");	
		String cond = request.getParameter("condition");
		String c3 = request.getParameter("changeq"); 
		if(c3!=null){
			int cq = Integer.parseInt(c3);
	
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
		if(cond.equals("cnt")){
			try {
			out.println();
			String SQL = "Update cookiestorage "
					+ "SET i_cnt= i_cnt + ? "
	    			+ "Where item_id = ? ";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,cq); //음수면 i_cnt - n이 될 것
			pstmt.setString(2, id);
			
    		pstmt.executeUpdate(); 
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
		else if(cond.equals("price")){
			try {
				String SQL = "Update cookiestorage "
						+ "SET price=? "
		    			+ "Where item_id = ?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1,cq);
				pstmt.setString(2, id);
				
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
		}else{
			
		}
		}
		else{
			
		}

		%>
</body>
</html>
