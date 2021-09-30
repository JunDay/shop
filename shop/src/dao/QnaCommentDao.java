package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import commons.DBUtil;
import vo.*;

public class QnaCommentDao {
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
