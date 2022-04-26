
<%@page import="java.util.ArrayList"%>
<%@page import="com.study.free.vo.FreeBoardVO"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/inc/header.jsp"%>
<title>자유게시판 - 글 보기</title>
</head>
<body>
	<%@ include file="/WEB-INF/inc/top.jsp"%>

	<%
	// 1. 로드(서버 켜질 때 됨 jsp에서 필요 없음)  2. 연결(Conn 을 dbcp에서 얻기)   3. 수행 pstmt  4. 종료
			
			int boNo = Integer.parseInt(request.getParameter("boNo"));
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
				sb.append(" WHERE bo_no = ?                                 ");			
				
				pstmt = conn.prepareStatement(sb.toString());
				// 쿼리 실행전에 ? 세팅
				pstmt.setInt(1, boNo);
				
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
					request.setAttribute("freeBoard", freeBoard);
				}
				
			}catch(SQLException e){
				e.printStackTrace();
			}finally{
				if(rs != null)  {try{rs.close();}  catch(Exception e){}}
				if(pstmt != null){try{pstmt.close();}catch(Exception e){}}
				if(conn != null){try{conn.close();}catch(Exception e){}}
			}
	%>

	
	<div class="alert alert-warning">
			해당 글이 존재하지 않습니다.
			또는 조회수증가 실패했습니다.
	</div>	
		<a href="freeList.jsp" class="btn btn-default btn-sm">
		<span class="glyphicon glyphicon-list" aria-hidden="true"></span>
		&nbsp;목록
	</a>


		<div class="container">
			<div class="page-header">
				<h3>
					자유게시판 - <small>글 보기</small>
				</h3>
			</div>
			<table class="table table-striped table-bordered">
				<tbody>
					<tr>
						<th>글번호</th>
						<td>${freeBoard.boNo }</td>
					</tr>
					<tr>
						<th>글제목</th>
						<td>${freeBoard.boTitle }</td>
					</tr>
					<tr>
						<th>글분류</th>
						<td>${freeBoard.boCategory }</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${freeBoard.boWriter }</td>
					</tr>
					<!-- 비밀번호는 보여주지 않음  -->
					<tr>
						<th>내용${freeBoard.boContent }</th>
						<td>${freeBoard.boContent }	</td>
					</tr>
					<tr>
						<th>등록자 IP</th>
						<td>${freeBoard.boIp }</td>
					</tr>
					<tr>
						<th>조회수</th>
						<td>${freeBoard.boHit }</td>
					</tr>
					<tr>
						<th>최근등록일자</th>
						<td> 수정했다면 수정한 날짜, 수정을 안했다면 등록한 날짜,
						 ${freeBoard.boModDate ne null? 
						 freedBoard.boModDate : freeBoard.boRegDate } 출력 ; 수정날짜 or 등록날짜
						 
						 </td>
					</tr>
					<tr>
						<th>삭제여부</th>
						<td>${freeBoard.boDelYn }</td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="pull-left">
								<a href="freeList.jsp" class="btn btn-default btn-sm"> <span class="glyphicon glyphicon-list" aria-hidden="true"></span> &nbsp;&nbsp;목록
								</a>
							</div>
							<div class="pull-right">
								<a href="freeEdit.jsp?boNo=${freeBoard.boNo }" class="btn btn-success btn-sm"> <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> &nbsp;&nbsp;수정
								</a>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- container -->

</body>
</html>






