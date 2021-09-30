package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.*;

public class QnaDao {
	
	/* [회원] Q&A 삭제 */
	public void deleteQna(int qnaNo) throws SQLException, ClassNotFoundException {
		System.out.println("+[Debug] \"Started\" | QnaDao.deleteQna()");
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		System.out.println(" [Debug] qnaNo : \""+qnaNo+"\" | QnaDao.deleteQna()");
		
		// 1. noticeNo에 해당되는 공지사항 삭제 쿼리 생성
		String sql = "DELETE FROM qna WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | QnaDao.deleteQna()");
		
		// 2. 쿼리실행
		int row = stmt.executeUpdate();
		
		// 3. 사용한 자원 반환
		stmt.close();
		conn.close();
		
		// 4. 쿼리 실행결과 디버깅
		if(row == 1) {
			System.out.println(" [Debug] \"DELETE Succesful Finished\" | QnaDao.deleteQna()");
		}
		System.out.println("-[Debug] \"DELETE Failed\" | QnaDao.deleteQna()");
	}
	
	/* [회원] Q&A 수정 */
	public void updateQna(Qna qna) throws ClassNotFoundException, SQLException {
		System.out.println("+[Debug] \"Started\" | QnaDao.updateQna()");
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. noticeNo과 memberNo가 일치하면 해당 입력된 공지사항 정보를 갱신하는 쿼리 생성
		String sql="UPDATE qna SET qna_category=?, qna_title=?, qna_content=?, qna_secret=?, update_date=NOW() WHERE qna_no=? AND member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, qna.getQnaCategory());
		stmt.setString(2, qna.getQnaTitle());
		stmt.setString(3, qna.getQnaContent());
		stmt.setString(4, qna.getQnaSecret());
		stmt.setInt(5, qna.getQnaNo());
		stmt.setInt(6, qna.getMemberNo());
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | QnaDao.updateQna()");
		
		// 2. 쿼리 실행
		int row = stmt.executeUpdate();
		
		
		// 3. 사용한 자원 반환
		stmt.close();
		conn.close();
		
		// 4. 실행 결과 디버깅
		if(row == 1) {
			System.out.println(" [Debug] \"UPDATE Succesful Finished\" | QnaDao.updateQna()");
		} else {
			System.out.println("-[Debug] \"UPDATE Failed\" | QnaDao.updateQna()");
		}
	}
	
	/* [회원] Q&A 작성 */
	public void insertQna(Qna qna) throws ClassNotFoundException, SQLException {
		System.out.println("+[Debug] \"Started\" | QnaDao.insertQna()");
		
		// 0. Form에서 받은 내용 디버깅
		System.out.println(" [Debug] qnaCategory : \""+qna.getQnaCategory()+"\" | QnaDao.insertQna() FROM /insertQnaForm.jsp");
		System.out.println(" [Debug] qnaTitle : \""+qna.getQnaTitle()+"\" | QnaDao.insertQna() FROM /insertQnaForm.jsp");
		System.out.println(" [Debug] qnaContent : \""+qna.getQnaContent()+"\" | QnaDao.insertQna() FROM /insertQnaForm.jsp");
		System.out.println(" [Debug] qnaSecret : \""+qna.getQnaSecret()+"\" | QnaDao.insertQna() FROM /insertQnaForm.jsp");
		System.out.println(" [Debug] memberNo : \""+qna.getMemberNo()+"\" | QnaDao.insertQna() FROM /insertQnaForm.jsp");
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. 입력받은 공지사항 정보들을 삽입하는 쿼리생성
		String sql = "INSERT INTO qna(qna_category, qna_title, qna_content, qna_secret, member_no, create_date, update_date) VALUES(?, ?, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, qna.getQnaCategory());
		stmt.setString(2, qna.getQnaTitle());
		stmt.setString(3, qna.getQnaContent());
		stmt.setString(4, qna.getQnaSecret());
		stmt.setInt(5, qna.getMemberNo());
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | QnaDao.insertQna()");
		
		// 2. 쿼리 실행
		int row = stmt.executeUpdate();
		
		// 3. 사용한 자원 반환
		stmt.close();
		conn.close();
		
		// 4. 쿼리 실행결과 디버깅
		if(row == 1) {
			System.out.println(" [Debug] \"INSERT Succesful Finished\" | QnaDao.insertQna()");
		}
		System.out.println("-[Debug] \"INSERT Failed\" | QnaDao.insertQna()");
	}
	
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
		System.out.println(" [Debug] qnaNo : \""+qna.getQnaNo()+"\" | QnaDao.selectQnaOne()");
		System.out.println(" [Debug] qnaCategory : \""+qna.getQnaCategory()+"\" | QnaDao.selectQnaOne()");
		System.out.println(" [Debug] qnaTitle : \""+qna.getQnaTitle()+"\" | QnaDao.selectQnaOne()");
		System.out.println(" [Debug] qnaContent : \""+qna.getQnaContent()+"\" | QnaDao.selectQnaOne()");
		System.out.println(" [Debug] qnaSecret : \""+qna.getQnaSecret()+"\" | QnaDao.selectQnaOne()");
		System.out.println(" [Debug] memberNo : \""+qna.getMemberNo()+"\" | QnaDao.selectQnaOne()");
		System.out.println(" [Debug] memberName : \""+qna.getMemberName()+"\" | QnaDao.selectQnaOne()");
		System.out.println(" [Debug] createDate : \""+qna.getCreateDate()+"\" | QnaDao.selectQnaOne()");
		System.out.println(" [Debug] updateDate : \""+qna.getUpdateDate()+"\" | QnaDao.selectQnaOne()");
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
