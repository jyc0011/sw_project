package sw_project.model;

import java.util.Date;
import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Board {
    private int id;             // 게시글 ID
    private String title;       // 게시글 제목
    private String content;     // 게시글 내용
    private int userId;         // 작성자 ID
    private Date createdDate;   // 작성일
}