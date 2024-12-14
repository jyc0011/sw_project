package sw_project.service;

import sw_project.model.Comment;
import sw_project.model.ConnectionContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentService {

    /**
     * 댓글 작성
     */
    public boolean createComment(Comment comment) {
        String sql = "INSERT INTO comments (board_id, user_id, content, created_date, pid) VALUES (?, ?, ?, NOW(), ?)";

        try (Connection conn = ConnectionContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, comment.getBoardId());
            pstmt.setInt(2, comment.getUserId());
            pstmt.setString(3, comment.getContent());
            pstmt.setInt(4, comment.getPid()); // 대댓글(parent reply)이면 부모 id 지정, 아니면 0

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 특정 게시글의 댓글 목록
     */
    public List<Comment> getCommentsByBoardId(int boardId) {
        List<Comment> commentList = new ArrayList<>();
        String sql = "SELECT id, board_id, user_id, content, created_date, pid FROM comments WHERE board_id = ? ORDER BY id ASC";

        try (Connection conn = ConnectionContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, boardId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Comment comment = new Comment();
                    comment.setId(rs.getInt("id"));
                    comment.setBoardId(rs.getInt("board_id"));
                    comment.setUserId(rs.getInt("user_id"));
                    comment.setContent(rs.getString("content"));
                    comment.setCreatedDate(rs.getTimestamp("created_date"));
                    comment.setPid(rs.getInt("pid"));
                    commentList.add(comment);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return commentList;
    }

    /**
     * 댓글 상세 조회
     */
    public Comment getCommentById(int commentId) {
        Comment comment = null;
        String sql = "SELECT id, board_id, user_id, content, created_date, pid FROM comments WHERE id = ?";

        try (Connection conn = ConnectionContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, commentId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    comment = new Comment();
                    comment.setId(rs.getInt("id"));
                    comment.setBoardId(rs.getInt("board_id"));
                    comment.setUserId(rs.getInt("user_id"));
                    comment.setContent(rs.getString("content"));
                    comment.setCreatedDate(rs.getTimestamp("created_date"));
                    comment.setPid(rs.getInt("pid"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comment;
    }

    /**
     * 댓글 수정
     */
    public boolean updateComment(Comment comment) {
        String sql = "UPDATE comments SET content = ? WHERE id = ? AND user_id = ?";

        try (Connection conn = ConnectionContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, comment.getContent());
            pstmt.setInt(2, comment.getId());
            pstmt.setInt(3, comment.getUserId());
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 댓글 삭제
     */
    public boolean deleteComment(int commentId, int userId) {
        String sql = "DELETE FROM comments WHERE id = ? AND user_id = ?";

        try (Connection conn = ConnectionContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, commentId);
            pstmt.setInt(2, userId);
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}