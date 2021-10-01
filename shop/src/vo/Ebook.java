package vo;

/* Ebook의 데이터를 접근하기 위한 VO */
/* MariaDB
CREATE TABLE `ebook` (
	`ebook_no` INT(11) NOT NULL AUTO_INCREMENT,
	`ebook_isbn` CHAR(13) NOT NULL COLLATE 'utf8mb3_general_ci',
	`category_name` VARCHAR(50) NOT NULL COLLATE 'utf8mb3_general_ci',
	`ebook_title` VARCHAR(50) NOT NULL COLLATE 'utf8mb3_general_ci',
	`ebook_author` VARCHAR(50) NOT NULL COLLATE 'utf8mb3_general_ci',
	`ebook_company` VARCHAR(50) NOT NULL COLLATE 'utf8mb3_general_ci',
	`ebook_page_count` INT(11) NOT NULL,
	`ebook_price` INT(11) NOT NULL,
	`ebook_img` VARCHAR(50) NOT NULL COLLATE 'utf8mb3_general_ci',
	`ebook_summary` TEXT NOT NULL COLLATE 'utf8mb3_general_ci',
	`ebook_state` ENUM('판매중','품절','절판','구편절판') NOT NULL COLLATE 'utf8mb3_general_ci',
	`create_date` DATETIME NOT NULL,
	`update_date` DATETIME NOT NULL,
	PRIMARY KEY (`ebook_no`) USING BTREE,
	INDEX `FK_ebook_category` (`category_name`) USING BTREE,
	CONSTRAINT `FK_ebook_category` FOREIGN KEY (`category_name`) REFERENCES `shop`.`category` (`category_name`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
 */
public class Ebook {
	 public int ebookNo;
	 public String ebookISBN;
	 public String categoryName;
	 public String ebookTitle;
	 public String ebookAuthor;
	 public String ebookCompany;
	 public int ebookPageCount;
	 public int ebookPrice;
	 public String ebookImg;
	 public String ebookSummary;
	 public String ebookState;
	 public String createDate;
	 public String updateDate;
	   
	public int getEbookNo() {
		return ebookNo;
	}
	public void setEbookNo(int ebookNo) {
		this.ebookNo = ebookNo;
	}
	public String getEbookISBN() {
		return ebookISBN;
	}
	public void setEbookISBN(String ebookISBN) {
		this.ebookISBN = ebookISBN;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getEbookTitle() {
		return ebookTitle;
	}
	public void setEbookTitle(String ebookTitle) {
		this.ebookTitle = ebookTitle;
	}
	public String getEbookAuthor() {
		return ebookAuthor;
	}
	public void setEbookAuthor(String ebookAuthor) {
		this.ebookAuthor = ebookAuthor;
	}
	public String getEbookCompany() {
		return ebookCompany;
	}
	public void setEbookCompany(String ebookCompany) {
		this.ebookCompany = ebookCompany;
	}
	public int getEbookPageCount() {
		return ebookPageCount;
	}
	public void setEbookPageCount(int ebookPageCount) {
		this.ebookPageCount = ebookPageCount;
	}
	public int getEbookPrice() {
		return ebookPrice;
	}
	public void setEbookPrice(int ebookPrice) {
		this.ebookPrice = ebookPrice;
	}
	public String getEbookImg() {
		return ebookImg;
	}
	public void setEbookImg(String ebookImg) {
		this.ebookImg = ebookImg;
	}
	public String getEbookSummary() {
		return ebookSummary;
	}
	public void setEbookSummary(String ebookSummary) {
		this.ebookSummary = ebookSummary;
	}
	public String getEbookState() {
		return ebookState;
	}
	public void setEbookState(String ebookState) {
		this.ebookState = ebookState;
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
		return "Ebook [ebookNo=" + ebookNo + ", ebookISBN=" + ebookISBN + ", categoryName=" + categoryName
				+ ", ebookTitle=" + ebookTitle + ", ebookAuthor=" + ebookAuthor + ", ebookCompany=" + ebookCompany
				+ ", ebookPageCount=" + ebookPageCount + ", ebookPrice=" + ebookPrice + ", ebookImg=" + ebookImg
				+ ", ebookSummary=" + ebookSummary + ", ebookState=" + ebookState + ", createDate=" + createDate
				+ ", updateDate=" + updateDate + "]";
	}
}