package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.*;

public class NoticeDao {
	
	/* [관리자] 공지사항 수정 */
	public void updateNotice(Notice notice) throws ClassNotFoundException, SQLException {
		System.out.println("+[Debug] \"Started\" | NoticeDao.updatNotice()");
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. noticeNo과 memberNo가 일치하면 해당 입력된 공지사항 정보를 갱신하는 쿼리 생성
		String sql="UPDATE notice SET notice_title=?, notice_content=?, update_date=NOW() WHERE notice_no=? AND member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setInt(3, notice.getNoticeNo());
		stmt.setInt(4, notice.getMemberNo());
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | NoticeDao.updatNotice()");
		
		// 2. 쿼리 실행
		int row = stmt.executeUpdate();
		
		
		// 3. 사용한 자원 반환
		stmt.close();
		conn.close();
		
		// 4. 실행 결과 디버깅
		if(row == 1) {
			System.out.println(" [Debug] \"Succesful Finished\" | NoticeDao.updatNotice()");
		} else {
			System.out.println("-[Debug] \"Failed\" | NoticeDao.updatNotice()");
		}
	}
	
	/* [관리자] 공지사항을 삭제하기 전 비밀번호 확인 */
	public int deleteNoticeAdminCheck(String memberId, String memberPw) throws ClassNotFoundException, SQLException {
		
		// 0. 확인된 memebrId를 반환해주기 위한 변수
		String adminPw = null;
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. memberId를 이용해 로그인된 memberPw를 조회하고 입력받은 memberPw와 같은지 확인하는 쿼리 생성
		String sql = "SELECT member_pw adminPw FROM member WHERE member_id=? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setString(2, memberPw);
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | NoticeDao.deleteNoticeAdminCheck()");

		// 2. 쿼리 실행 및 Pw 값 변수에 대입
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			adminPw = rs.getString("adminPw");
		}
		
