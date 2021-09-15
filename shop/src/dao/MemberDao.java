package dao;

//import java.lang.reflect.Member;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import commons.*;
import vo.Member;

public class MemberDao {
	
	/* 1. 회원가입 */
	public void insertMember(Member member) throws ClassNotFoundException, SQLException {
	      // 1-0. 회원가입을 위해 입력받은 정보들 디버깅
		  System.out.println("**[Debug] MemberDao/insertMember() | Start");
	      System.out.println("*[Debug] " + member.getMemberId() +" <-- MemberDao.insertMebmer | param memberId");
	      System.out.println("*[Debug] " + member.getMemberPw() +" <-- MemberDao.insertMebmer | param memberPw");
	      System.out.println("*[Debug] " + member.getMemberName() +" <-- MemberDao.insertMebmer | param memberName");
	      System.out.println("*[Debug] " + member.getMemberAge() +" <-- MemberDao.insertMebmer | param memberAge");
	      System.out.println("*[Debug] " + member.getMemberGender() +" <-- MemberDao.insertMebmer | param memberGender");
	      
	      // 1-1. DB 연결
	      DBUtil dbUtil = new DBUtil();
	      Connection conn = dbUtil.getConnection();
	      
	      // 1-2. 회원가입을 하기 위한 회원정보 삽입 쿼리
	      String sql = "INSERT INTO member(member_id, member_pw, member_level, member_name, member_age, member_gender, update_date, create_date) VALUES(?, PASSWORD(?), 0, ?, ?, ?, NOW(), NOW())";
	      PreparedStatement stmt = conn.prepareStatement(sql);
	      
	      stmt.setString(1, member.getMemberId());
	      stmt.setString(2, member.getMemberPw());
	      stmt.setString(3, member.getMemberName());
	      stmt.setInt(4, member.getMemberAge());
	      stmt.setString(5, member.getMemberGender());
	      
	      // 1-3. 쿼리 실행
	      int row = stmt.executeUpdate();
	      
	      // 1-4. 사용한 자원 반환
	      stmt.close();
	      conn.close();
	      
	      // 1-5. 쿼리 실행결과 디버깅
	      if(row == 1) {
	    	  System.out.println("**[Debug] 회원가입 성공 <-- MemberDao/insertMember()");
	    	  return;
	      }
	      	  System.out.println("***[Debug] 회원가입 실패 <-- MemberDao/insertMember()");
	      	  return;
	}
	
	/* 2. 회원 로그인 */
	public Member login(Member member) throws ClassNotFoundException, SQLException {
		System.out.println("**[Debug] MemberDao/login() | Start");
		
		// 2-0. 로그인 정보 리턴용 객체 선언
		Member returnMember = null;
		
		// 2-0. 입력받은 member의 Id와 Pw 정보 디버깅
		System.out.println("*[Debug] " + member.getMemberId()+" <-- MemberDao.login | param : member.getMemberId()");
		System.out.println("*[Debug] " + member.getMemberPw()+" <-- MemberDao.login | param : member.getMemberPw()");
		
		// 2-1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 2-2. 입력받은 Id, Pw를 이용해 부가 정보 출력 쿼리
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel FROM member WHERE member_id=? AND member_pw=PASSWORD(?)"; //
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		
		// 2-3. 쿼리 실행 및 데이터 변환(rs -> Member)
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			returnMember = new Member();
			returnMember.setMemberNo(Integer.parseInt(rs.getString("memberNo")));
			returnMember.setMemberId(rs.getString("memberId"));
			returnMember.setMemberLevel(Integer.parseInt(rs.getString("memberLevel")));
			return returnMember;
		}
		
		// 2-4. 사용한 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		return null;
	}
}
