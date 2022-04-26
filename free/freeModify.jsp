
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="/WEB-INF/inc/header.jsp"%>
<title>Insert title here</title>
</head>
<body>
<%@include file="/WEB-INF/inc/top.jsp"%>
<jsp:useBean id="freeBoard" class="com.study.free.vo.FreeBoardVO"></jsp:useBean>
<jsp:setProperty property="*" name="freeBoard"/>
<%
	freeBoard.setBoIp(request.getRemoteAddr()); // localhost = 0 : 0 : 0 : 1
	Connection conn =null;
	PreparedStatement pstmt = null;
	
		//Resultset은 필요 없다. 업데이트에서는 필요 없다. 디비 결과가 화면에 나올 필요가 없기 때문에

	try{
		conn = DriverManager.getConnection("jdbc:apache:commons:dbcp:study");
		StringBuffer sb = new StringBuffer();
		// alt shift a
		sb.append("UPDATE free_board SET			 		");
		sb.append("      bo_title              = ?		");
		sb.append("    , bo_category           = ?		");
		sb.append("    , bo_content            = ?		");
		sb.append("    , bo_ip                 = ?		");
		sb.append("    , bo_hit                = bo_hit+1");
		sb.append("    , bo_mod_date           = sysdate	");
		sb.append("where bo_no = ?							");
		pstmt = conn.prepareStatement(sb.toString());
		int cnt  = 1;
		pstmt.setString(cnt++, freeBoard.getBoTitle());
		pstmt.setString(cnt++, freeBoard.getBoCategory());
		pstmt.setString(cnt++, freeBoard.getBoContent());
		pstmt.setString(cnt++, freeBoard.getBoIp());
		pstmt.setInt(cnt++, freeBoard.getBoNo());
		int resultCnt = pstmt.executeUpdate(); // 1개 행만 수행하였으므로 return int로 받을 수 있음.
		
	}catch(SQLException e){
 	e.printStackTrace();
	}finally{
		if(pstmt != null){try{pstmt.close();}catch(Exception e){}}
		if(conn != null){try{conn.close();}catch(Exception e){}}

	}
	//edit에서 사용자가 수정한거 DB에서 수정되도록
	// DB와 연동이 안됨.
%>
	
		<div class="alert alert-warning">
			해당 글이 존재하지 않습니다.
		</div>	

	
	
		<div class="alert alert-warning">
			수정 실패
		</div>	

		<div class="alert alert-warning">
			비밀번호가 틀립니다.
		</div>	
	
		
		

		<div class="alert alert-success">
			정상적으로 수정했습니다.
		</div>		
	
		
	<a href="freeView.jsp?boNo=" class="btn btn-default btn-sm">
		<span class="glyphicon glyphicon-list" aria-hidden="true"></span>
		&nbsp;해당 뷰
	</a>	
	
	<a href="freeList.jsp" class="btn btn-default btn-sm">
		<span class="glyphicon glyphicon-list" aria-hidden="true"></span>
		&nbsp;목록
	</a>


</body>
</html>