package vo;

/* QnA의 데이터를 제공하기 위한 VO */
/* MariaDB
CREATE TABLE `category` (
	`category_name` VARCHAR(200) NOT NULL COLLATE 'utf8mb3_general_ci',
	`update_date` DATETIME NOT NULL,
	`create_date` DATETIME NOT NULL,
	`category_state` ENUM('Y','N') NOT NULL DEFAULT 'Y' COLLATE 'utf8mb3_general_ci',
	PRIMARY KEY (`category_name`) USING BTREE
)
 */

public class Category {
	private String categoryName;
	private String updateDate;
	private String createDate;
	private String categoryState;
	
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
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
	public String getCategoryState() {
		return categoryState;
	}
	public void setCategoryState(String categoryState) {
		this.categoryState = categoryState;
	}
	@Override
	public String toString() {
		return "Category [categoryName=" + categoryName + ", updateDate=" + updateDate + ", createDate=" + createDate
				+ ", categoryState=" + categoryState + "]";
	}
	
}
