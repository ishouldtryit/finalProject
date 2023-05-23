<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Free Board</title>
</head>
<body>
    <h1>Free Board</h1>
    
    <table border="1">
        <thead>
            <tr>
                <th>No</th>
                <th>Title</th>
                <th>Writer</th>
                <th>Date</th>
                <th>Views</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="post" items="${freeBoardList}">
                <tr>
                    <td>${post.free_no}</td>
                    <td><a href="viewFreeBoard?freeNo=${post.free_no}">${post.free_title}</a></td>
                    <td>${post.writer}</td>
                    <td>${post.reg_date}</td>
                    <td>${post.view_count}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <h2>Create a new post</h2>
    <form action="createFreeBoard" method="post">
        <div>
            <label>Title: </label>
            <input type="text" name="free_title" required>
        </div>
        <div>
            <label>Content: </label>
            <textarea name="free_content" rows="5" required></textarea>
        </div>
        <div>
            <label>Writer: </label>
            <input type="text" name="writer" required>
        </div>
        <div>
            <input type="submit" value="Submit">
        </div>
    </form>
</body>
</html>