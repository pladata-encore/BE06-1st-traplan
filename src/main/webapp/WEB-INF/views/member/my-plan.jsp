<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ include file="../header.jsp" %>

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

                    .con22 input {
                        /*border-radius: 5px;*/
                        width: 70%;
                        margin: 5px 0 5px 20px;
                        cursor: pointer;
                        /*border: 1px solid rgb(238, 238, 238);*/
                        border: none;
                        text-align: center;
                        align-content: center;
                    }

                    td {
                        text-align: center;
                    }

                    .searchOption {
                        width: 100px;
                        border: 2px solid lightgray;
                        border-radius: 5px;
                    }

                    .manage_box a {
                        margin-bottom: 20px;
                        text-decoration: none;
                        color: black;
                    }

                    .bottom-section {
                        margin: 0 auto;
                    }

                    /* 페이지 버튼 스타일 */
                    .bottom-section {
                        padding: 10px;
                        padding-bottom: 20px;
                    }

                    .pagination {
                        display: flex;
                        justify-content: center;
                        list-style: none;
                        padding: 0;
                        margin: 0;
                    }

                    .page-item {
                        margin: 0 5px;
                    }

                    .page-link {
                        display: block;
                        padding: 10px 15px;
                        border: 1px solid #ddd;
                        border-radius: 5px;
                        text-decoration: none;
                        color: black;
                        transition: background-color 0.2s;
                        border: none;
                    }

                    .page-link:hover {
                        background-color: #f0f0f0;
                        /* 마우스 오버 시 배경색 변화 */
                    }

                </style>


            </head>

            <body>

                <%@ include file="../header.jsp" %>

                    <div class="container">
                        <h1 id="mypage_h1">나의 여행</h1>
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
                                    <img src="/display/${login.profile}" alt="프사"
                                      style="width: 250px; border-radius: 50%; margin-bottom: 50px; margin-top: 30px"
                                                class="rounded-pill"
                                         />
                                  </c:otherwise>
                                </c:choose>
                                <div class="manage_box">
                                    <a href="/my-page/pwChange">계정관리</a><a
                                        href="/my-page/mytravelboard/${login.nickName}">내
                                        게시물</a><a style="font-weight: bold" href="/my-page/mytravel/${login.id}">나의
                                        여행</a>
                                    <a href="/my-page/${login.id}">여행일정</a><a href="/my-page/favorite/${login.id}">좋아요한
                                        게시물</a>
                                </div>
                            </div>
                            <div class="mypage_section2">
                                <div class="con22">
                                    <select name="saerchOption" class="searchOption">
                                        <option value="pastOrder">과거순</option>
                                        <option value="up-to-date-order">최신순</option>
                                    </select>
                                    <table>
                                        <tr>
                                            <th style="width: 5%;"><span>번호</span></th>
                                            <th style="width: 50%;"><span>게시글 제목</span></th>
                                            <th style="width: 25%;"><span>여행일</span></th>
                                            <th style="width: 10%;"><span>공유여부</span></th>
                                        </tr>
                                        <c:forEach var="travels" items="${list}">
                                            <tr>
                                                <td><span>${travels.id}</span></td>

                                                <%-- <td><input type="text" name="con_text" --%>
                                                    <%-- value="${travels.title}" --%>
                                                        <%-- href='my-page/board-info/${travels.id}' --%>
                                                            <%-- readonly></td>--%>
                                                                <td> <a href="/my-page/board-info/${travels.id}"
                                                                        style="text-decoration: none; color: black">${travels.title}</a>
                                                                </td>
                                                                <td>
                                                                    <span>${travels.startDate} ~
                                                                        ${travels.endDate}</span>
                                                                <td>
                                                                    <input type="hidden" value="${travels.share}"
                                                                        id="shareValue">
                                                                    <c:choose>
                                                                        <c:when test="${travels.share == 'true'}">
                                                                            <input type="checkbox" id="shareIs" checked
                                                                                onchange="shareChange(${travels.id})">
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <input type="checkbox" id="shareIs"
                                                                                onchange="shareChange(${travels.id})">
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                <td>
                                                                    <img style="width: 20px"
                                                                        src="/assets/img/delete.png"
                                                                        onclick="deleteBoard(${travels.id}, ${login.id})">
                                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </table>


                                    <!-- 게시글 목록 하단 영역 -->
                                    <div class="bottom-section">
                                        <!-- 페이지 버튼 영역 -->
                                        <nav aria-label="Page navigation example">
                                            <ul class="pagination pagination-lg pagination-custom">
                                                <c:if test="${maker.prev}">
                                                    <li class="page-item">
                                                        <a class="page-link"
                                                            href="/my-page/mytravel/${login.id}?pageNo=${maker.begin-1}&amount=${s.amount}">&lt;&lt;</a>
                                                    </li>
                                                </c:if>

                                                <!-- step은 기본값이 1, 생략 가능 -->
                                                <c:forEach var="i" begin="${maker.begin}" end="${maker.end}">
                                                    <li data-page-num="${i}" class="page-item">
                                                        <a class="page-link"
                                                            href="/my-page/mytravel/${login.id}?pageNo=${i}&amount=${s.amount}">${i}</a>
                                                    </li>
                                                </c:forEach>


                                                <c:if test="${maker.next}">
                                                    <li class="page-item">
                                                        <a class="page-link"
                                                            href="/my-page/mytravel/${login.id}?pageNo=${maker.end + 1}&amount=${s.amount}">&gt;&gt;</a>
                                                    </li>
                                                </c:if>
                                            </ul>
                                        </nav>
                                    </div>



                                </div>
                            </div>
                        </div>
                    </div>

                    <script>

                        let msg = '${msg}';
                        if (msg !== '') {
                            alert(msg);
                        }

                        function shareChange(id) {
                            const url = 'http://localhost:8181/my-page/shareIs/' + id;

                            fetch(url, {
                                method: "POST",
                            })
                                .then(res => {
                                    if (res.status === 200) {
                                        alert('공유 여부가 변경됨!');
                                    } else {
                                        alert('공유 변경 과정에서 문제가 발생!');
                                    }
                                });

                        };

                        function deleteBoard(id, memberId) {
                            const url = 'http://localhost:8181/my-page/delete/' + id + "/" + memberId;
                            if (confirm("정말 삭제하시겠습니까?")) {


                                fetch(url, {
                                    method: "POST",
                                })
                                    .then(res => {
                                        if (res.status === 200) {
                                            alert("여행이 삭제됨")
                                            location.reload(true);
                                        } else {
                                            alert("삭제 과정에서 문제발생")
                                        }
                                    })
                            } else {
                                return false;
                            }


                        }

                    </script>
            </body>

            </html>