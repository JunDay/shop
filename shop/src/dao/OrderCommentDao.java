package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import commons.DBUtil;
import vo.*;

public class OrderCommentDao {
	
	/* [공통] 상품후기 입력 */
	public void insertOrderComment(OrderComment orderComment) throws ClassNotFoundException, SQLException {
		System.out.println("+[Debug] \"Started\" | OrderDao.insertOrderComment()");
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. 상품 후기를 삽입하기 위한 쿼리 생성
		String sql = "INSERT INTO order_comment(order_no, ebook_no, order_score, order_comment_content, create_date, update_date) VALUES(?, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orderComment.getOrderNo());
		stmt.setInt(2, orderComment.getEbookNo());
		stmt.setInt(3, orderComment.getOrderScore());
		stmt.setString(4, orderComment.getOrderCommentContent());
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | OrderCommentDao.updateEbookImg()");
		
		// 2. 쿼리 실행
		int row = stmt.executeUpdate();
		
		// 3. 사용한 자원 반환
		stmt.close();
		conn.close();
		
		// 4. 쿼리 실행결과 디버깅
		if(row == 1) {
			System.out.println(" [Debug] \"insertOrderComment() Successful Finished\"");
			return;
		}
		System.out.println("-[Debug] \"insertOrderComment() Failed\"");
		return;
	}
}