package vo;

/* 멤버의 데이터를 제공하기 위한 VO */
/* MariaDB
CREATE TABLE `member` (
	`member_no` INT(11) NOT NULL AUTO_INCREMENT,
	`member_id` VARCHAR(50) NOT NULL COLLATE 'utf8mb3_general_ci',
	`member_pw` VARCHAR(200) NOT NULL COLLATE 'utf8mb3_general_ci',
	`member_level` INT(11) NOT NULL,
	`member_name` VARCHAR(50) NOT NULL COLLATE 'utf8mb3_general_ci',
	`member_age` INT(11) NOT NULL,
	`member_gender` ENUM('남','여') NOT NULL COLLATE 'utf8mb3_general_ci',
	`update_date` DATETIME NOT NULL,
	`create_date` DATETIME NOT NULL,
	PRIMARY KEY (`member_no`) USING BTREE,
	UNIQUE INDEX `member_id` (`member_id`) USING BTREE
)
 */
public class Member {
	private int memberNo;
	private String memberId;
	private String memberPw;
	private int memberLevel;
	private String memberName;
	private int memberAge;
	private String memberGender;
	private String updateDate;
	private String createDate;
	
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberPw() {
		return memberPw;
	}
	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}
	public int getMemberLevel() {
		return memberLevel;
	}
	public void setMemberLevel(int memberLevel) {
		this.memberLevel = memberLevel;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public int getMemberAge() {
		return memberAge;
	}
	public void setMemberAge(int memberAge) {
		this.memberAge = memberAge;
	}
	public String getMemberGender() {
		return memberGender;
	}
	public void setMemberGender(String memberGender) {
		this.memberGender = memberGender;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	@Override
	public String toString() {
		return "Member [memberNo=" + memberNo + ", memberId=" + memberId + ", memberPw=" + memberPw + ", memberLevel="
				+ memberLevel + ", memberName=" + memberName + ", memberAge=" + memberAge + ", memberGender="
				+ memberGender + ", updateDate=" + updateDate + ", createDate=" + createDate + "]";
	}
}
