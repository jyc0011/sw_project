package sw_project.model;
import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Like {
    private int id;            // 좋아요 ID
    private int boardId;       // 어떤 게시글에 대한 좋아요인지
    private int userId;        // 좋아요 누른 사용자 ID
}