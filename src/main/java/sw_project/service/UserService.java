package sw_project.service;

import sw_project.model.ConnectionContext;
import sw_project.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserService {

    /**
     * 회원가입 로직
     * @param user 가입할 사용자의 정보
     * @return 가입 성공 여부
     */
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (username, password, email) VALUES (?, ?, ?)";

        // try-with-resources 구문을 통해 커넥션, pstmt 자동 close
        try (Connection conn = ConnectionContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword()); // 실제 운영 시 암호화 권장
            pstmt.setString(3, user.getEmail());

            int affectedRows = pstmt.executeUpdate();
            return (affectedRows > 0);

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 로그인 로직
     * @param username 로그인 시도 아이디
     * @param password 로그인 시도 비밀번호
     * @return 로그인 성공 시 해당 User 객체, 실패 시 null
     */
    public User login(String username, String password) {
        String sql = "SELECT id, username, password, email FROM users WHERE username = ?";

        try (Connection conn = ConnectionContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    String dbPassword = rs.getString("password");
                    if (dbPassword.equals(password)) {
                        // 로그인 성공
                        User user = new User();
                        user.setId(rs.getInt("id"));
                        user.setUsername(rs.getString("username"));
                        user.setPassword(dbPassword); // 그대로 세팅(실제로는 암호화)
                        user.setEmail(rs.getString("email"));
                        return user;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // 로그인 실패
    }

    /**
     * 회원 정보 조회
     * @param id 조회할 유저의 PK
     * @return 유저 정보 (없으면 null)
     */
    public User findUserById(int id) {
        String sql = "SELECT id, username, password, email FROM users WHERE id = ?";

        try (Connection conn = ConnectionContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setEmail(rs.getString("email"));
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 회원 정보 수정 (예: 비밀번호, 이메일 변경)
     * @param user 수정된 정보를 담은 User 객체
     * @return 수정 성공 여부
     */
    public boolean updateUser(User user) {
        String sql = "UPDATE users SET password = ?, email = ? WHERE id = ?";

        try (Connection conn = ConnectionContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, user.getPassword());
            pstmt.setString(2, user.getEmail());
            pstmt.setInt(3, user.getId());

            int affectedRows = pstmt.executeUpdate();
            return (affectedRows > 0);
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 회원 삭제(탈퇴)
     * @param userId 탈퇴할 유저 ID
     * @return 삭제 성공 여부
     */
    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM users WHERE id = ?";

        try (Connection conn = ConnectionContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            int affectedRows = pstmt.executeUpdate();
            return (affectedRows > 0);
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
