package sw_project.service;

import sw_project.model.ConnectionContext;
import sw_project.model.Like;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LikeService {

    /**
     * 좋아요 등록
     */
    public boolean addLike(Like like) {
        String sql = "INSERT INTO likes (board_id, user_id) VALUES (?, ?)";

        try (Connection conn = ConnectionContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, like.getBoardId());
            pstmt.setInt(2, like.getUserId());
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 좋아요 취소
     */
    public boolean removeLike(int boardId, int userId) {
        String sql = "DELETE FROM likes WHERE board_id = ? AND user_id = ?";

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

    /**
     * 특정 게시글 좋아요 갯수 조회
     */
    public int getLikeCount(int boardId) {
        String sql = "SELECT COUNT(*) AS cnt FROM likes WHERE board_id = ?";
        int likeCount = 0;

        try (Connection conn = ConnectionContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, boardId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    likeCount = rs.getInt("cnt");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return likeCount;
    }

    /**
     * 특정 사용자가 해당 글에 좋아요를 눌렀는지 확인
     */
    public boolean isLikedByUser(int boardId, int userId) {
        String sql = "SELECT COUNT(*) FROM likes WHERE board_id = ? AND user_id = ?";

        try (Connection conn = ConnectionContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, boardId);
            pstmt.setInt(2, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    return count > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
