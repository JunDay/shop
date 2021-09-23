package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import commons.DBUtil;
import vo.*;

public class EbookDao {
	
	/* [관리자] 이미지 수정 */
	public void updateEbookImg(Ebook ebook) throws ClassNotFoundException, SQLException {
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. e book의 전체 목록 출력
		String sql="UPDATE ebook SET ebook_img=? WHERE ebook_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookImg());
		stmt.setInt(2, ebook.getEbookNo());
		
		
		System.out.println("*[Debug] " + stmt +" <-- EbookDao.selectEbookListByPage()");
		
		stmt.executeUpdate();
		
		// 연결종료
		stmt.close();
		conn.close();
	}
	
	
	/* [관리자] 선택된 ebook의 정보 출력 */
	public Ebook selectEbookOne(int ebookNo) throws ClassNotFoundException, SQLException {
		Ebook ebook = null;
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. e book의 전체 목록 출력
		String sql="SELECT ebook_no ebookNo, ebook_img ebookImg FROM ebook WHERE ebook_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		
		System.out.println("*[Debug] " + stmt +" <-- EbookDao.selectEbookListByPage()");
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			ebook = new Ebook();
			ebook.setEbookNo(rs.getInt("ebookNo"));
			ebook.setEbookImg(rs.getString("ebookImg"));
		}
		
		// 3. 연결 종료
		rs.close();
		stmt.close();
		conn.close();
		
		return ebook;
	}
	
	/* [관리자] 총 ebook의 수 출력 */
	public int totalEbookCount(String categoryName) throws ClassNotFoundException, SQLException {
		
		// 리턴해줄 총 ebook의 수
		int totalCount = 0 ;
		
		// DB 연결 설정
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = null;
		PreparedStatement stmt = null;
		// 검색어 입력 여부
		if(categoryName.equals("") || categoryName == null) { // 검색어가 없는 경우
			//쿼리생성, 실행
			sql = "SELECT COUNT(*) FROM ebook";
			stmt = conn.prepareStatement(sql);
		} else {
			sql = "SELECT COUNT(*) FROM ebook WHERE category_name LIKE ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+categoryName+"%");
			
		}
		
		ResultSet rs= stmt.executeQuery();
		
		while(rs.next()) {
			totalCount = rs.getInt("COUNT(*)");
		}
		
		return totalCount;
	}
	
	/* [관리자] 모든 ebook 목록 출력 */
	public ArrayList<Ebook> selectEbookList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException{
		
		// 0. 리턴할 Ebook List 생성
		ArrayList<Ebook> list = new ArrayList<>();
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. e book의 전체 목록 출력
		String sql="SELECT ebook_no ebookNo, category_name categoryName, ebook_title ebookTitle, ebook_state ebookState FROM ebook ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		System.out.println("*[Debug] " + stmt +" <-- EbookDao.selectEbookListByPage()");	
		
		// 2. 쿼리 실행 및 데이터 변환(rs -> list)
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Ebook ebook = new Ebook();
			ebook.setEbookNo(Integer.parseInt(rs.getString("ebookNo")));
			ebook.setCategoryName(rs.getString("categoryName"));
			ebook.setEbookTitle(rs.getString("ebookTitle"));
			ebook.setEbookState(rs.getString("ebookState"));
			list.add(ebook);
		}
		
		// 3. 연결 종료
		rs.close();
		stmt.close();
		conn.close();
		
		// 4. 리스트 목록 반환
		return list;
	}
	
	/* [관리자] 선택된 카테고리에 따른 ebook의 목록 출력 */
	public ArrayList<Ebook> selectEbookListByPage(int beginRow, int rowPerPage, String categoryName) throws ClassNotFoundException, SQLException{
		
		// 0. 반환할 Ebook List 생성
		ArrayList<Ebook> list = new ArrayList<>();
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. 카테고리 명으로 분류된 e book의 목록 출력
		String sql="SELECT ebook_no ebookNo, category_name categoryName, ebook_title ebookTitle, ebook_state ebookState FROM ebook WHERE category_name=? ORDER BY create_date DESC LIMIT ?, ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		
		System.out.println("*[Debug] " + stmt +" <-- EbookDao.selectEbookListByPage()");	
		
		// 2. 쿼리 실행 및 데이터 변환(rs -> list)
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Ebook ebook = new Ebook();
			ebook.setEbookNo(Integer.parseInt(rs.getString("ebookNo")));
			ebook.setCategoryName(rs.getString("categoryName"));
			ebook.setEbookTitle(rs.getString("ebookTitle"));
			ebook.setEbookState(rs.getString("ebookState"));
			list.add(ebook);
		}
		
		// 3. 연결 종료
		rs.close();
		stmt.close();
		conn.close();
		
		// 4. 리스트 목록 반환
		return list;
	}
}
