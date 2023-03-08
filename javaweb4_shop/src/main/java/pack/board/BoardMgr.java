package pack.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardMgr {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;	
	private DataSource ds;
	
	private int tot;	// 전체 레코드 수
	private int pList = 10;	// 페이지당 출력할 게시물의 수
	private int pageSu;	// 전체 페이지 수
	
	public BoardMgr() {
		try {
			Context context = new InitialContext();	
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");	// JNDI 사용
		} catch (Exception e) {
			System.out.println("BoardMgr err : " + e);
		}
	}
	
	public ArrayList<BoardDto> getDataAll(int page, String stype, String sword){
		ArrayList<BoardDto> list = new ArrayList<>();
		
		try {
			//String sql = "select * from board order by num desc";
			String sql = "select * from board";
			
			conn = ds.getConnection();
			if(sword == null) {
				sql += " order by gnum desc, onum asc";
				pstmt = conn.prepareStatement(sql);
			} else {
				sql += " where " + stype + " like ?";
				sql += " order by gnum desc, onum asc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + sword + "%");
			}
			rs = pstmt.executeQuery();
			
			
			for (int i = 0; i < (page - 1) * pList; i++) {
				rs.next();	// 해당 페이지 출력을 위해 레코드 포인터 이동		//ex) 1페이지일시 포인터 0, 2페이지일시 포인터 4
			}
			int k = 0;
			while(rs.next() && k < pList) {		//1페이지일시 1부터, 2페이지일시 5부터 출력
				BoardDto dto = new BoardDto();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setBdate(rs.getString("bdate"));
				dto.setReadcnt(rs.getInt("readcnt"));
				dto.setNested(rs.getInt("nested"));
				list.add(dto);
				k++;
			}
			
		} catch (Exception e) {
			System.out.println("getDataAll err : " + e);
		}finally {
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
	
	public int currentMaxNum() {	// board 테이블에서 num 최대번호 반환
		int cnt = 0;
		String sql = "select max(num) from board";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) cnt = rs.getInt(1);
			
		} catch (Exception e) {
			System.out.println("currentMaxNum err :" + e);
		} finally {
			try {
				if(rs != null) rs.close();		
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e3) {
				// TODO: handle exception
			}
		}
		return cnt;
	}
	
	public void saveData(BoardBean bean) {
		String sql = "insert into board values(?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bean.getNum());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getPass());
			pstmt.setString(4, bean.getMail());
			pstmt.setString(5, bean.getTitle());
			pstmt.setString(6, bean.getCont());
			pstmt.setString(7, bean.getBip());
			pstmt.setString(8, bean.getBdate());
			pstmt.setInt(9, 0);	//readcnt
			pstmt.setInt(10, bean.getGnum());
			pstmt.setInt(11, 0);	// onum
			pstmt.setInt(12, 0);	// nested
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("saveData err : " + e);
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
	
	public void totalList() {
		String sql = "select count(*) from board";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			tot = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("totalList err : " + e);
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
	
	public int getPageSu() {
		pageSu = tot / pList;
		if(tot % pList > 0) pageSu++;
		return pageSu;
	}
	
	public void updateReadcnt(String num) {		// 글 상세보기 전에 조회수 증가
		String sql = "update board set readcnt = readcnt + 1 where num=?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("updateReadcnt err : " + e);
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
	
	public BoardDto getData(String num) {	// 글 상세보기, 수정용
		String sql = "select * from board where num = ?";
		BoardDto dto = null;
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new BoardDto();
				dto.setName(rs.getString("name"));
				dto.setPass(rs.getString("pass"));
				dto.setMail(rs.getString("mail"));
				dto.setTitle(rs.getString("title"));
				dto.setCont(rs.getString("cont"));
				dto.setBip(rs.getString("bip"));
				dto.setBdate(rs.getString("bdate"));
				dto.setReadcnt(rs.getInt("readcnt"));
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
		return dto;
	}
	
	public boolean checkPass(int num, String new_pass) {
		boolean b = false;
		String sql = "select pass from board where num = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(new_pass.equals(rs.getString("pass"))) {
					b = true;
				} 
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
		return b;
	}
	
	public void saveEdit(BoardBean bean) {
		String sql = "update board set name=?, mail=?, title=?, cont=? where num=?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getMail());
			pstmt.setString(3, bean.getTitle());
			pstmt.setString(4, bean.getCont());
			pstmt.setInt(5, bean.getNum());
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
		}  finally {
			try {	
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e3) {
				// TODO: handle exception
			}
		}
	}
	
	public BoardDto getReplyData(String num) {	// 댓글용 데이터 읽기
		BoardDto dto = null;
		try {
			String sql = "select * from board where num=?";
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new BoardDto();
				dto.setTitle(rs.getString("title"));
				dto.setGnum(rs.getInt("gnum"));
				dto.setOnum(rs.getInt("onum"));
				dto.setNested(rs.getInt("nested"));
			}
					
		} catch (Exception e) {
			System.out.println("getReplyData err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();		
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e3) {
				
			}
		}
		return dto;
	}
	
	public void updateOnum(int gnum, int onum) {
		// 같은 그룹의 레코드는 모두 작업에 참여
		String sql = "update board set onum=onum + 1 where onum >= ? and gnum=?";
				
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, onum);
			pstmt.setInt(2, gnum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("updateOnum err : " + e);
		}  finally {
			try {
				if(rs != null) rs.close();		
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e3) {
				
			}
		}
	}
	
	public void saveReplyData(BoardBean bean) {		// 댓글 저장
		String sql = "insert into board values(?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bean.getNum());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getPass());
			pstmt.setString(4, bean.getMail());
			pstmt.setString(5, bean.getTitle());
			pstmt.setString(6, bean.getCont());
			pstmt.setString(7, bean.getBip());
			pstmt.setString(8, bean.getBdate());
			pstmt.setInt(9, 0);	//readcnt
			pstmt.setInt(10, bean.getGnum());
			pstmt.setInt(11, bean.getOnum());	// onum
			pstmt.setInt(12, bean.getNested());	// nested
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("saveData err : " + e);
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
