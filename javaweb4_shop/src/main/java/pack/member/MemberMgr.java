package pack.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberMgr {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;	
	private DataSource ds;
	
	public MemberMgr() {
		try {
			Context context = new InitialContext();	
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");	// JNDI 사용
		} catch (Exception e) {
			System.out.println("BoardMgr err : " + e);
		}
	}
	
	// 우편번호 검색
	public ArrayList<ZipcodeDto> zipcodeRead(String dongName){
		ArrayList<ZipcodeDto> list = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			String sql = "select * from ziptab where area3 like ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dongName + "%");
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ZipcodeDto dto = new ZipcodeDto();
				dto.setZipcode(rs.getString("zipcode"));
				dto.setArea1(rs.getString("area1"));
				dto.setArea2(rs.getString("area2"));
				dto.setArea3(rs.getString("area3"));
				dto.setArea4(rs.getString("area4"));
				list.add(dto);
			}
		} catch (Exception e) {
			// TODO: handle exception
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
	
	public boolean checkid(String id) {
		boolean b = false;
		
		try {
			conn = ds.getConnection();
			String sql = "select id from member where id=?";
			//	String sql = "select count(*) from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			b = rs.next();
			
		} catch (Exception e) {
			System.out.println("checkid err : " + e);
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
	
	public boolean memberInsert(MemberBean bean) {
		boolean b = false;
		
		try {
			conn = ds.getConnection();
			String sql = "insert into member values(?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getPasswd());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getEmail());
			pstmt.setString(5, bean.getPhone());
			pstmt.setString(6, bean.getZipcode());
			pstmt.setString(7, bean.getAddress());
			pstmt.setString(8, bean.getJob());
			
			if(pstmt.executeUpdate() > 0) b = true;
		} catch (Exception e) {
			System.out.println("getConnection : " + e);
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
	
	public boolean loginCheck(String id, String passwd) {
		boolean b = false;
		
		try {
			conn = ds.getConnection();
			String sql = "select * from member where id=? and passwd=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			rs = pstmt.executeQuery();
			b = rs.next();
			
		} catch (Exception e) {
			System.out.println("loginCheck err : " + e);
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
	
	public MemberBean getMember(String id) {
		MemberBean bean = null;
		
		try {
			conn = ds.getConnection();
			String sql = "select * from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean = new MemberBean();
				bean.setId(rs.getString("id"));
				bean.setPasswd(rs.getString("passwd"));
				bean.setName(rs.getString("name"));
				bean.setEmail(rs.getString("email"));
				bean.setPhone(rs.getString("phone"));
				bean.setZipcode(rs.getString("zipcode"));
				bean.setAddress(rs.getString("address"));
				bean.setJob(rs.getString("job"));
			}
		} catch (Exception e) {
			System.out.println("getMember err : " + e);
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
	
	public boolean memberUpdate(MemberBean bean, String id) {
		boolean b = false;
		//System.out.println(bean.getName());
		try {
			conn = ds.getConnection();
			String sql = "update member set passwd=?, name=?, email=?, phone=?, zipcode=?, address=?, job=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getPasswd());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getEmail());
			pstmt.setString(4, bean.getPhone());
			pstmt.setString(5, bean.getZipcode());
			pstmt.setString(6, bean.getAddress());
			pstmt.setString(7, bean.getJob());
			pstmt.setString(8, id);
			if(pstmt.executeUpdate() > 0) {
				b = true;
			}

		} catch (Exception e) {
			System.out.println("memberUpdate err : " + e);
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
	
	public boolean adminLoginCheck(String adminid, String adminpasswd) {
		boolean b = false;
		
		try {
			conn = ds.getConnection();
			String sql = "select * from admin where admin_id=? and admin_passwd=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, adminid);
			pstmt.setString(2, adminpasswd);
			rs = pstmt.executeQuery();
			b = rs.next();
		} catch (Exception e) {
			System.out.println("adminLoginCheck err : " + e);
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
	
	public ArrayList<MemberBean> getMemberAll(){
		ArrayList<MemberBean> list = new ArrayList<>();
		try {
			conn = ds.getConnection();
			String sql = "select * from member";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberBean bean = new MemberBean();
				bean.setId(rs.getString("id"));
				bean.setPasswd(rs.getString("passwd"));
				bean.setName(rs.getString("name"));
				bean.setEmail(rs.getString("email"));
				bean.setPhone(rs.getString("phone"));
				bean.setZipcode(rs.getString("zipcode"));
				bean.setAddress(rs.getString("address"));
				bean.setJob(rs.getString("job"));
				list.add(bean);
			}
			
		} catch (Exception e) {
			System.out.println("getMemberAll err : " + e);
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
}
