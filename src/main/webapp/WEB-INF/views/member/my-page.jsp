<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html>

        <head>
            <title>Title</title>
            <style>
                .container {
                    height: 100%;
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    justify-content: center;
                    margin-top: 50px;
                }

                .mypage_section {
                    display: flex;
                    justify-content: center;
                }

                .mypage_section1 {
                    display: inline-block;
                    margin-right: 50px;
                    text-align: center;
                    border: 1px solid rgb(238, 238, 238);
                    border-radius: 5px;
                    margin-bottom: 50px;
                    height: 700px;
                }

                .img_box {
                    height: 50%;
                    width: 50%;
                    background-color: blue;
                }

                .manage_box {
                    width: 500px;
                    display: flex;
                    flex-direction: column;
                }

                .cal {
                    width: 700px;
                }

                #mypage_h1 {
                    margin-bottom: 100px;
                }

                .profile_img {
                    width: 200px;
                    height: 200px;
                }

                .mypage_section2 {
                    width: 800px;
                }

                .manage_box a {
                    margin-bottom: 20px;
                    text-decoration: none;
                    color: black;
                }
                .profile-img {
                    width: 30px;
                }
            </style>
        </head>

        <body>
            <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>


            <%@ include file="../header.jsp" %>


                <div class="container">
                    <div class="mypage_section">
                        <div class="mypage_section1">
                           <c:choose>
                              <c:when test="${login.profile == null}">
                                <img src="/assets/img/anonymous.jpg" alt="프사" class="profile-img"/>
                              </c:when>
                              <c:when test="${login.profile != null && login.loginMethod == 'KAKAO'}">
                                <img src="${login.profile}" alt="프사" class="profile-img" />
                              </c:when>
                              <c:otherwise>
                                <img src="/display/${login.profile}" alt="프사"      style="width: 250px; border-radius: 50%; margin-bottom: 50px; margin-top: 30px"
                                                class="rounded-pill" />
                              </c:otherwise>
                            </c:choose>
                            <div class="manage_box">
                                <a href="/my-page/pwChange">계정관리</a><a href="/my-page/mytravelboard/${login.nickName}">내
                                    게시물</a><a href="/my-page/mytravel/${login.id}">나의 여행</a>
                                <a style="font-weight: bold" href="/my-page/${login.id}">여행일정</a><a
                                    href="/my-page/favorite/${login.id}">좋아요한 게시물</a>
                            </div>
                        </div>
                        <div class="mypage_section2">
                            <div id="calendar"></div>
                        </div>
                    </div>
                </div>



                <script>

                    document.addEventListener('DOMContentLoaded', function () {
                        var calendarEl = document.getElementById('calendar');

        var calendar = new FullCalendar.Calendar(calendarEl, {
                            initialView: 'dayGridMonth',
                            locale: 'ko',
                            events: [
                                <c:forEach var="dto" items="${dtoList}">
                                    {
                                        title: "${dto.title}",
                                    start: "${dto.startDate}",
                                    end : "${dto.endDate}"
                },
                                </c:forEach>
                            ]

                        });
                        calendar.render();
                    });


                </script>
        </body>

        </html>