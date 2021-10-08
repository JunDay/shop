package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import commons.DBUtil;
import vo.*;

public class EbookDao {
	
	/* [관리자] 전자책 삭제 */
	public void deleteEbook(int ebookNo) throws SQLException, ClassNotFoundException {
		System.out.println("+[Debug] \"Started\" | EbookDao.deleteEbook()");
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		System.out.println(" [Debug] ebookNo : \""+ebookNo+"\" | EbookDao.deleteEbook()");
		
		// 1. noticeNo에 해당되는 공지사항 삭제 쿼리 생성
		String sql = "DELETE FROM ebook WHERE ebook_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | EbookDao.deleteEbook()");
		
		// 2. 쿼리실행
		int row = stmt.executeUpdate();
		
		// 3. 사용한 자원 반환
		stmt.close();
		conn.close();
		
		// 4. 쿼리 실행결과 디버깅
		if(row == 1) {
			System.out.println(" [Debug] \"Succesful Finished\" | EbookDao.deleteEbook()");
		}
		System.out.println("-[Debug] \"Failed\" | EbookDao.deleteEbook()");
	}
	
	/* [관리자] 인기 상품 TOP 5 출력*/
	public ArrayList<Ebook> selectNewEbookList() throws ClassNotFoundException, SQLException{
		System.out.println("+[Debug] \"Started\" | EbookDao.selectNewEbookList()");
		
		// 0. 리턴할 Ebook List 생성
		ArrayList<Ebook> list = new ArrayList<>();
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. 
		String sql="SELECT ebook_no ebookNo, ebook_title ebookTitle, ebook_img ebookImg, ebook_price ebookPrice, ebook_author ebookAuthor FROM ebook ORDER BY create_date DESC LIMIT 0, 5";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | EbookDao.selectNewEbookList()");
		
		// 2. 쿼리 실행 및 데이터 변환(rs -> ArrayList<Ebook>)
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Ebook ebook = new Ebook();
			ebook.setEbookNo(rs.getInt("ebookNo"));
			ebook.setEbookTitle(rs.getString("ebookTitle"));
			ebook.setEbookImg(rs.getString("ebookImg"));
			ebook.setEbookPrice(rs.getInt("ebookPrice"));
			ebook.setEbookAuthor(rs.getString("ebookAuthor"));
			list.add(ebook);
		}
		
		// 3. 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		// 4. 조회된 전체 ebook의 리스트 목록 반환
		return list;
	}
	
	/* [관리자] 인기 상품 TOP 5 출력*/
	public ArrayList<Ebook> selectPopularEbookList() throws ClassNotFoundException, SQLException{
		System.out.println("+[Debug] \"Started\" | EbookDao.selectPopularEbookList()");
		
		// 0. 리턴할 Ebook List 생성
		ArrayList<Ebook> list = new ArrayList<>();
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. 서브쿼리
		String sql="SELECT t.ebook_no ebookNo, e.ebook_title ebookTitle, e.ebook_img ebookImg, e.ebook_price ebookPrice FROM ebook e INNER JOIN (SELECT ebook_no, COUNT(ebook_no) FROM orders GROUP BY ebook_no ORDER BY COUNT(ebook_no) DESC LIMIT 0, 5) t ON e.ebook_no = t.ebook_no";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | EbookDao.selectPopularEbookList()");
		
		// 2. 쿼리 실행 및 데이터 변환(rs -> ArrayList<Ebook>)
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Ebook ebook = new Ebook();
			ebook.setEbookNo(rs.getInt("ebookNo"));
			ebook.setEbookTitle(rs.getString("ebookTitle"));
			ebook.setEbookImg(rs.getString("ebookImg"));
			ebook.setEbookPrice(rs.getInt("ebookPrice"));
			list.add(ebook);
		}
		
		// 3. 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		// 4. 조회된 전체 ebook의 리스트 목록 반환
		return list;
	}
	
	/* [관리자] 이미지 수정 메서드 */
	public void updateEbookImg(Ebook ebook) throws ClassNotFoundException, SQLException {
		System.out.println("+[Debug] \"Started\" | EbookDao.updateEbookImg()");
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. ebookNo에 대항되는 ebookImg의 경로 변경 쿼리
		String sql="UPDATE ebook SET ebook_img=? WHERE ebook_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookImg());
		stmt.setInt(2, ebook.getEbookNo());
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | EbookDao.updateEbookImg()");
		
		// 2. 쿼리 실행
		int row = stmt.executeUpdate();
		
		if(row == 1) {
			System.out.println(" [Debug] \"Succesful Finished\" | EbookDao.updateEbookImg()");
		} else {
			System.out.println("-[Debug] \"Failed\" | EbookDao.updateEbookImg()");
		}
		
		
		// 3. 자원 반환
		stmt.close();
		conn.close();
	}
	
	
	/* [관리자] 선택된 ebook의 상세정보 출력 */
	public Ebook selectEbookOne(int ebookNo) throws ClassNotFoundException, SQLException {
		System.out.println("+[Debug] \"Started\" | EbookDao.selectEbookOne()");
		
		// 0. 조회된 ebook의 상세정보를 반환해주기 위한 객체 생성
		Ebook ebook = null;
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. ebookNo에 해당하는 ebook에 대한 상세정보 조회 쿼리
		String sql="SELECT ebook_no ebookNo, ebook_isbn ebookISBN, category_name categoryName, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_company ebookCompany, ebook_page_count ebookPageCount, ebook_price ebookPrice, ebook_img ebookImg, ebook_summary ebookSummary, ebook_state ebookState, create_date createDate, update_date updateDate FROM ebook WHERE ebook_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | EbookDao.selectEbookOne()");
		
		// 2. 쿼리 실행 및 데이터 가공(rs -> ebook)
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			ebook = new Ebook();
			ebook.setEbookNo(rs.getInt("ebookNo"));
			ebook.setEbookISBN(rs.getString("ebookISBN"));
			ebook.setCategoryName(rs.getString("categoryName"));
			ebook.setEbookTitle(rs.getString("ebookTitle"));
			ebook.setEbookAuthor(rs.getString("ebookAuthor"));
			ebook.setEbookCompany(rs.getString("ebookCompany"));
			ebook.setEbookPageCount(rs.getInt("ebookPageCount"));
			ebook.setEbookPrice(rs.getInt("ebookPrice"));
			ebook.setEbookImg(rs.getString("ebookImg"));
			ebook.setEbookSummary(rs.getString("ebookSummary"));
			ebook.setEbookState(rs.getString("ebookState"));
			ebook.setCreateDate(rs.getString("createDate"));
			ebook.setUpdateDate(rs.getString("updateDate"));
		}
		
		// 3. 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		// 4. 가공된 하나의 ebook 정보 반환
		return ebook;
	}
	
	/* [관리자] DB에 입력된 총 ebook의 수 출력, 페이징용 */
	public int totalEbookCount(String categoryName) throws ClassNotFoundException, SQLException {
		System.out.println("+[Debug] \"Started\" | EbookDao.totalEbookCount()");
		
		// 0. 계사된 ebook의 총 갯수를 반환해줄 변수 생성
		int totalCount = 0 ;
		
		// 0. DB 연결 설정
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. sql문과 stmt를 선언
		String sql = null;
		PreparedStatement stmt = null;
		
		// 2. 카테고리의 여부에 따른 분기
		if(categoryName.equals("") || categoryName == null) { // 검색어가 없는 경우
			// 2-1. cateogoryName이 "없는" 경우 전체 행의 개수 조회
			sql = "SELECT COUNT(*) FROM ebook";
			stmt = conn.prepareStatement(sql);
		} else {
			// 2-2. cateogoryName이 "있는" 경우 입력된 cateogoryName에 해당되는 행의 개수 조회
			sql = "SELECT COUNT(*) FROM ebook WHERE category_name LIKE ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+categoryName+"%");
		}
		System.out.println(" [Debug] stmt : \""+stmt +"\" | EbookDao.totalEbookCount()");
		
		// 3. 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			totalCount = rs.getInt("COUNT(*)");
		}
		
		// 4. 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		// 5. DB에 있는 총 ebook의 수 반환
		return totalCount;
	}
	
	/* [관리자 & 고객] 모든 ebook 목록 출력 */
	public ArrayList<Ebook> selectEbookList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException{
		System.out.println("+[Debug] \"Started\" | EbookDao.selectEbookList()");
		
		// 0. 리턴할 Ebook List 생성
		ArrayList<Ebook> list = new ArrayList<>();
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. ebook의 전체 목록 출력 조회 쿼리
		String sql="SELECT ebook_no ebookNo, category_name categoryName, ebook_title ebookTitle, ebook_img ebookImg, ebook_price ebookPrice,  ebook_state ebookState FROM ebook ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | EbookDao.selectEbookList()");
		
		// 2. 쿼리 실행 및 데이터 변환(rs -> ArrayList<Ebook>)
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Ebook ebook = new Ebook();
			ebook.setEbookNo(rs.getInt("ebookNo"));
			ebook.setCategoryName(rs.getString("categoryName"));
			ebook.setEbookTitle(rs.getString("ebookTitle"));
			ebook.setEbookImg(rs.getString("ebookImg"));
			ebook.setEbookPrice(rs.getInt("ebookPrice"));
			ebook.setEbookState(rs.getString("ebookState"));
			list.add(ebook);
		}
		
		// 3. 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		// 4. 조회된 전체 ebook의 리스트 목록 반환
		return list;
	}
	
	/* [관리자 & 고객] 선택된 카테고리에 해당되는 ebook의 목록 출력 */
	public ArrayList<Ebook> selectEbookListByPage(int beginRow, int rowPerPage, String categoryName) throws ClassNotFoundException, SQLException{
		System.out.println("+[Debug] \"Started\" | EbookDao.selectEbookListByPage()");
		
		// 0. 반환할 Ebook List 생성
		ArrayList<Ebook> list = new ArrayList<>();
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. 카테고리 명으로 분류된 ebook의 목록 출력
		String sql="SELECT ebook_no ebookNo, category_name categoryName, ebook_title ebookTitle, ebook_img ebookImg, ebook_price ebookPrice, ebook_state ebookState FROM ebook WHERE category_name=? ORDER BY create_date DESC LIMIT ?, ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | EbookDao.selectEbookListByPage()");
		
		// 2. 쿼리 실행 및 데이터 변환(rs -> ArrayList<Ebook>)
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Ebook ebook = new Ebook();
			ebook.setEbookNo(rs.getInt("ebookNo"));
			ebook.setCategoryName(rs.getString("categoryName"));
			ebook.setEbookTitle(rs.getString("ebookTitle"));
			ebook.setEbookImg(rs.getString("ebookImg"));
			ebook.setEbookPrice(rs.getInt("ebookPrice"));
			ebook.setEbookState(rs.getString("ebookState"));
			list.add(ebook);
		}
		
		// 3. 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		// 4. 조회된 카테고리로 분류된 ebook 리스트 목록 반환
		return list;
	}
}
