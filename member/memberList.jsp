
<%@page import="com.study.member.vo.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/inc/header.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/inc/top.jsp"%>
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		conn = DriverManager.getConnection("jdbc:apache:commons:dbcp:study");
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT  																		");
		sb.append("      mem_id          , mem_pass     , mem_name      ,to_char(mem_bir, 'yyyy-mm-dd') as mem_bir		");
		sb.append("    , mem_zip         , mem_add1     , mem_add2      , mem_hp			");
		sb.append("    , mem_mail        , mem_job      , mem_hobby     , mem_mileage	");
		sb.append("    , mem_del_yn																");
		sb.append(" FROM																			");
		sb.append("    member																	");

		pstmt = conn.prepareStatement(sb.toString());
		rs =  pstmt.executeQuery();
		
		List<MemberVO> memberList = new ArrayList<>();
		while(rs.next()){
			MemberVO member = new MemberVO();
			member.setMemId(rs.getString("mem_id"));
			member.setMemPass(rs.getString("mem_pass"));
			member.setMemName(rs.getString("mem_name"));
			member.setMemBir(rs.getString("mem_bir"));
			member.setMemZip(rs.getString("mem_zip"));
			member.setMemAdd1(rs.getString("mem_add1"));
			member.setMemAdd2(rs.getString("mem_add2"));
			member.setMemHp(rs.getString("mem_hp"));
			member.setMemMail(rs.getString("mem_mail"));
			member.setMemJob(rs.getString("mem_job"));
			member.setMemHobby(rs.getString("mem_hobby"));
			member.setMemMileage(rs.getInt("mem_mileage"));
			member.setMemDelYn(rs.getString("mem_del_yn"));
			memberList.add(member);
		}
		request.setAttribute("memberList", memberList);
		
	}catch(SQLException e){
		e.printStackTrace();
	}finally{
		if(rs != null)  {try{rs.close();}  catch(Exception e){}}
		if(pstmt != null){try{pstmt.close();}catch(Exception e){}}
		if(conn != null){try{conn.close();}catch(Exception e){}}
	}
	

%>


 <div class="container">	
	<h3>회원목록</h3>		
	<div>
		<a href="memberForm.jsp" class="btn btn-primary btn-sm pull-right">회원 등록</a>
	</div>
	<table class="table table-striped table-bordered">
	<caption class="hidden">회원목록 조회</caption>
	<colgroup>
		<col style="width: 15%" />
		<col />
		<col style="width: 20%" />
		<col style="width: 20%" />
		<col style="width: 15%" />
		<col style="width: 15%" />
	</colgroup>
	<thead>
		<tr>
			<th>ID</th>
			<th>회원명</th>
			<th>HP</th>
			<th>생일</th>
			<th>직업</th>
			<th>마일리지</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${memberList }" var="member">
			<tr>
				<td>${member.memId}</td>
				<td><a href="memberView.jsp?memId=${member.memId }">${member.memName}	</a></td>
				<td>${member.memHp}</td>
				<td>${member.memBir}</td>
				<td>${member.memJob}</td>
				<td>${member.memMileage}</td>
			</tr>
		
		</c:forEach>

	</tbody>			
	</table>
</div>

</body>
</html>