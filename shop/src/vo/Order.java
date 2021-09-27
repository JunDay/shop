package vo;

public class Order {
	/*
	#문제 조인된 쿼리를 모두 담을 수 없다...
	private int orderNo;
	private Ebook ebook; <-- private Ebook ebook; : 이게 FM이고, 옳은 방법 하지만... =_=
	private Member member; <-- private Member member;
	private int orderPrice;
	private String orderDate;
	private String updateDate;
	DTO VO domain
	
	insert -> domain
	join -> vo
	*/
	
	private int orderNo;
	private int ebookNo;
	private int memberNo;
	private int orderPrice;
	private String orderDate;
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
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public int getOrderPrice() {
		return orderPrice;
	}
	public void setOrderPrice(int orderPrice) {
		this.orderPrice = orderPrice;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	
}
