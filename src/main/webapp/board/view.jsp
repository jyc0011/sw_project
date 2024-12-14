<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="sw_project.model.Board" %>
<%@ page import="sw_project.service.BoardService" %>
<%@ page import="sw_project.model.Comment" %>
<%@ page import="sw_project.service.CommentService" %>
<%@ page import="sw_project.service.LikeService" %>
<%@ page import="sw_project.model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/fragment/header.jsp" %> <!-- 헤더 포함 -->

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 보기</title>
    <style>
        /* 기존 스타일 유지 */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .view-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .view-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .view-group {
            margin-bottom: 15px;
        }
        .view-group label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }
        .view-group p {
            padding: 10px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .view-buttons {
            text-align: center;
            margin-top: 20px;
        }
        .view-buttons button {
            margin: 0 10px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            cursor: pointer;
        }
        .view-buttons button:hover {
            background-color: #0056b3;
        }
        .view-buttons .delete-button {
            background-color: #dc3545;
        }
        .view-buttons .delete-button:hover {
            background-color: #c82333;
        }

        /* 댓글 관련 스타일 */
        .reply-container {
            margin-top: 40px;
        }
        .reply-container h3 {
            margin-bottom: 15px;
        }
        .reply-item {
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
        }
        .reply-item p {
            margin: 5px 0;
        }
        .form-container {
            margin-top: 20px;
        }
        .form-group {
            margin-bottom: 10px;
        }
        .form-group textarea {
            width: 100%;
            height: 80px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            resize: vertical;
        }
        .form-group input[type="text"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .form-buttons button {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .form-buttons button[type="submit"] {
            background-color: #28a745;
            color: white;
        }
        .form-buttons button[type="submit"]:hover {
            background-color: #218838;
        }
        .form-buttons .cancel-button {
            background-color: #6c757d;
            color: white;
        }
        .form-buttons .cancel-button:hover {
            background-color: #5a6268;
        }

        /* 좋아요 버튼 스타일 */
        .like-button {
            background-color: #ffc107;
            color: white;
            border: none;
            border-radius: 4px;
            padding: 8px 16px;
            cursor: pointer;
        }
        .like-button:hover {
            background-color: #e0a800;
        }
        .like-button:disabled {
            background-color: #d4af37;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
<%
    // 게시글 ID 파라미터 가져오기
    String idParam = request.getParameter("id");
    int boardId = 0;
    BoardService boardService = new BoardService();
    Board board = null;
    List<Comment> commentList = new ArrayList<>();
    CommentService commentService = new CommentService();
    LikeService likeService = new LikeService();

    // 로그인된 사용자 정보 가져오기
    User loginUser = (User) session.getAttribute("loginUser");

    // 액션 처리
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String action = request.getParameter("action");
        if ("like".equals(action)) {
            // 좋아요 처리
            if (idParam != null && !idParam.isEmpty() && loginUser != null) {
                try {
                    boardId = Integer.parseInt(idParam);
                    boolean hasLiked = likeService.isLikedByUser(boardId, loginUser.getId());
                    if (!hasLiked) {
                        Like like = new Like();
                        like.setBoardId(boardId);
                        like.setUserId(loginUser.getId());
                        boolean likeResult = likeService.addLike(like);
                        if (likeResult) {
                            response.sendRedirect("view.jsp?id=" + boardId);
                            return;
                        } else {
                            out.println("<p style='color:red;'>좋아요를 추가할 수 없습니다.</p>");
                        }
                    } else {
                        out.println("<p style='color:red;'>이미 좋아요를 누르셨습니다.</p>");
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    out.println("<p style='color:red;'>잘못된 게시글 ID입니다.</p>");
                }
            } else {
                out.println("<p style='color:red;'>좋아요를 누를 수 없습니다.</p>");
            }
        } else if ("deletePost".equals(action)) {
            // 게시글 삭제 처리
            if (idParam != null && !idParam.isEmpty() && loginUser != null) {
                try {
                    boardId = Integer.parseInt(idParam);
                    boolean deleteResult = boardService.deleteBoard(boardId, loginUser.getId());
                    if (deleteResult) {
                        out.println("<script>alert('게시글이 성공적으로 삭제되었습니다.'); window.location.href='board.jsp';</script>");
                        return;
                    } else {
                        out.println("<p style='color:red;'>게시글 삭제에 실패했습니다. 삭제 권한이 있는지 확인해주세요.</p>");
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    out.println("<p style='color:red;'>잘못된 게시글 ID입니다.</p>");
                }
            } else {
                out.println("<p style='color:red;'>게시글을 삭제할 수 없습니다.</p>");
            }
        } else if ("addComment".equals(action)) {
            // 댓글 추가 처리
            String content = request.getParameter("content");
            String boardIdParamPost = request.getParameter("boardId");
            int pid = 0; // 기본 댓글은 pid = 0
            try {
                boardId = Integer.parseInt(boardIdParamPost);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                out.println("<p style='color:red;'>잘못된 게시글 ID입니다.</p>");
            }

            if (content != null && !content.trim().isEmpty() && loginUser != null) {
                Comment comment = new Comment();
                comment.setBoardId(boardId);
                comment.setUserId(loginUser.getId());
                comment.setContent(content);
                comment.setPid(pid); // 대댓글 기능을 구현하려면 pid를 동적으로 설정

                boolean createResult = commentService.createComment(comment);
                if (createResult) {
                    // 댓글 작성 성공 시 페이지 리다이렉트 (새로고침 방지)
                    response.sendRedirect("view.jsp?id=" + boardId);
                    return;
                } else {
                    out.println("<p style='color:red;'>댓글 작성에 실패했습니다. 다시 시도해주세요.</p>");
                }
            } else {
                out.println("<p style='color:red;'>댓글 내용을 입력해주세요.</p>");
            }
        } else if ("deleteComment".equals(action)) {
            // 댓글 삭제 처리
            String commentIdParam = request.getParameter("commentId");
            String boardIdParamPost = request.getParameter("boardId");
            int commentId = 0;
            try {
                commentId = Integer.parseInt(commentIdParam);
                boardId = Integer.parseInt(boardIdParamPost);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                out.println("<p style='color:red;'>잘못된 댓글 ID입니다.</p>");
            }

            if (loginUser != null) {
                boolean deleteResult = commentService.deleteComment(commentId, loginUser.getId());
                if (deleteResult) {
                    // 댓글 삭제 성공 시 페이지 리다이렉트
                    response.sendRedirect("view.jsp?id=" + boardId);
                    return;
                } else {
                    out.println("<p style='color:red;'>댓글 삭제에 실패했습니다.</p>");
                }
            } else {
                out.println("<p style='color:red;'>로그인이 필요한 기능입니다.</p>");
            }
        }
    }

    // 게시글 조회 및 데이터 설정
    if (idParam != null && !idParam.isEmpty()) {
        try {
            boardId = Integer.parseInt(idParam);
            board = boardService.getBoardById(boardId);

            if (board != null) {
                // 조회수 증가
                boolean viewCountUpdated = boardService.incrementViewCount(boardId);
                if (viewCountUpdated) {
                    board.setViewCount(board.getViewCount() + 1); // 클라이언트에 표시할 조회수 업데이트
                }

                // 댓글 목록 조회
                commentList = commentService.getCommentsByBoardId(boardId);
                request.setAttribute("commentList", commentList);

                // 좋아요 수 조회
                int likeCount = likeService.getLikeCount(boardId);
                request.setAttribute("likeCount", likeCount);

                // 사용자가 이미 좋아요를 눌렀는지 확인
                boolean userHasLiked = false;
                if (loginUser != null) {
                    userHasLiked = likeService.isLikedByUser(boardId, loginUser.getId());
                }
                request.setAttribute("userHasLiked", userHasLiked);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            out.println("<p style='color:red;'>잘못된 게시글 ID입니다.</p>");
        }
    } else {
        out.println("<p style='color:red;'>게시글 ID가 전달되지 않았습니다.</p>");
    }
%>

<div class="view-container">
    <h2>게시글 상세 정보</h2>
    <%
        if (board != null) {
    %>
    <!-- 제목 -->
    <div class="view-group">
        <label for="title">제목</label>
        <p id="title"><%= board.getTitle() %></p>
    </div>
    <!-- 작성자 -->
    <div class="view-group">
        <label for="author">작성자</label>
        <p id="author"><%= board.getUsername() %></p>
    </div>
    <!-- 작성일 -->
    <div class="view-group">
        <label for="date">작성일</label>
        <p id="date"><%= board.getCreatedDate() %></p>
    </div>
    <!-- 조회수 -->
    <div class="view-group">
        <label for="viewCount">조회수</label>
        <p id="viewCount"><%= board.getViewCount() %></p>
    </div>
    <!-- 좋아요 -->
    <div class="view-group">
        <label for="likeCount">좋아요</label>
        <p id="likeCount"><%= request.getAttribute("likeCount") != null ? request.getAttribute("likeCount") : 0 %></p>
        <c:choose>
            <c:when test="${userHasLiked}">
                <button type="button" class="like-button" disabled>좋아요</button>
            </c:when>
            <c:otherwise>
                <form action="view.jsp?id=<%= board.getId() %>" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="like" />
                    <button type="submit" class="like-button">좋아요</button>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
    <!-- 내용 -->
    <div class="view-group">
        <label for="content">내용</label>
        <p id="content"><%= board.getContent().replaceAll("\n", "<br>") %></p>
    </div>
    <!-- 버튼 -->
    <div class="view-buttons">
        <button onclick="window.location.href='edit.jsp?id=<%= board.getId() %>'">수정</button>
        <form action="view.jsp?id=<%= board.getId() %>" method="post" style="display:inline;">
            <input type="hidden" name="action" value="deletePost" />
            <button class="delete-button" type="submit" onclick="return confirm('정말로 이 게시글을 삭제하시겠습니까?');">삭제</button>
        </form>
        <button onclick="window.location.href='board.jsp'">목록으로</button>
    </div>

    <!-- 댓글 보기 포함 -->
    <div class="reply-container">
        <h3>댓글 목록</h3>
        <div class="reply-list">
            <c:forEach var="comment" items="${commentList}">
                <div class="reply-item">
                    <p><strong><c:out value="${comment.author}" /></strong></p>
                    <p><c:out value="${comment.content}" escapeXml="false" /></p>
                    <small><c:out value="${comment.createdDate}" /></small>
                    <br>
                    <!-- 댓글 삭제 버튼 (작성자만 삭제 가능) -->
                    <c:if test="${sessionScope.loginUser != null && sessionScope.loginUser.id == comment.userId}">
                        <form action="view.jsp?id=${comment.boardId}" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="deleteComment" />
                            <input type="hidden" name="commentId" value="${comment.id}" />
                            <input type="hidden" name="boardId" value="${comment.boardId}" />
                            <button type="submit" class="delete-button" onclick="return confirm('댓글을 삭제하시겠습니까?');">삭제</button>
                        </form>
                    </c:if>
                </div>
            </c:forEach>
            <c:if test="${empty commentList}">
                <p>댓글이 없습니다.</p>
            </c:if>
        </div>
    </div>

    <!-- 댓글 작성 폼 -->
    <div class="form-container">
        <h3>댓글 작성</h3>
        <form action="view.jsp?id=<%= board.getId() %>" method="post" name="commentForm" onsubmit="return validateCommentForm()">
            <input type="hidden" name="action" value="addComment" />
            <!-- 댓글 내용 입력 -->
            <div class="form-group">
                <textarea name="content" placeholder="댓글을 입력하세요" required></textarea>
            </div>
            <!-- 작성자 표시 (로그인 사용자) -->
            <div class="form-group">
                <label for="author">작성자</label>
                <input type="text" id="author" name="author" value="<%= loginUser != null ? loginUser.getUsername() : "익명" %>" readonly>
            </div>
            <!-- 게시글 ID (숨겨진 필드) -->
            <input type="hidden" name="boardId" value="<%= board != null ? board.getId() : 0 %>">
            <!-- 부모 댓글 ID (대댓글용, 기본값은 0) -->
            <input type="hidden" name="pid" value="0">
            <!-- 버튼 -->
            <div class="form-buttons">
                <button type="submit">댓글 등록</button>
                <button type="button" class="cancel-button" onclick="window.location.href='view.jsp?id=<%= board != null ? board.getId() : 0 %>'">취소</button>
            </div>
        </form>
    </div>
    <%
    } else {
    %>
    <p style="color:red;">해당 게시글을 찾을 수 없습니다.</p>
    <%
        }
    %>
</div>

<script>
    function validateCommentForm() {
        var form = document.commentForm;

        // 댓글 내용 확인
        if (form.content.value.trim() === "") {
            alert("댓글 내용을 입력해주세요.");
            form.content.focus();
            return false;
        }

        return true;
    }
</script>
</body>
</html>
<%@ include file="/fragment/footer.jsp" %> <!-- 푸터 포함 -->
