package vo;

/* QnA의 댓글에 대한 데이터를 제공하기 위한 VO */
// +추가적으로 memberName을 저장할 수 있는 항목 추가
/* MariaDB
CREATE TABLE `qna_comment` (
	`qna_no` INT(11) NOT NULL,
	`qna_comment_content` TEXT NOT NULL COLLATE 'utf8mb3_general_ci',
	`member_no` INT(11) NOT NULL,
	`create_date` DATETIME NOT NULL,
	`update_date` DATETIME NOT NULL,
	PRIMARY KEY (`qna_no`) USING BTREE
)
 * */
public class QnaComment {
	private int qnaNo;
	private String qnaCommentContent;
	private int memberNo;
	private String memberName;
	private String createDate;
	private String updateDate;
	
	public int getQnaNo() {
		return qnaNo;
	}
	public void setQnaNo(int qnaNo) {
		this.qnaNo = qnaNo;
	}
	public String getQnaCommentContent() {
		return qnaCommentContent;
	}
	public void setQnaCommentContent(String qnaCommentContent) {
		this.qnaCommentContent = qnaCommentContent;
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
		return "QnaComment [qnaNo=" + qnaNo + ", qnaCommentContent=" + qnaCommentContent + ", memberNo=" + memberNo
				+ ", memberName=" + memberName + ", createDate=" + createDate + ", updateDate=" + updateDate + "]";
	}
}
