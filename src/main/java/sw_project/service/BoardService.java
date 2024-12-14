package sw_project.service;

import sw_project.model.Board;
import sw_project.model.ConnectionContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BoardService {

    /**
     * 게시글 작성
     */
    public boolean createBoard(Board board) {
        String sql = "INSERT INTO boards (title, content, user_id, created_date) VALUES (?, ?, ?, NOW())";

        try (Connection conn = ConnectionContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, board.getTitle());
            pstmt.setString(2, board.getContent());
            pstmt.setInt(3, board.getUserId());
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 게시글 목록 조회
     */
    public List<Board> getBoardList(int page, int pageSize) {
        List<Board> boardList = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = "SELECT b.id, b.title, u.username, b.created_date, b.view_count " +
                "FROM boards b JOIN users u ON b.user_id = u.id " +
                "ORDER BY b.id DESC LIMIT ? OFFSET ?";

        try (Connection conn = ConnectionContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, pageSize);
            pstmt.setInt(2, offset);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Board board = new Board();
                    board.setId(rs.getInt("id"));
                    board.setTitle(rs.getString("title"));
                    board.setUserId(rs.getInt("user_id"));
                    board.setUsername(rs.getString("username")); // 작성자 이름 설정
                    board.setCreatedDate(rs.getTimestamp("created_date"));
                    board.setViewCount(rs.getInt("view_count"));
                    boardList.add(board);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return boardList;
    }

    public int getTotalBoardCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) AS total FROM boards";

        try (Connection conn = ConnectionContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }

    /**
     * 게시글 상세 조회
     */
    public Board getBoardById(int boardId) {
        Board board = null;
        String sql = "SELECT id, title, content, user_id, created_date FROM boards WHERE id = ?";

        try (Connection conn = ConnectionContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, boardId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    board = new Board();
                    board.setId(rs.getInt("id"));
                    board.setTitle(rs.getString("title"));
                    board.setContent(rs.getString("content"));
                    board.setUserId(rs.getInt("user_id"));
                    board.setCreatedDate(rs.getTimestamp("created_date"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return board;
    }

    /**
     * 게시글 수정
     */
    public boolean updateBoard(Board board) {
        String sql = "UPDATE boards SET title = ?, content = ? WHERE id = ? AND user_id = ?";

        try (Connection conn = ConnectionContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, board.getTitle());
            pstmt.setString(2, board.getContent());
            pstmt.setInt(3, board.getId());
            pstmt.setInt(4, board.getUserId());
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 게시글 삭제
     */
    public boolean deleteBoard(int boardId, int userId) {
        String sql = "DELETE FROM boards WHERE id = ? AND user_id = ?";

        try (Connection conn = ConnectionContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, boardId);
            pstmt.setInt(2, userId);
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}