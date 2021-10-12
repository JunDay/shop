package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import commons.DBUtil;
import vo.*;
import java.util.*;

public class OrderCommentDao {
	
	/* [관리자] 모든 orderComment 목록 출력 */
	public ArrayList<OrderComment> selectOrderCommentListByAdmin(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException{
		System.out.println("+[Debug] \"Started\" | NoticeDao.selectNoticeList()");
		
		// 0. 리턴할 OrderComment List 생성
		ArrayList<OrderComment> list = new ArrayList<>();
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. OrderComment의 전체 목록 출력 조회 쿼리
		String sql="SELECT order_no orderno, ebook_no ebookNo, order_score orderScore, order_comment_content orderCommentContent, create_date createDate, update_date updateDate FROM order_comment ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | NoticeDao.selectNoticeList()");
		
		// 2. 쿼리 실행 및 데이터 변환(rs -> ArrayList<OrderComment>)
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			OrderComment orderComment = new OrderComment();
			orderComment.setOrderNo(rs.getInt("orderNo"));
			orderComment.setEbookNo(rs.getInt("ebookNo"));
			orderComment.setOrderScore(rs.getInt("orderScore"));
			orderComment.setOrderCommentContent(rs.getString("OrderCommentContent"));
			orderComment.setCreateDate(rs.getString("createDate"));
			orderComment.setUpdateDate(rs.getString("updateDate"));
			list.add(orderComment);
		}
		
		// 3. 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		// 4. 조회된 전체 OrderComment의 리스트 목록 반환
		return list;
	}
	
	/* [공통] 댓글의 총 수 출력 */
	public int totalCommentCount() throws ClassNotFoundException, SQLException {
		System.out.println("+[Debug] \"Started\" | OrderCommentDao.totalCommentCount()");
		int totalCount = 0 ;
		//db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT COUNT(*) FROM order_comment";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(" [Debug] stmt : \""+stmt +"\" | OrderCommentDao.totalCommentCount()");
		
		ResultSet rs= stmt.executeQuery();
		
		while(rs.next()) {
			totalCount = rs.getInt("COUNT(*)");
		}
		
		return totalCount;
	}
	
	/* [공통] 후기를 조회 */
	public ArrayList<OrderComment> selectCommentList(int beginRow, int rowPerPage, int ebookNo) throws ClassNotFoundException, SQLException{
		// list라는 리스트를 사용하기 위해 생성
		ArrayList<OrderComment> list = new ArrayList<OrderComment>();
		
		// 매개변수 값을 디버깅
		System.out.println(beginRow + "<--- OrderCommentDao.selectCommentList parem : beginRow");
		System.out.println(rowPerPage + "<--- OrderCommentDao.selectCommentList parem : rowPerPage");
		System.out.println(ebookNo + "<--- OrderCommentDao.selectCommentList parem : ebookNo");
		
		// DB 실행
		// dbUtil 객체 생성
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT order_score orderScore, order_comment_content orderCommentContent, create_date createDate FROM order_comment WHERE ebook_no=? ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		
		// 디버깅 코드 : 쿼리내용과 표현식의 파라미터값 확인가능
		System.out.println(stmt + "<--- stmt");
		
		// 데이터 가공 (자료구조화)
		// ResultSet이라는 특수한 타입에서 ArrayList라는 일반화된 타입으로 변환(가공)
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			// orderComment 객체 생성 후 저장
			OrderComment orderComment = new OrderComment();
			orderComment.setOrderScore (rs.getInt("orderScore"));
			orderComment.setOrderCommentContent (rs.getString("orderCommentContent"));
			orderComment.setCreateDate (rs.getString("createDate"));
			list.add(orderComment);
		}
		// 종료
		rs.close();
		stmt.close();
		conn.close();
				
		//list를 return
		return list;
	}
	
	/* [공통] 상품의 평균 점수 출력 */
	public double selectOrderScoreAvg(int ebookNo) throws ClassNotFoundException, SQLException {
		System.out.println("+[Debug] \"Started\" | OrderDao.insertOrderComment()");
		
		// 0. 싱품의 평점을 리턴하기 위한 변수 선언
		double avgScore = 0;
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. 상품의 점수를 평균내는 쿼리 생성
		String sql = "SELECT AVG(order_score) av FROM order_comment WHERE ebook_no=? ORDER BY ebook_no";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | OrderCommentDao.updateEbookImg()");
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			avgScore = rs.getDouble("av");
		}
		
		// 3. 사용한 자원 반환
		stmt.close();
		conn.close();
		
		return avgScore;
	}
	
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