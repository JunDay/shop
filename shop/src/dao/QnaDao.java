package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.*;

public class QnaDao {
	
	/* [공통] 선택한 Qna 상세 정보 출력 */
	public Qna selectQnaOne(int qnaNo) throws ClassNotFoundException, SQLException {
		System.out.println("+[Debug] \"Started\" | QnaDao.selectQnaOne()");
		
		// 0. 리턴할 Qna 객체 생성
		Qna qna = new Qna();
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. noticeNo을 이용해 해당되는 notice의 정보들을 조회하는 쿼리 생성
		String sql = "SELECT q.qna_no qnaNo, q.qna_category qnaCategory, q.qna_title qnaTitle, q.qna_content qnaContent, q.qna_secret qnaSecret, q.member_no memberNo, m.member_name memberName, q.create_date createDate, q.update_date updateDate FROM qna q INNER JOIN member m ON q.member_no = m.member_no WHERE q.qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | QnaDao.selectQnaOne()");
		
		// 2. 쿼리 실행 및 데이터 변환(rs -> Notice)
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			qna.setQnaNo(rs.getInt("qnaNo"));
			qna.setQnaCategory(rs.getString("qnaCategory"));
			qna.setQnaTitle(rs.getString("qnaTitle"));
			qna.setQnaContent(rs.getString("qnaContent"));
			qna.setQnaSecret(rs.getString("qnaSecret"));
			qna.setMemberNo(rs.getInt("memberNo"));
			qna.setMemberName(rs.getString("memberName"));
			qna.setCreateDate(rs.getString("createDate"));
			qna.setUpdateDate(rs.getString("updateDate"));
		}
		
		// 3. 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		// 4. 조회된 Notice의 객체를 반환
		return qna;
	}
	
	/* [공통] 모든 qna 목록 출력 */
	public ArrayList<Qna> selectQnaList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException{
		System.out.println("+[Debug] \"Started\" | QnaDao.selectQnaList()");
		
		// 0. 리턴할 Qna List 생성
		ArrayList<Qna> list = new ArrayList<>();
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. Qna의 전체 목록 출력 조회 쿼리
		String sql="SELECT q.qna_no qnaNo, q.qna_category qnaCategory, q.qna_title qnaTitle, q.qna_content qnaContent, q.qna_secret qnaSecret, q.member_no memberNo, m.member_name memberName, q.create_date createDate, q.update_date updateDate FROM qna q INNER JOIN member m ON q.member_no = m.member_no ORDER BY q.create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | QnaDao.selectQnaList()");
		
		// 2. 쿼리 실행 및 데이터 변환(rs -> ArrayList<Notice>)
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Qna qna = new Qna();
			qna.setQnaNo(rs.getInt("qnaNo"));
			qna.setQnaCategory(rs.getString("qnaCategory"));
			qna.setQnaTitle(rs.getString("qnaTitle"));
			qna.setQnaContent(rs.getString("qnaContent"));
			qna.setQnaSecret(rs.getString("qnaSecret"));
			qna.setMemberNo(rs.getInt("memberNo"));
			qna.setMemberName(rs.getString("memberName"));
			qna.setCreateDate(rs.getString("createDate"));
			qna.setUpdateDate(rs.getString("updateDate"));
			list.add(qna);
		}
		
		// 3. 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		// 4. 조회된 전체 qna의 리스트 목록 반환
		return list;
	}
}
