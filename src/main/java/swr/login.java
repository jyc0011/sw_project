package swr;

import java.sql.*;

public class login {

    public static String login(String userId, String password) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String resultMessage = "";

        try {
            // 데이터베이스 연결 설정
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jspbookdb", "root", "0000");

            // 회원 정보 확인
            String query = "SELECT passwd, success, fail FROM register WHERE id = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("passwd");
                int successCount = rs.getInt("success");
                int failCount = rs.getInt("fail");

                if (storedPassword.equals(password)) {
                    // 비밀번호 일치 - 로그인 성공
                    successCount++;
                    resultMessage = "로그인 성공!";
                    
                    // 로그인 성공 횟수 업데이트
                    String updateSuccess = "UPDATE register SET success = ? WHERE id = ?";
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateSuccess)) {
                        updateStmt.setInt(1, successCount);
                        updateStmt.setString(2, userId);
                        updateStmt.executeUpdate();
                    }

                    // student 테이블에서 사용자 정보 불러오기
                    String studentQuery = "SELECT name, age, major FROM student WHERE id = ?";
                    try (PreparedStatement studentStmt = conn.prepareStatement(studentQuery)) {
                        studentStmt.setString(1, userId);
                        ResultSet studentRs = studentStmt.executeQuery();
                        if (studentRs.next()) {
                            String name = studentRs.getString("name");
                            int age = studentRs.getInt("age");
                            String major = studentRs.getString("major");
                            resultMessage += "\n이름: " + name + ", 나이: " + age + ", 전공: " + major;
                        }
                    }
                } else {
                    // 비밀번호 불일치 - 로그인 실패
                    failCount++;
                    resultMessage = "로그인 실패!";

                    // 로그인 실패 횟수 업데이트
                    String updateFail = "UPDATE register SET fail = ? WHERE id = ?";
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateFail)) {
                        updateStmt.setInt(1, failCount);
                        updateStmt.setString(2, userId);
                        updateStmt.executeUpdate();
                    }
                }
            } else {
                resultMessage = "해당 ID가 존재하지 않습니다.";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            resultMessage = "데이터베이스 오류가 발생했습니다.";
        } finally {
            // 리소스 해제
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return resultMessage;
    }
}
