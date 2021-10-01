package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import commons.DBUtil;
import vo.*;

public class QnaCommentDao {
	
	/* [관리자] Q&A 답변 수정 */
	public void updateQnaComment(QnaComment qnaComment) throws ClassNotFoundException, SQLException {
		System.out.println("+[Debug] \"Started\" | QnaDao.updateQnaComment()");
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. noticeNo과 memberNo가 일치하면 해당 입력된 공지사항 정보를 갱신하는 쿼리 생성
		String sql="UPDATE qna_comment SET qna_comment_content=?, update_date=NOW() WHERE qna_no=? AND member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, qnaComment.getQnaCommentContent());
		stmt.setInt(2, qnaComment.getQnaNo());
		stmt.setInt(3, qnaComment.getMemberNo());
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | QnaDao.updateQnaComment()");
		
		// 2. 쿼리 실행
		int row = stmt.executeUpdate();
		
		
		// 3. 사용한 자원 반환
		stmt.close();
		conn.close();
		
		// 4. 실행 결과 디버깅
		if(row == 1) {
			System.out.println(" [Debug] \"UPDATE Succesful Finished\" | QnaDao.updateQnaComment()");
		} else {
			System.out.println("-[Debug] \"UPDATE Failed\" | QnaDao.updateQnaComment()");
		}
	}
	
	/* [관리자] Q&A 답변 작성 */
	public void insertQnaComment(QnaComment qnaComment) throws ClassNotFoundException, SQLException {
		System.out.println("+[Debug] \"Started\" | QnaDaoComment.insertQnaComment()");
		
		// 0. Form에서 받은 내용 디버깅
		System.out.println(" [Debug] qnaCategory : \""+qnaComment.toString()+"\" | QnaDao.insertQna() FROM /insertQnaForm.jsp");
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. 입력받은 공지사항 정보들을 삽입하는 쿼리생성
		String sql = "INSERT INTO qna_comment(qna_no, qna_comment_content, member_no, create_date, update_date) VALUES(?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaComment.getQnaNo());
		stmt.setString(2, qnaComment.getQnaCommentContent());
		stmt.setInt(3, qnaComment.getMemberNo());
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | QnaDaoComment.insertQnaComment()");
		
		// 2. 쿼리 실행
		int row = stmt.executeUpdate();
		
		// 3. 사용한 자원 반환
		stmt.close();
		conn.close();
		
		// 4. 쿼리 실행결과 디버깅
		if(row == 1) {
			System.out.println(" [Debug] \"INSERT Succesful Finished\" | QnaDaoComment.insertQnaComment()");
		}
		System.out.println("-[Debug] \"INSERT Failed\" | QnaDaoComment.insertQnaComment()");
	}
	
	/* [공통] 선택한 Qna 상세 정보 출력 */
	public QnaComment selectQnaComment(int qnaNo) throws ClassNotFoundException, SQLException {
		System.out.println("+[Debug] \"Started\" | QnaCommentDao.selectQnaComment()");
		
		// 0. 리턴할 Qna 객체 생성
		QnaComment qnaComment = new QnaComment();
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. noticeNo을 이용해 해당되는 notice의 정보들을 조회하는 쿼리 생성
		String sql = "SELECT qc.qna_no qnaNo, qc.qna_comment_content qnaCommentContent, qc.member_no memberNo, m.member_name memberName, qc.create_date createDate, qc.update_date updateDate FROM qna_comment qc INNER JOIN member m ON qc.member_no = m.member_no WHERE qc.qna_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		
		System.out.println(" [Debug] stmt : \""+stmt+"\" | QnaCommentDao.selectQnaComment()");
		
		// 2. 쿼리 실행 및 데이터 변환(rs -> Notice)
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			qnaComment.setQnaNo(rs.getInt("qnaNo"));
			qnaComment.setQnaCommentContent(rs.getString("qnaCommentContent"));
			qnaComment.setMemberNo(rs.getInt("memberNo"));
			qnaComment.setMemberName(rs.getString("memberName"));
			qnaComment.setCreateDate(rs.getString("createDate"));
			qnaComment.setUpdateDate(rs.getString("updateDate"));
		}
		
		// 3. 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		// 4. 조회된 Notice의 객체를 반환
		return qnaComment;
	}
}
