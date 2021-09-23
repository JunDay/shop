package dao;

import java.sql.*;
import java.util.*;

import commons.DBUtil;
import vo.*;
import commons.*;

public class CategoryDao {
	
	/* [관리자] 카테고리 입력시 중복된 카테고리 이름 확인 */
	public String selectCategoryId(String categoryNameCheck) throws ClassNotFoundException, SQLException {
		// 0. 확인된 categoryName를 반환해주기 위한 변수
		String categoryName = null;
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 입력된 categoryName와 같은 categoryName가 있는지 확인, 중복 확인
		String sql = "SELECT category_name categoryName FROM category WHERE category_name=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryNameCheck);

		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			categoryName = rs.getString("categoryName");
		}
		
		rs.close();
		stmt.close();
		
		return categoryName;
	}
	
	/* [관리자] 카테고리 삽입 */
	public void insertCategory(Category category) throws ClassNotFoundException, SQLException {
		// 0. 입력받은 카테고리 정보 출력
		  System.out.println("**[Debug] MemberDao/insertMember() | Start");
	      System.out.println("*[Debug] " + category.getCategoryName() +" <-- CategoryDao.insertCategory");
	      System.out.println("*[Debug] " + category.getUpdateDate() +" <-- CategoryDao.insertCategory");
	      System.out.println("*[Debug] " + category.getCreateDate() +" <-- CategoryDao.insertCategory");
	      System.out.println("*[Debug] " + category.getCategoryState() +" <-- CategoryDao.insertCategory");
	      
	      // 1-1. DB 연결
	      DBUtil dbUtil = new DBUtil();
	      Connection conn = dbUtil.getConnection();
	      
	      // 1-2. 회원가입을 하기 위한 회원정보 삽입 쿼리
	      String sql = "INSERT INTO member(category_name, update_update, create_date, category_state) VALUES(?, NOW(), NOW(), ?)";
	      PreparedStatement stmt = conn.prepareStatement(sql);
	      
	      stmt.setString(1, category.getCategoryName());
	      stmt.setString(2, category.getCategoryState());
	      System.out.println("*[Debug] " + stmt +" <-- CategoryDao.insertCategory()");
	      
	      // 1-3. 쿼리 실행
	      int row = stmt.executeUpdate();
	      
	      // 1-4. 사용한 자원 반환
	      stmt.close();
	      conn.close();
	      
	      // 1-5. 쿼리 실행결과 디버깅
	      if(row == 1) {
	    	  System.out.println("**[Debug] 카테고리 입력 성공 <-- CategoryDao.insertCategory()");
	    	  return;
	      }
	      	  System.out.println("***[Debug] 가테고리 입력 실패 <-- CategoryDao.insertCategory()");
	      	  return;
	}
	
	/* [관리자] 카테고리 목록 출력 */
	public ArrayList<Category> selectCategoryList() throws ClassNotFoundException, SQLException{
		
		// 0. 카테고리의 목록을 반환해줄 ArrayList
		ArrayList<Category> returnCategoryList = new ArrayList<Category>();
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 2. DB에 등록된 카테고리의 목록을 조회하는 쿼리 생성
		String sql = "SELECT category_name categoryName, update_date updateDate, create_date createDate, category_state categoryState FROM category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		System.out.println("*[Debug] " + stmt +" <-- CategoryDao.selectCateogryList()");		
		
		// 3. 쿼리 실행 및 데이터 변환(rs -> Category)
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
