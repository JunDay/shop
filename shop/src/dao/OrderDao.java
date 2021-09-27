package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import commons.DBUtil;
import vo.*;

public class OrderDao {
	
	// [관리자] 고객 주문 목록 출력
	public ArrayList<OrderEbookMember> selectOrderListByMember(int memberNo) throws ClassNotFoundException, SQLException{
		System.out.println("+[Debug] \"Started\" | OrderDao.selectOrderListByMember()");
		
		// 0. 주문 리스트 목록을 반환해줄 객체 생성
		ArrayList<OrderEbookMember> list = new ArrayList<>();
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. 고객이 주문한 정보를 조회하는 쿼리
		String sql = "SELECT o.order_no orderNo,e.ebook_no ebookNo,e.ebook_title ebookTitle,m.member_no memberNo,m.member_id memberId,o.order_price orderPrice,o.order_date orderDate FROM orders o INNER JOIN ebook e INNER JOIN member m ON o.ebook_no = e.ebook_no AND o.member_no = m.member_no WHERE m.member_no=? ORDER BY o.order_date DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, memberNo);
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | EbookDao.updateEbookImg()");
		
		// 2. 쿼리 실행 및 데이터 가공(rs -> ArrayList<OEM>)
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			OrderEbookMember oem = new OrderEbookMember();
			
			// 2-1. 주문 정보 변환
			Order o = new Order();
			o.setOrderNo(rs.getInt("orderNo"));
			o.setOrderPrice(rs.getInt("orderPrice"));
			o.setOrderDate(rs.getString("orderDate"));;
			oem.setOrder(o);
			
			// 2-2. ebook 정보 변환
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			oem.setEbook(e);
			
			// 2-3. 멤버 정보 반환
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			oem.setMember(m);
			
			list.add(oem);
		}
		
		// 3. 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		// 4. 조회된 고객 주문 목록 반환
		return list;
	}
	
	/* [관리자] DB에 입력된 총 Order의 수 출력, 페이징용 */
	public int totalOrderCount() throws ClassNotFoundException, SQLException {
		System.out.println("+[Debug] \"Started\" | OrderDao.totalOrderCount()");
		
		// 0. 계사된 ebook의 총 갯수를 반환해줄 변수 생성
		int totalCount = 0 ;
		
		// 0. DB 연결 설정
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. sql문과 stmt를 선언
		String sql = "SELECT COUNT(*) FROM orders";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | EbookDao.totalEbookCount()");
		
		// 2. 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			totalCount = rs.getInt("COUNT(*)");
		}
		
		// 3. 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		// 4. DB에 있는 총 Order의 수 반환
		return totalCount;
	}
	
	// [관리자] 고객 주문 목록 출력
	public ArrayList<OrderEbookMember> selectOrderList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException{
		System.out.println("+[Debug] \"Started\" | OrderDao.selectOrderList()");
		
		// 0. 주문 리스트 목록을 반환해줄 객체 생성
		ArrayList<OrderEbookMember> list = new ArrayList<>();
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. 고객이 주문한 정보를 조회하는 쿼리
		String sql="SELECT	o.order_no orderNo, e.ebook_no ebookNo, e.ebook_title ebookTitle, m.member_no memberNo, m.member_id memberId, o.order_price orderPrice, o.order_date orderDate FROM orders o INNER JOIN ebook e INNER JOIN member m ON o.ebook_no = e.ebook_no AND o.member_no = m.member_no ORDER BY o.order_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | EbookDao.updateEbookImg()");
		
		// 2. 쿼리 실행 및 데이터 가공(rs -> ArrayList<OEM>)
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			OrderEbookMember oem = new OrderEbookMember();
			
			// 2-1. 주문 정보 변환
			Order o = new Order();
			o.setOrderNo(rs.getInt("orderNo"));
			o.setOrderPrice(rs.getInt("orderPrice"));
			o.setOrderDate(rs.getString("orderDate"));;
			oem.setOrder(o);
			
			// 2-2. ebook 정보 변환
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			oem.setEbook(e);
			
			// 2-3. 멤버 정보 반환
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			oem.setMember(m);
			
			list.add(oem);
		}
		
		// 3. 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		// 4. 조회된 고객 주문 목록 반환
		return list;
	}
}
