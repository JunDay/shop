package vo;

/* QnA에 대한 관리자의 답변 데이터들을 제공하기 위한 VO */
/* MariaDB
CREATE TABLE `order_comment` (
	`order_no` INT(11) NOT NULL,
	`ebook_no` INT(11) NOT NULL,
	`order_score` INT(11) NOT NULL,
	`order_comment_content` TEXT NOT NULL COLLATE 'utf8mb3_general_ci',
	`create_date` DATETIME NOT NULL,
	`update_date` DATETIME NOT NULL,
	PRIMARY KEY (`order_no`) USING BTREE
)
*/
public class OrderComment {
	private int orderNo;
	private int ebookNo;
	private int orderScore;
	private String orderCommentContent;
	private String createDate;
	private String updateDate;
	
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public int getEbookNo() {
		return ebookNo;
	}
	public void setEbookNo(int ebookNo) {
		this.ebookNo = ebookNo;
	}
	public int getOrderScore() {
		return orderScore;
	}
	public void setOrderScore(int orderScore) {
		this.orderScore = orderScore;
	}
	public String getOrderCommentContent() {
		return orderCommentContent;
	}
	public void setOrderCommentContent(String orderCommentContent) {
		this.orderCommentContent = orderCommentContent;
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
		return "OrderComment [orderNo=" + orderNo + ", ebookNo=" + ebookNo + ", orderScore=" + orderScore
				+ ", orderCommentContent=" + orderCommentContent + ", createDate=" + createDate + ", updateDate="
				+ updateDate + "]";
	}
}
