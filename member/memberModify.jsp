
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/inc/header.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/inc/top.jsp"%>
<jsp:useBean id="member" class="com.study.member.vo.MemberVO"></jsp:useBean>
<jsp:setProperty property="*" name="member"/>
<%

	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try{
		conn = DriverManager.getConnection("jdbc:apache:commons:dbcp:study");
		StringBuffer sb = new StringBuffer();
		sb.append("UPDATE member SET												");
		sb.append("      mem_pass =?												");
		sb.append("     ,mem_name =?												");
		sb.append("     ,mem_zip = ?												");
		sb.append("     ,mem_add1 = ?												");
		sb.append("     ,mem_add2 = ?												");
		sb.append("     ,mem_bir = ?												");
		sb.append("     ,mem_mail = ?												");
		sb.append("     ,mem_hp = ?													");
		sb.append("     ,mem_job = ?												");
		sb.append("     ,mem_hobby = ?												");
		sb.append("WHERE mem_id = ?    												");
		pstmt = conn.prepareStatement(sb.toString());
		int cnt = 1;
		pstmt.setString(cnt++, member.getMemPass());
		pstmt.setString(cnt++, member.getMemName());
		pstmt.setString(cnt++, member.getMemZip());
		pstmt.setString(cnt++, member.getMemAdd1());
		pstmt.setString(cnt++, member.getMemAdd2());
		pstmt.setString(cnt++, member.getMemBir());
		pstmt.setString(cnt++, member.getMemMail());
		pstmt.setString(cnt++, member.getMemHp());
		pstmt.setString(cnt++, member.getMemJob());
		pstmt.setString(cnt++, member.getMemHobby());
		pstmt.setString(cnt++, member.getMemId());

		int resultCnt = pstmt.executeUpdate(); 		
		// 쿼리 업데이이

	}catch(SQLException e){
		e.printStackTrace();
	}finally{
		if(pstmt != null){try{pstmt.close();}catch(Exception e){}}
		if(conn != null){try{conn.close();}catch(Exception e){}}
	}



%>


	<div class="container">
		<h3>회원수정</h3>
		
			<div class="alert alert-success">정상적으로 수정했습니다.</div>
		
			<div class="alert alert-warning">수정하려는 글을 못 찾았습니다</div>
		
			<div class="alert alert-warning">수정실패</div>
	

		<a href="memberList.jsp" class="btn btn-default btn-sm"> <span class="glyphicon glyphicon-list" aria-hidden="true"></span> &nbsp;목록
		</a> <a href="memberView.jsp?memId=${member.memId }" class="btn btn-default btn-sm"> <span class="glyphicon glyphicon-list" aria-hidden="true"></span> &nbsp;해당 뷰
		</a>

	</div>
</body>
</html>