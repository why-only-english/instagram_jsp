<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.peoplelink.post.PostDAO" %>
<%@ page import="com.example.peoplelink.post.Post" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PeopleLink</title>
    <link rel="stylesheet" href="./css/main.css">
</head>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        var moreBtns = document.querySelectorAll(".more-btn");
        // 더보기 기능 JS
        moreBtns.forEach(function (btn) {
            btn.addEventListener("click", function () {
                var moreOptions = this.closest(".post-container").querySelector(".more-options");
                moreOptions.style.display = moreOptions.style.display === "none" ? "flex" : "none";
            });
        });
    });
</script>
<body>
<div style="display: flex;">
    <%
        String userID = (String) session.getAttribute("userID");
        int pageNumber = 1;
        if (request.getParameter("pageNumber") != null) {
            pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        }

        PostDAO postDAO = new PostDAO();
        ArrayList<Post> list = postDAO.getList(pageNumber);
        request.setAttribute("posts", list);
    %>
    <%@ include file="navbar.jsp" %>

    <div style="margin-left: 32px; width: 630px; display: flex; flex-direction: column;">
        <c:forEach items="${posts}" var="post">
            <div class="post-container">
                <img src="./png/account_box.png" alt="프로필 이미지" class="nav-icon">
                <span class="post-nickname">${post.userID}</span>
                <span>•몇시간 전</span>
                <img src="./png/more.png" alt="더보기 버튼" class="more-btn">

                <c:if test="${userID == post.userID}">
                    <div class="more-options">
                        <a href="update.jsp?postID=${post.postID}">수정</a>
                        <a onclick="return confirm('게시글을 삭제하시겠어요?')"
                           href="deleteAction.jsp?postID=${post.postID}">삭제</a>
                    </div>
                </c:if>

                <div class="post-img-box">
                    <img style="width: 468px; height: 468px;" src="upload/${post.fileName}">
                </div>
                <div class="icon-container">
                    <img src="./png/heart.png" alt="좋아요 버튼" class="nav-icon">
                    <a href="view.jsp?postID=${post.postID}">
                        <img src="./png/chat.png" alt="댓글 버튼" class="nav-icon">
                    </a>
                </div>
                <div class="contents-container">
                    <h2 class="post-title">${post.postTitle}</h2>
                    <p>${post.postContent}</p>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