		// 3. 사용한 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		// 4. 입력한 Pw와 DB의 Pw를 비교
			// 성공 : 1 반환 | 실패 : 0 반환
		if(adminPw != null) {
			System.out.println(" [Debug] \"Succesful Finished\" | NoticeDao.deleteNoticeAdminCheck()");
			return 1;
		}
		System.out.println("-[Debug] \"Failed\" | NoticeDao.deleteNoticeAdminCheck()");
		return 0;
	}
	
	/* [관리자] 공지사항 삭제 */
	public void deleteNotice(int noticeNo) throws SQLException, ClassNotFoundException {
		System.out.println("+[Debug] \"Started\" | EbookDao.deleteNotice()");
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		System.out.println(" [Debug] noticeNo : \""+noticeNo+"\" | NoticeDao.deleteNotice()");
		
		// 1. noticeNo에 해당되는 공지사항 삭제 쿼리 생성
		String sql = "DELETE FROM notice WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | NoticeDao.deleteNotice()");
		
		// 2. 쿼리실행
		int row = stmt.executeUpdate();
		
		// 3. 사용한 자원 반환
		stmt.close();
		conn.close();
		
		// 4. 쿼리 실행결과 디버깅
		if(row == 1) {
			System.out.println(" [Debug] \"Succesful Finished\" | NoticeDao.deleteNotice()");
		}
		System.out.println("-[Debug] \"Failed\" | NoticeDao.deleteNotice()");
	}
	
	
	/* [관리자] 공지사항 작성 */
	public void insertNotice(Notice notice) throws ClassNotFoundException, SQLException {
		System.out.println("+[Debug] \"Started\" | NoticeDao.insertNotice()");
		
		// 0. Form에서 받은 내용 디버깅
		System.out.println(" [Debug] getNoticeTitle : \""+notice.getNoticeTitle()+"\" | NoticeDao.insertNotice() FROM /admin/insertNoticeForm.jsp");
		System.out.println(" [Debug] getNoticeContent : \"" + notice.getNoticeContent() +"\" | NoticeDao.insertNotice() FROM /admin/insertNoticeForm.jsp");
		System.out.println(" [Debug] getMemberNo : \"" + notice.getMemberNo() +"\" | NoticeDao.insertNotice() FROM /admin/insertNoticeForm.jsp");
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. 입력받은 공지사항 정보들을 삽입하는 쿼리생성
		String sql = "INSERT INTO notice(notice_title, notice_content, member_no, update_date, create_date) VALUES(?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setInt(3, notice.getMemberNo());
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | NoticeDao.selectNoticerOne()");
		
		// 2. 쿼리 실행
		int row = stmt.executeUpdate();
		
		// 3. 사용한 자원 반환
		stmt.close();
		conn.close();
		
		// 4. 쿼리 실행결과 디버깅
		if(row == 1) {
			System.out.println(" [Debug] \"Succesful Finished\" | NoticeDao.insertNotice()");
		}
		System.out.println("-[Debug] \"Failed\" | NoticeDao.insertNotice()");
	}
	
	/* [공통] 선택한 notice 상세 정보 출력 */
	public Notice selectNoticeOne(int noticeNo) throws ClassNotFoundException, SQLException {
		System.out.println("+[Debug] \"Started\" | NoticeDao.selectNoticerOne()");
		
		// 0. 리턴할 Notice List 생성
		Notice notice = new Notice();
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. noticeNo을 이용해 해당되는 notice의 정보들을 조회하는 쿼리 생성
		String sql = "SELECT n.notice_no noticeNo, n.notice_title noticeTitle, n.notice_content noticeContent, n.member_no memberNo, m.member_name memberName, n.create_date createDate, n.update_date updateDate FROM notice n INNER JOIN member m ON n.member_no = m.member_no WHERE n.notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | NoticeDao.selectNoticerOne()");
		
		// 2. 쿼리 실행 및 데이터 변환(rs -> Notice)
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			notice.setNoticeNo(rs.getInt("noticeNo"));
			notice.setNoticeTitle(rs.getString("noticeTitle"));
			notice.setNoticeContent(rs.getString("noticeContent"));
			notice.setMemberNo(rs.getInt("memberNo"));
			notice.setMemberName(rs.getString("memberName"));
			notice.setCreateDate(rs.getString("createDate"));
			notice.setUpdateDate(rs.getString("updateDate"));
		}
		
		// 3. 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		// 4. 조회된 Notice의 객체를 반환
		return notice;
	}
		
	
	/* [공통] 모든 notice 목록 출력 */
	public ArrayList<Notice> selectNoticeList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException{
		System.out.println("+[Debug] \"Started\" | NoticeDao.selectNoticeList()");
		
		// 0. 리턴할 Notice List 생성
		ArrayList<Notice> list = new ArrayList<>();
		
		// 0. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 1. Notice의 전체 목록 출력 조회 쿼리
		String sql="SELECT n.notice_no noticeNo, n.notice_title noticeTitle, n.notice_content noticeContent, n.member_no memberNo, m.member_name memberName, n.create_date createDate, n.update_date updateDate FROM notice n INNER JOIN member m ON n.member_no = m.member_no ORDER BY n.create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		System.out.println(" [Debug] stmt : \""+stmt +"\" | NoticeDao.selectNoticeList()");
		
		// 2. 쿼리 실행 및 데이터 변환(rs -> ArrayList<Notice>)
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Notice notice = new Notice();
			notice.setNoticeNo(rs.getInt("noticeNo"));
			notice.setNoticeTitle(rs.getString("noticeTitle"));
			notice.setNoticeContent(rs.getString("noticeContent"));
			notice.setMemberNo(rs.getInt("memberNo"));
			notice.setMemberName(rs.getString("memberName"));
			notice.setCreateDate(rs.getString("createDate"));
			notice.setUpdateDate(rs.getString("updateDate"));
			list.add(notice);
		}
		
		// 3. 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		// 4. 조회된 전체 notice의 리스트 목록 반환
		return list;
	}
}
