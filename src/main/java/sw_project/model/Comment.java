package sw_project.model;

import java.util.Date;
import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Comment {
    private int id;// 댓글 ID
    private int boardId;// 어느 게시글의 댓글인지
    private int userId;// 댓글 작성자 ID
    private String content;// 댓글 내용
    private Date createdDate;// 작성일
    private int pid; // 답글인 경우 부모의 id, 아닐 경우0
}