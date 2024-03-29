package vo;

/* Order, Ebook, Member의 정보들의 join된 정보들을 제공하기 위한 VO */
public class OrderEbookMember {
	private Order order;
	private Ebook ebook;
	private Member member;
	
	public Order getOrder() {
		return order;
	}
	public void setOrder(Order order) {
		this.order = order;
	}
	public Ebook getEbook() {
		return ebook;
	}
	public void setEbook(Ebook ebook) {
		this.ebook = ebook;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	@Override
	public String toString() {
		return "OrderEbookMember [order=" + order + ", ebook=" + ebook + ", member=" + member + "]";
	}
}
