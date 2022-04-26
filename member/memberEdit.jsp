
<%@page import="java.util.ArrayList"%>
<%@page import="com.study.member.vo.MemberVO"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
	String memId = request.getParameter("memId");
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		conn = DriverManager.getConnection("jdbc:apache:commons:dbcp:study");
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT  																		");
		sb.append("      mem_id          , mem_pass     , mem_name      , to_char(mem_bir, 'yyyy-mm-dd') as mem_bir			");
		sb.append("    , mem_zip         , mem_add1     , mem_add2      , mem_hp			");
		sb.append("    , mem_mail        , mem_job      , mem_hobby     , mem_mileage	");
		sb.append("    , mem_del_yn																");
		sb.append(" FROM																			");
		sb.append("    member																	");
		sb.append(" WHERE mem_id = ?															");
	
		pstmt = conn.prepareStatement(sb.toString());
		//쿼리 실행전  값 세 
		pstmt.setString(1, memId);
		
		rs =  pstmt.executeQuery();
		
		List<MemberVO> memberList = new ArrayList<>();
		if(rs.next()){
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
			request.setAttribute("member", member);
		}
		
	}catch(SQLException e){
		e.printStackTrace();
	}finally{
		if(rs != null)  {try{rs.close();}  catch(Exception e){}}
		if(pstmt != null){try{pstmt.close();}catch(Exception e){}}
		if(conn != null){try{conn.close();}catch(Exception e){}}
	}

%>


	
		<div class="alert alert-warning">해당 멤버를 찾을 수 없습니다</div>
		<a href="memberList.jsp" class="btn btn-default btn-sm"> <span class="glyphicon glyphicon-list" aria-hidden="true"></span> &nbsp;목록
		</a>



 <div class="container">	
	<h3>회원 정보 수정</h3>	
	<form action="memberModify.jsp" method="post" >
	<table class="table table-striped table-bordered">
		<tbody>
			<tr>
				<th>아이디</th>
				<td>${member.memId }<input type="hidden" name="memId" value="${member.memId }"></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="mem	Pass" class="form-control input-sm" 
						    pattern="\w{4,}" title="알파벳과 숫자로 4글자 이상 입력" ></td>
			</tr>
			<tr>
				<th>회원명</th>
				<td><input type="text" name="memName" class="form-control input-sm" value="${member.memName }"
						   required="required" pattern="[가-힣]{2,}" title="한글로 2글자 이상 입력" ></td>
			</tr>
			<tr>
				<th>우편번호</th>
				<td><input type="text" name="memZip" class="form-control input-sm" value="${member.memZip }"></td>
			
			</tr>
			<tr>
				<th>주소</th>
				<td><input type="text" name="memAdd1" class="form-control input-sm" value="${member.memAdd1 }">
					<input type="text" name="memAdd2" class="form-control input-sm" value="${member.memAdd2 }">
				</td>
			</tr>
			<tr>
				<th>생일</th>
				<td><input type="date" name="memBir" class="form-control input-sm" value="${member.memBir }"></td>
			</tr>
			<tr>
				<th>메일</th>
				<td><input type="email" name="memMail" class="form-control input-sm" required="required" value="${member.memMail }"></td>
			</tr>
			<tr>
				<th>핸드폰</th>
				<td><input type="tel" name="memHp" class="form-control input-sm" value="${member.memHp }"></td>
			</tr>
			<tr>
				<th>직업</th>
				<td>
				
					<select name="memJob" class="form-control input-sm" >
						<option value="">-- 직업 선택 --</option>
						<option value="JB01" ${member.memJob eq "JB01" ? "selected='selected'":""}>주부</option>
						<option value="JB02" ${member.memJob eq "JB2" ? "selected='selected'":""}>은행원</option>
						<option value="JB03"  ${member.memJob eq "JB03" ? "selected='selected'":""}>공무원</option>
						<option value="JB04"  ${member.memJob eq "JB04" ? "selected='selected'":""}>축산업</option>
						<option value="JB05"  ${member.memJob eq "JB05" ? "selected='selected'":""}>회사원</option>
						<option value="JB06"  ${member.memJob eq "JB06" ? "selected='selected'":""}>농업</option>
						<option value="JB07"  ${member.memJob eq "JB07" ? "selected='selected'":""}>자영업</option>
						<option value="JB08"  ${member.memJob eq "JB08" ? "selected='selected'":""}>학생</option>
						<option value="JB09" ${member.memJob eq "JB09" ? "selected='selected'":""} >교사</option>					
					</select>			
				</td>
			</tr>
			<tr>
				<th>취미</th>
				<td>
				
					<select name="memHobby" class="form-control input-sm" >
						<option value="">-- 취미 선택 --</option>
						<option value="HB01" ${member.memHobby eq "HB01" ? "selected='selected'":""}>서예</option>
						<option value="HB02" ${member.memHobby eq "HB02" ? "selected='selected'":""}>장기</option>
						<option value="HB03" ${member.memHobby eq "HB03" ? "selected='selected'":""}>수영</option>
						<option value="HB04" ${member.memHobby eq "HB04" ? "selected='selected'":""}>독서</option>
						<option value="HB05" ${member.memHobby eq "HB05" ? "selected='selected'":""}>당구</option>
						<option value="HB06" ${member.memHobby eq "HB06" ? "selected='selected'":""}>바둑</option>
						<option value="HB07" ${member.memHobby eq "HB07" ? "selected='selected'":""}>볼링</option>
						<option value="HB08" ${member.memHobby eq "HB08" ? "selected='selected'":""}>스키</option>
						<option value="HB09" ${member.memHobby eq "HB09" ? "selected='selected'":""}>만화</option>
						<option value="HB10" ${member.memHobby eq "HB10" ? "selected='selected'":""}>낚시</option>
						<option value="HB11" ${member.memHobby eq "HB11" ? "selected='selected'":""}>영화감상</option>
						<option value="HB12" ${member.memHobby eq "HB12" ? "selected='selected'":""}>등산</option>
						<option value="HB13" ${member.memHobby eq "HB13" ? "selected='selected'":""}>개그</option>
						<option value="HB14" ${member.memHobby eq "HB14" ? "selected='selected'":""}>카레이싱</option>					
					</select>			
				</td>
			</tr>	
			<tr>
				<th>마일리지</th>
				<td>${member.memMileage }</td>
			</tr>	
			<tr>
				<th>탈퇴여부</th>
				<td>${member.memDelYn }</td>
			</tr>	
			<tr>
				<td colspan="2">
					<a href="memberList.jsp" class="btn btn-info btn-sm">
					<span class="glyphicon glyphicon-list" aria-hidden="true"></span>
					&nbsp;목록으로
					</a>
					<button type="submit" class="btn btn-primary">
					<span class="glyphicon glyphicon-heart" aria-hidden="true"></span>
					&nbsp;&nbsp; 저장
					</button>
					
						<button type="submit" formaction="memberDelete.jsp" class="btn btn-danger btn-sm">
					<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
					&nbsp;&nbsp; 삭제
					</button>
					
					
				</td>
			</tr>
		</tbody>	
	</table>
	</form>
</div>


</body>
</html>