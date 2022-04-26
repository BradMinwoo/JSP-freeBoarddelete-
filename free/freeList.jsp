
<%@page import="java.util.ArrayList"%>
<%@page import="com.study.free.vo.FreeBoardVO"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html lang="ko">
<head>
<%@include file="/WEB-INF/inc/header.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/inc/top.jsp"%>
<%
	// 1. 로드(서버 켜질 때 됨 jsp에서 필요 없음)  2. 연결(Conn 을 dbcp에서 얻기)   3. 수행 pstmt  4. 종료
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try{
			conn = DriverManager.getConnection("jdbc:apache:commons:dbcp:study");
			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT                                          ");
			sb.append("	 	  bo_no       , bo_title    , bo_category  ");
			sb.append("	 	, bo_writer   , bo_pass     , bo_content   ");
			sb.append("	 	, bo_ip       , bo_hit      , bo_reg_date  ");
			sb.append("	 	, bo_mod_date , bo_del_yn                  ");
			sb.append(" FROM free_board                                 ");			
			
			pstmt = conn.prepareStatement(sb.toString());
			rs=pstmt.executeQuery();
			
			List<FreeBoardVO> freeBoardList = new ArrayList<>(); 
			while(rs.next()){
				FreeBoardVO freeBoard = new FreeBoardVO();
				freeBoard.setBoNo(rs.getInt("bo_no"));
				freeBoard.setBoTitle(rs.getString("bo_title"));
				freeBoard.setBoCategory(rs.getString("bo_category"));
				freeBoard.setBoWriter(rs.getString("bo_writer"));
				freeBoard.setBoPass(rs.getString("bo_pass"));
				freeBoard.setBoContent(rs.getString("bo_content"));
				freeBoard.setBoIp(rs.getString("bo_ip"));
				freeBoard.setBoHit(rs.getInt("bo_hit"));
				freeBoard.setBoRegDate(rs.getString("bo_reg_date"));
				freeBoard.setBoModDate(rs.getString("bo_mod_date"));
				freeBoard.setBoDelYn(rs.getString("bo_del_yn"));
				freeBoardList.add(freeBoard);
			}
			request.setAttribute("freeBoardList", freeBoardList);
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			if(rs != null)  {try{rs.close();}  catch(Exception e){}}
			if(pstmt != null){try{pstmt.close();}catch(Exception e){}}
			if(conn != null){try{conn.close();}catch(Exception e){}}
		}
%>


<div class="container">
	<div class="page-header">
		<h3>자유게시판 - <small>글 목록</small></h3>
	</div>
<div class="row">
    <div class="col-sm-2 col-sm-offset-10 text-right" style="margin-bottom: 5px;" >
        <a href="freeForm.jsp" class="btn btn-primary btn-sm"> 
        	<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>
        	&nbsp;새글쓰기
		</a>
    </div>
</div>
	<table class="table table-striped table-bordered table-hover">
	<colgroup>
		<col width="10%" />
		<col width="15%" />
		<col />
		<col width="10%" />
		<col width="15%" />
		<col width="10%" />
	</colgroup>
	<thead>
		<tr>
			<th>글번호</th>
			<th>분류</th>
			<th>제목</th>
			<th>작성자</th>
			<th>등록일</th>
			<th>조회수</th>
		</tr>
	</thead>	
	<tbody>

			<tr class="text-center">
				<td>글번호1</td>
				<td>분류1</td>
				<td class="text-left">
					<a href="freeView.jsp?boNo=">
						제목1
					</a>
				</td>				<td>작성자1</td>
				<td>등록일1</td>
				<td>조회수1</td>
			</tr>
			
			<c:forEach items="${freeBoardList }" var="freeBoard">
				<tr>
					<td>${freeBoard.boNo }</td>
					<td>${freeBoard.boCategory }</td>
					<td><a href="freeView.jsp?boNo=${freeBoard.boNo }">${freeBoard.boTitle } </a></td>
					<td>${freeBoard.boWriter }</td>
					<td>${freeBoard.boRegDate }</td>
					<td>${freeBoard.boHit }</td>
				</tr>
			 </c:forEach>
			
			
			
	</tbody>
	</table>
</div><!-- container --> 
</body>
</html>






