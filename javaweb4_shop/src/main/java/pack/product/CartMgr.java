package pack.product;

import java.util.Hashtable;

import pack.order.OrderBean;

public class CartMgr {
	private Hashtable<String, OrderBean> hCart = new Hashtable<>();
	
	public void addCart(OrderBean obean) {
		String product_no = obean.getProduct_no();	// 주문 상품 번호
		int quantity = Integer.parseInt(obean.getQuantity());	// 주문 수량
		
		if(quantity > 0) {
			// 동일 상품 주문시 주문 수량만 증가
			if(hCart.containsKey(product_no)) {	// 키값의 존재여부 확인. 존재하면 이미 1회 이상 주문이 된 상품
				OrderBean temp = hCart.get(product_no);		// 키값 받아오기
				quantity += Integer.parseInt(temp.getQuantity());	//키값으로 수량 int로 변환 후 누적
				temp.setQuantity(Integer.toString(quantity));	// 누적된 수량을 string으로 변환후 temp에 입력
				hCart.put(product_no, temp);	
				System.out.println("동일 상품 주문시 총 수량 : " + quantity);
			} else {	// 키값이 존재하지 않으면 새 상품 주문
				hCart.put(product_no, obean);
			}
		}
		
	}
		public Hashtable<String, OrderBean> getCartList(){
			
			return hCart;
		}
		
		public void updateCart(OrderBean obean) {
			String product_no = obean.getProduct_no();
			hCart.put(product_no, obean);
		}
		
		public void deleteCart(OrderBean obean) {
			String product_no = obean.getProduct_no();
			hCart.remove(product_no);
		}
	}
