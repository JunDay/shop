package dao;

import java.sql.*;
import java.util.*;

import commons.DBUtil;
import vo.*;
import commons.*;

public class CategoryDao {
	
	/* [관리자] 카테고리 삭제 */
	public void deleteCategory(String categoryName) throws SQLException, ClassNotFoundException {
		System.out.println("+[Debug] \"Started\" | CategoryDao.deleteCategory()");
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		System.out.println(" [Debug] categoryName : \""+categoryName+"\" | CategoryDao.deleteCategory()");
		
		// 1. noticeNo에 해당되는 공지사항 삭제 쿼리 생성
		String sql = "DELETE FROM category WHERE category_name=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | CategoryDao.deleteCategory()");
		
		// 2. 쿼리실행
		int row = stmt.executeUpdate();
		
		// 3. 사용한 자원 반환
		stmt.close();
		conn.close();
		
		// 4. 쿼리 실행결과 디버깅
		if(row == 1) {
			System.out.println(" [Debug] \"Succesful Finished\" | CategoryDao.deleteCategory()");
		}
		System.out.println("-[Debug] \"Failed\" | CategoryDao.deleteCategory()");
	}
	
	/* [관리자] 카테고리 정보 수정 */
	public void updateCategory(Category category, String categoryName) throws ClassNotFoundException, SQLException {
		System.out.println("+[Debug] \"Started\" | CategoryDao.updateCategory()");
		
		// 0. 넘겨받은 카테고리 정보 디버깅
		System.out.println("+[Debug] category.getCategoryName() : \""+category.getCategoryName()+"\" | CategoryDao.updateCategory() | FROM admin/selectCategoryList.jsp");
		System.out.println("+[Debug] category.getCategoryState() : \""+category.getCategoryState()+"\" | updateCategory.updateCategoryState() | FROM admin/selectCategoryList.jsp");
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. 카테고리의 사용 상태 변경 및 업데이트 시간 변경
		String sql = "UPDATE category SET category_name=?, category_state=?, update_date=NOW() WHERE category_name=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryName());
		stmt.setString(2, category.getCategoryState());
		stmt.setString(3, categoryName);
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | CategoryDao.updateCategoryState()");
		
		// 2. 쿼리 실행
		int row = stmt.executeUpdate();
		  
		// 3. 사용한 자원 반환
		stmt.close();
		conn.close();
		  
		// 4. 쿼리 실행결과 디버깅
		if(row == 1) {
			System.out.println(" [Debug] \"Category State update Succesfuly finished\" | CategoryDao.updateCategory()");
			return;
		}
		System.out.println("-[Debug] \"Category State update FAILED\" | CategoryDao.updateCategory()");
		return;
	}
	
	/* [관리자] 카테고리 입력시 중복된 카테고리 이름 확인 */
	public String selectCategoryId(String categoryNameCheck) throws ClassNotFoundException, SQLException {
		System.out.println("+[Debug] \"Started\" | CategoryDao.selectCategoryId()");
		
		// 0. 확인된 categoryName를 반환해주기 위한 변수
		String categoryName = null;
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. 입력된 categoryName이 기존의 categoryName과 중복되는지 확인
		String sql = "SELECT category_name categoryName FROM category WHERE category_name=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryNameCheck);
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | CategoryDao.selectCategoryId()");

		// 2. 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			categoryName = rs.getString("categoryName");
		}
		
		// 3. 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		// 4. 중복확인 결과 반환
		return categoryName;
	}
	
	/* [관리자] 카테고리 삽입 */
	public void insertCategory(Category category) throws ClassNotFoundException, SQLException {
		System.out.println("+[Debug] \"Started\" | CategoryDao.insertCategory()");
		
		// 0. 입력받은 카테고리 정보 디버깅
		System.out.println(" [Debug] category.getCategoryName() : \""+category.getCategoryName()+"\" | CategoryDao.insertCategory()");
		System.out.println(" [Debug] category.getUpdateDate() : \""+category.getUpdateDate()+"\" | CategoryDao.insertCategory()");
		System.out.println(" [Debug] category.getCreateDate() : \""+category.getCreateDate()+"\" | CategoryDao.insertCategory()");
		System.out.println(" [Debug] category.getCategoryState() : \""+category.getCategoryState()+"\" | CategoryDao.insertCategory()");
	  
		 // 0. DB 연결
		 DBUtil dbUtil = new DBUtil();
		 Connection conn = dbUtil.getConnection();
		  
		 // 1. 카테고리를 추가하기 위한 카테고리 정보 삽입 쿼리
		 String sql = "INSERT INTO category(category_name, category_state, create_date, update_date) VALUES(?, ?, NOW(), NOW())";
		 PreparedStatement stmt = conn.prepareStatement(sql);
		 stmt.setString(1, category.getCategoryName());
		 stmt.setString(2, category.getCategoryState());
		 
		 System.out.println(" [Debug] stmt : \""+stmt +"\" | CategoryDao.insertCategory()");
		  
		 // 2. 쿼리 실행
		 int row = stmt.executeUpdate();
		  
		 // 3. 사용한 자원 반환
		 stmt.close();
		 conn.close();
		  
		 // 4. 쿼리 실행결과 디버깅
		 if(row == 1) {
			System.out.println(" [Debug] \"Category insert Succesfuly finished\" | CategoryDao.insertCategory()");
		 	return;
		 }
		 System.out.println("-[Debug] \"Category insert FAILED\" | CategoryDao.insertCategory()");
		 return;
	}
	
	/* [관리자] 카테고리 목록 출력 */
	public ArrayList<Category> selectCategoryList() throws ClassNotFoundException, SQLException{
		System.out.println("+[Debug] \"Started\" | CategoryDao.selectCategoryList()");
		
		// 0. 카테고리의 목록을 반환해줄 ArrayList
		ArrayList<Category> returnCategoryList = new ArrayList<Category>();
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. DB에 등록된 카테고리의 목록을 조회하는 쿼리 생성
		String sql = "SELECT category_name categoryName, update_date updateDate, create_date createDate, category_state categoryState FROM category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | CategoryDao.selectCategoryList()");		
		
		// 2. 쿼리 실행 및 데이터 변환(rs -> ArrayList<Category>)
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Category category = new Category();
			category.setCategoryName(rs.getString("categoryName"));
			category.setUpdateDate(rs.getString("updateDate"));
			category.setCreateDate(rs.getString("createDate"));
			category.setCategoryState(rs.getString("categoryState"));
			returnCategoryList.add(category);
		}
		
		// 4. 사용한 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		// 5. 카테고리 목록 반환
		return returnCategoryList;
	}
}
