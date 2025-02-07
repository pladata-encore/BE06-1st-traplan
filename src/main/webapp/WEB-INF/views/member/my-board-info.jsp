
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
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
            margin-top: 50px;
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
            width: 100%;
            height: 300px;
            background-color: #d3d3d3;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 20px;
            color: #333;
            margin-bottom: 16px;
            border-radius: 4px;
        }

        #content {
            background-color: white;
            justify-content: flex-start;
            align-items: flex-start;
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
            /*background-color: none;*/
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .fa-solid {
            color: red;
        }

        #like-count {
            color: #333;
        }
        .content-box{
            text-align: center;
        }
        .button-box{
            text-align: center;
        }
        .button-box button{
            height: 50px;
            width: 100px;
            border-radius: 5px;
            border: 1px solid lightgrey;
        }
    </style>
</head>

<body>
            <%@ include file="../header.jsp" %>

<div class="container">


    <h1>${travel.title}</h1>
    <form action="/my-page/insert-board" method="post" enctype="multipart/form-data">
        <input type="hidden" value="${travel.id}" name="travelId">
        <p class="author-date"> ${travel.startDate} ~ ${travel.endDate}</p>
        <div style="text-align: center"><img src="" alt="" style="display: none" class="travelImg-box"></div>
        <div class="section photo" id="travelImage" >여행의 사진을 등록해주세요!!
            <input
                    type="file"
                    id="travelImgInput"
                    accept="image/*"
                    style="display: none"
                    name="travelImg"
            />
        </div>
        <div class="journey-wrap">
            <c:forEach var="journey" items="${journey}">
                <div>
                    <input type="hidden" value="${journey.id}" name="journeyId">
                    <h2 class="day-title">${journey.journeyName} <span class="day-date">${journey.startTime} - ${journey.endTime}</span></h2>
                    <div style="text-align: center;">
                            <img src="" alt="" style="display: none" class="journeyImg-box${journey.id}">
                    </div>
                    <div class="section photo" id="journeyImage${journey.id}" data-journey-id="${journey.id}">여정의 사진을 등록해주세요!!
                        <input
                                type="file"
                                id="journeyImgInput${journey.id}"
                                accept="image/*"
                                style="display: none"
                                name="journeyImage"
                        />
                    </div>

            </c:forEach>
      <div class="content-box">
            <textarea name="content" rows="15" cols="100"></textarea>
        </div>
        <div class="button-box">
            <button type="submit">게시글 저장</button>
        </div>

    </form>
                </div>

        </body>


        <script>
            // 프로필 사진 업로드 관련 스크립트  --->
            const $travelImage = document.getElementById("travelImage");
            const $fileInput = document.getElementById("travelImgInput");

            $travelImage.onclick = (e) => {
                $fileInput.click();
            };

            // 단순히 화면단에 썸네일 띄우는 것.
            $fileInput.onchange = (e) => {
                const fileData = $fileInput.files[0];
                console.log(fileData);
                const reader = new FileReader();
                reader.readAsDataURL(fileData);
                reader.onloadend = (e) => {
                    const $img = document.querySelector(".travelImg-box");
                    $travelImage.style.display = "none";
                    $img.style.display = "";
                    $img.setAttribute("src", reader.result);
                };
            };


            const journeyList = '${journey}';
            const $journeyWrap = document.querySelector('.journey-wrap'); // 여정들을 감싸고 있는 부모 요소

            // 사용자가 각 여정에 이미지를 등록하기 위해 div 영역을 클릭할 때 발생하는 이벤트 일괄 처리
            $journeyWrap.addEventListener('click', e => {
                if (!e.target.matches('div.section.photo')) return;

                console.log('여정 사진 이벤트 등록 이벤트 발생!');

                const $targetInput = e.target.firstElementChild; // 클릭이 된 div 내부에 있는 input
                $targetInput.click();
            });

            $journeyWrap.addEventListener('change', e => {
                if (!e.target.matches('div.section.photo > input')) return;

                console.log('이미지 업로드를 시도함!');
                console.log('input change 요소: ', e.target);

                uploadThumbnailImage(e.target);
            });


    // 각 input 영역에 썸네일 띄우는 동작을 담당하는 함수
    const uploadThumbnailImage = ($targetInput) => {
                const fileData = $targetInput.files[0];
                console.log(fileData);
                const reader = new FileReader();
                reader.readAsDataURL(fileData);
                reader.onloadend = (e) => {
                    const $parentDiv = $targetInput.parentNode;
                    const $img = $parentDiv.previousElementSibling.firstElementChild;
                    $parentDiv.style.display = "none";
                    $img.style.display = "";
                    $img.setAttribute("src", reader.result);
                };
            }





        </script>

        </html>