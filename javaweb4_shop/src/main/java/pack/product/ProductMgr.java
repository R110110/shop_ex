package pack.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import pack.order.OrderBean;

public class ProductMgr {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;	
	private DataSource ds;
	
	public ProductMgr() {
		try {
			Context context = new InitialContext();	
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");	// JNDI 사용
		} catch (Exception e) {
			System.out.println("BoardMgr err : " + e);
		}
	}
	
	public ArrayList<ProductBean> getProductAll(){
		ArrayList<ProductBean> list = new ArrayList<>();
		try {
			conn = ds.getConnection();
			String sql = "select * from shop_product order by no desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductBean bean = new ProductBean();
				bean.setNo(rs.getString("no"));
				bean.setName(rs.getString("name"));
				bean.setPrice(rs.getString("price"));
				bean.setDetail(rs.getString("detail"));
				bean.setSdate(rs.getString("sdate"));
				bean.setStock(rs.getString("stock"));
				bean.setImage(rs.getString("image"));
				list.add(bean);
			}
			
		} catch (Exception e) {
			System.out.println("getProductAll err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();		
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e3) {
				// TODO: handle exception
			}
		}
		
		return list;
	}
	
	 public boolean insertProduct(HttpServletRequest request) {
		 boolean b = false;
		 try {
			 // 업로드할 이미지를 절대 경로로 입력(정해진 약속)
			 String uploadDir = "C:/work/sou/javaweb4_shop/src/main/webapp/upload";
			 MultipartRequest multi = new MultipartRequest(request, uploadDir, 5*1024*1024, "utf-8", new DefaultFileRenamePolicy());
			 
			conn = ds.getConnection();
			String sql = "insert into shop_product(name, price, detail, sdate, stock, image) values(?,?,?,now(),?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("name"));
			pstmt.setString(2, multi.getParameter("price"));
			pstmt.setString(3, multi.getParameter("detail"));
			pstmt.setString(4, multi.getParameter("stock"));
			if(multi.getFilesystemName("image") == null) {
				pstmt.setString(5, "ready.gif");
			} else {
				pstmt.setString(5, multi.getFilesystemName("image"));	//getParameter가 아닌 getFilesystemName로 파일 받아오기
			}
			
			if(pstmt.executeUpdate() > 0) {
				b = true;
			}
			
		} catch (Exception e) {
			System.out.println("insertProduct err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();		
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e3) {
				// TODO: handle exception
			}
		}
		 return b;
	 }
	 
	 public ProductBean getProduct(String no) {
		 		ProductBean bean = null;
		 try {
			conn = ds.getConnection();
			String sql = "select * from shop_product where no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, no);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				bean = new ProductBean();
				bean.setNo(rs.getString("no"));
				bean.setName(rs.getString("name"));
				bean.setPrice(rs.getString("price"));
				bean.setDetail(rs.getString("detail"));
				bean.setSdate(rs.getString("sdate"));
				bean.setStock(rs.getString("stock"));
				bean.setImage(rs.getString("image"));
			}
		} catch (Exception e) {
			System.out.println("getProduct err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();		
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e3) {
				// TODO: handle exception
			}
		} 
		 return bean;
	 }
	 
	 public boolean updateProduct(HttpServletRequest request) {
		 boolean b = false;
		 try {
			 // 업로드할 이미지를 절대 경로로 입력(정해진 약속)
			 String uploadDir = "C:/work/sou/javaweb4_shop/src/main/webapp/upload";
			 MultipartRequest multi = new MultipartRequest(request, uploadDir, 5*1024*1024, "utf-8", new DefaultFileRenamePolicy());
			 
			conn = ds.getConnection();
			
			if(multi.getFilesystemName("image") == null) {
				String sql = "update shop_product set name=?, price=?, detail=?, stock=? where no=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("name"));
				pstmt.setString(2, multi.getParameter("price"));
				pstmt.setString(3, multi.getParameter("detail"));
				pstmt.setString(4, multi.getParameter("stock"));
				pstmt.setString(5, multi.getParameter("no"));
			} else {
				String sql = "update shop_product set name=?, price=?, detail=?, stock=?, image=? where no=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("name"));
				pstmt.setString(2, multi.getParameter("price"));
				pstmt.setString(3, multi.getParameter("detail"));
				pstmt.setString(4, multi.getParameter("stock"));
				pstmt.setString(5, multi.getFilesystemName("image"));
				pstmt.setString(6, multi.getParameter("no"));
			}
			
			if(pstmt.executeUpdate() > 0) {
				b = true;
			}
			
		} catch (Exception e) {
			System.out.println("insertProduct err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();		
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e3) {
				// TODO: handle exception
			}
		}
		 return b;
	 }
	 
	 public boolean deleteProduct(String no) {
		 boolean b = false;
		 try {
			conn = ds.getConnection();
			String sql = "delete from shop_product where no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, no);
			if(pstmt.executeUpdate() > 0) {
				b = true;
			} 
			
		} catch (Exception e) {
			System.out.println("deleteProduct err : " + e);
		} finally {
			try {			
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e3) {
				// TODO: handle exception
			}
		}
		 return b;
	 }
	 
	 // 고객이 상품 주문 시 주문 수량만큼 재고량 줄이기
	 public void reduceProduct(OrderBean orderBean) {
		 try {
			conn = ds.getConnection();
			String sql = "update shop_product set stock=(stock-?) where no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, orderBean.getQuantity());
			pstmt.setString(2, orderBean.getProduct_no());
			pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("reduceProduct err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();		
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e3) {
				// TODO: handle exception
			}
		}
	 }
}
