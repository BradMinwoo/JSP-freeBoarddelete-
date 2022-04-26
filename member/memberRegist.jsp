
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.study.member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/inc/header.jsp"%>
</head>
<body>
	<%@ include file="/WEB-INF/inc/top.jsp"%>
<jsp:useBean id="member" class="com.study.member.vo.MemberVO"></jsp:useBean>
<jsp:setProperty property="*" name="member"/>
<%
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try{
		conn = DriverManager.getConnection("jdbc:apache:commons:dbcp:study");
		StringBuffer sb = new StringBuffer();
		sb.append("	INSERT INTO member (	   											");
		sb.append("      mem_id      , mem_pass     , mem_name    , mem_bir		");
		sb.append("    , mem_zip     , mem_add1     , mem_add2    , mem_hp			");
		sb.append("    , mem_mail    , mem_job      , mem_hobby   , mem_mileage	");
		sb.append("    , mem_del_yn														");
		sb.append("	) VALUES (															");
		sb.append("     ?            ,?              ,?            ,?				");
		sb.append("    ,?            ,?              ,?            ,?				");
		sb.append("    ,?            ,?              ,?            ,0				");
		sb.append("    ,'N'																");
		sb.append("	)																	");

		pstmt = conn.prepareStatement(sb.toString());
		int cnt = 1;
		pstmt.setString(cnt++, member.getMemId());
		pstmt.setString(cnt++, member.getMemPass());
		pstmt.setString(cnt++, member.getMemName());
		pstmt.setString(cnt++, member.getMemBir());
		pstmt.setString(cnt++, member.getMemZip());
		pstmt.setString(cnt++, member.getMemAdd1());
		pstmt.setString(cnt++, member.getMemAdd2());
		pstmt.setString(cnt++, member.getMemHp());
		pstmt.setString(cnt++, member.getMemMail());
		pstmt.setString(cnt++, member.getMemJob());
		pstmt.setString(cnt++, member.getMemHobby());
	
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
		<h3>회원등록</h3>
		
			<div class="alert alert-success">정상적으로 회원 등록 되었습니다.</div>
		
			<div class="alert alert-warning">아이디 중복</div>
			<a href="#" class="btn btn-default btn-sm" onclick="history.back();"> <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> &nbsp;뒤로가기
			</a>
	

		
			<div class="alert alert-warning">등록 실패 </div>
		

		<a href="memberList.jsp" class="btn btn-default btn-sm"> <span class="glyphicon glyphicon-list" aria-hidden="true"></span> &nbsp;목록
		</a>
	</div>
</body>
</html>