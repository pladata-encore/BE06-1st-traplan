<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <script src="https://kit.fontawesome.com/7dcd39bc6e.js" crossorigin="anonymous"></script>

    <style>
        button {
            background: none;
            border: none;
            width: auto;
            height: auto;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
        }

        .container {
            width: 90%;
            max-width: 980px;
            padding: 40px 80px;
            background-color: #ffffff;
            border: 1px solid #ddd;
            border-radius: 1%;
        }

        h1 {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 12px;
        }

        .author-date {
            font-size: 14px;
            color: #606060;
            margin-bottom: 20px;
        }

        .heart {
            float: right;
            color: #606060;
        }

        .section {
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 20px;
            color: #333;
            margin-bottom: 16px;
            border-radius: 4px;
        }

        .section img {
            style: none;
        }

        #content,
        #schedule {
            background-color: white;
            justify-content: flex-start;
            align-items: flex-start;
        }

        #schedule {
            height: 30px;
        }

        .day-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 12px;
        }

        .day-date {
            font-size: 14px;
            color: #888;
            margin-left: 8px;
        }

        #like-button {
            background-color: none;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        #like-count {
            color: #333;
        }

        #like-icon {
            color: #333;
            /* 기본 색상 */
            transition: color 0.3s;
        }

        #like-icon.liked {
            color: #ff006a;
            /* 좋아요 클릭 후 색상 */
        }

        .map-top {
            width: 700px;
            margin-left: 60px;
            margin-bottom: 20px;
        }
    </style>
</head>

<body>

<div class="container">
    <h1>${tOne.title}</h1>
    <p class="author-date">${tOne.writer} ${tOne.writeDate}
        <span class="heart">
                        <button id="like-button" onclick="toggleLike(${tOne.boardId})">
                            <i id="like-icon" class="${likeFlag ? 'fa-solid fa-heart liked' : 'fa-solid fa-heart'}"></i>
                            <span id="like-count">${tOne.likeCount}</span>
                        </button>
                    </span>
    </p>
    <div class="section photo"><img src="/display/${tOne.img}" style="width: 700px; height: 500px" ></div>
    <div class="section text" id="content">${tOne.content}</div>

    <c:if test="${not empty journey}">

        <c:choose>

            <c:when test="${journey.size() == 1}">
                <c:set var="place" value="place_id:${journey[0].locationPin}" />
                <iframe allowfullscreen="" class="map-top" height="450"
                        src="https://www.google.com/maps/embed/v1/place?key=AIzaSyBY7CGNgsIdVaut54UGlivQkiCYAyoS19I&q=${place}">
                    width="598"></iframe>
            </c:when>

            <c:otherwise>
                <c:set var="origin" value="place_id:${journey[0].locationPin}" />
                <c:set var="destination" value="place_id:${journey[journey.size() - 1].locationPin}" />

                <c:set var="waypoints" value="" />
                <c:forEach var="j" items="${journey}" varStatus="status">
                    <c:if test="${!status.first && !status.last}">
                        <c:set var="waypoints" value="${waypoints}${status.index > 1 ? '|' : ''}place_id:${j.locationPin}" />
                    </c:if>
                </c:forEach>

                <c:set var="mapUrl" value="https://www.google.com/maps/embed/v1/directions?key=AIzaSyBY7CGNgsIdVaut54UGlivQkiCYAyoS19I&origin=${origin}&destination=${destination}" />
                <c:if test="${not empty waypoints}">
                    <c:set var="mapUrl" value="${mapUrl}&waypoints=${waypoints}" />
                </c:if>

                <iframe allowfullscreen="" class="map-top" height="450" src="${mapUrl}" width="598"></iframe>
            </c:otherwise>
        </c:choose>
    </c:if>


    <c:forEach var="j" items="${journey}">
        <div class="section photo"><img src="/display/${j.journeyImg}" style=""></div>
        <h2 class="day-date">${j.journeyStartTime}</h2>
        <div class="section schedule" id="schedule">${j.placeName} ${j.journeyName}</div>
    </c:forEach>
</div>

<script>
    function toggleLike(travelBoardId) {
        if ('${login}' == null) {
            alert('로그인 하지 않은 사용자는 좋아요를 할 수 없습니다.');
            return;
        }

        const url = 'http://localhost:8181/travelboard/' + travelBoardId + '/toggle-like';
        console.log(travelBoardId);
        fetch(url, {
            method: "POST"
        })
            .then(response => response.text())  // 응답을 텍스트로 받아
            .then(data => {
                document.getElementById("like-count").innerText = data; // 정수를 그대로 표시

                // 아이콘 색상 토글
                const likeIcon = document.getElementById("like-icon");
                likeIcon.classList.toggle("liked"); // liked 클래스 추가/제거
            })
            .catch(error => console.error("Error:", error));
    }

</script>
</body>

</html>