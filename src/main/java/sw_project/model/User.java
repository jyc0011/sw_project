package sw_project.model;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    private int id;            // 사용자 고유 ID
    private String username;   // 사용자명
    private String password;   // 비밀번호
    private String email;      // 이메일 주소
}