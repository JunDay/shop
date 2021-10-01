package vo;

/* 공지사항의 데이터들을 접근하기 위한 VO */
// 공지사항 게시자의 이름을 추가로 삽입
/* MariaDB
CREATE TABLE `notice` (
	`notice_no` INT(11) NOT NULL AUTO_INCREMENT,
	`notice_title` VARCHAR(500) NOT NULL COLLATE 'utf8mb3_general_ci',
	`notice_content` TEXT NOT NULL COLLATE 'utf8mb3_general_ci',
	`member_no` INT(11) NOT NULL,
	`create_date` DATETIME NOT NULL,
	`update_date` DATETIME NOT NULL,
	PRIMARY KEY (`notice_no`) USING BTREE
)
*/
public class Notice {
	private int noticeNo;
	private String noticeTitle;
	private String noticeContent;
	private int memberNo;
	private String memberName;
	private String createDate;
	private String updateDate;
	
	
	public int getNoticeNo() {
		return noticeNo;
	}
	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	public String getNoticeContent() {
		return noticeContent;
	}
	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}
	public int getMemberNo() {
		return memberNo;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	
	@Override
	public String toString() {
		return "Notice [noticeNo=" + noticeNo + ", noticeTitle=" + noticeTitle + ", noticeContent=" + noticeContent
				+ ", memberNo=" + memberNo + ", memberName=" + memberName + ", createDate=" + createDate
				+ ", updateDate=" + updateDate + "]";
	}
}
