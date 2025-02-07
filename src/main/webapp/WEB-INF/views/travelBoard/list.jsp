<%@ page contentType="text/html; charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Document</title>

            <script src="https://kit.fontawesome.com/7dcd39bc6e.js" crossorigin="anonymous"></script>
            <!-- <link rel="stylesheet" href="외부 스타일 시트 파일 경로"> -->

            <style>
                /* 전체 페이지 스타일 */
                body {
                    font-family: 'Arial', sans-serif;
                    margin: 0;
                    padding: 0;
                }

                /* 상단 검색창 스타일 */
                .top-section {
                    padding: 20px;
                    background-color: #fff;
                    border: none;
                    padding-bottom: 10px;
                }

                #field {
                    border: none;
                }

                form {
                    margin-right: 199px;
                }

                select {
                    border-radius: 30px;
                }

                input {
                    border-radius: 40px;
                }

                .search {
                    display: flex;
                    align-items: center;
                    flex-direction: row-reverse;
                }

                .form-select,
                .form-control {
                    height: 23px;
                    margin-right: 3px;
                }

                .form-select {
                    width: 80px;
                }

                #searching {
                    height: 23px;
                    margin-top: 5px;
                    border: none;
                    background-color: #fff;
                }

                /* 목록창 스타일 */
                main {
                    padding: 15px;
                }

                .list-container {
                    width: 1050px;
                    display: grid;
                    grid-template-columns: repeat(3, 1fr);
                    gap: 45px;
                    margin-left: auto;
                    margin-right: auto;
                }

                /* 각 게시글 카드 스타일 */
                .list-container .goPost {
                    text-decoration: none;
                    color: black;
                    border: 1px solid #ddd;
                    border-radius: 2%;
                    overflow: hidden;
                    transition: transform 0.2s;
                    height: 300px;
                }

                .list-container .goPost:hover {
                    transform: scale(1.05);
                    /* 마우스 오버 시 확대 효과 */
                }

                /* 이미지 스타일 */
                .image {
                    width: 100%;
                    height: 200px;
                    /* 고정 높이 */
                    object-fit: cover;
                    /* 이미지 비율 유지 */
                }

                /* 제목, 날짜, 작성자 스타일 */
                .list-container .goPost div {
                    padding: 6px;
                }

                .list-container .goPost h4 {
                    margin: 5px;
                    color: #373737;
                }

                .list-container .goPost p {
                    margin: 5px;
                    font-size: 0.9em;
                    color: #666;
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

                .allList {
                    margin-top: 50px;
                }
            </style>

        </head>

        <body>
            <%@ include file="../header.jsp" %>
                <div class="allList">
                    <!-- 검색창 영역 -->
                    <div class="top-section">
                        <fieldset id="field">
                            <div class="search">
                                <!-- 검색창 영역 -->
                                <form action="/travelboard/list" method="get" name="search" id="find">
                                    <select class="form-select" name="sortType" id="select-type">
                                        <option value="new">최신순</option>
                                        <option value="old">과거순</option>
                                        <option value="best">좋아요순</option>
                                    </select>
                                    <select class="form-select" name="type" id="search-type">
                                        <option value="title">제목</option>
                                        <option value="content">내용</option>
                                        <option value="writer">작성자</option>
                                        <option value="tc">제목+내용</option>
                                    </select>
                                    <input type="search" class="form-control" name="keyword" value="${s.keyword}"
                                        autocomplete="off">
                                    <button type="submit" id="searching"><i
                                            class="fa-solid fa-magnifying-glass fa-rotate-by"
                                            style="color: #000000; --fa-rotate-angle: 18deg;"></i></button>
                                </form>
                            </div>
                        </fieldset>
                    </div>

                    <!-- 목록창 영역 -->
                    <main id="list">
                        <div class="list-container">
                            <c:forEach var="tb" items="${tbList}">
                                <a class="goPost" href="/travelboard/info/${tb.boardId}" target="_blank">
                                    <img src="/display/${tb.img}" alt="여행이미지" class="image"> <br>
                                    <div>
                                        <h4>${tb.shortTitle}</h4>
                                        <p>${tb.writer}</p>
                                        <p>${tb.writeDate}</p>
                                    </div>
                                </a>
                            </c:forEach>
                        </div>
                    </main>

                    <!-- 게시글 목록 하단 영역 -->
                    <div class="bottom-section">
                        <!-- 페이지 버튼 영역 -->
                        <nav aria-label="Page navigation example">
                            <ul class="pagination pagination-lg pagination-custom">
                                <c:if test="${maker.prev}">
                                    <li class="page-item">
                                        <a class="page-link"
                                            href="/travelboard/list?pageNo=${maker.begin-1}&amount=${s.amount}&type=${s.type}&keyword=${s.keyword}">&lt;&lt;</a>
                                    </li>
                                </c:if>

                                <!-- step은 기본값이 1, 생략 가능 -->
                                <c:forEach var="i" begin="${maker.begin}" end="${maker.end}">
                                    <li data-page-num="${i}" class="page-item">
                                        <a class="page-link"
                                            href="/travelboard/list?pageNo=${i}&amount=${s.amount}&type=${s.type}&keyword=${s.keyword}">${i}</a>
                                    </li>
                                </c:forEach>


                                <c:if test="${maker.next}">
                                    <li class="page-item">
                                        <a class="page-link"
                                            href="/travelboard/list?pageNo=${maker.end + 1}&amount=${s.amount}&type=${s.type}&keyword=${s.keyword}">&gt;&gt;</a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                </div>

                <script>
                    // 검색조건 셀렉트 박스 옵션 타입 고정하기
                    function fixSearchOption() {
                        const $select = document.getElementById('search-type');

                        const $options = [...$select.children];
                        $options.forEach($opt => {
                            if ($opt.value === '${s.type}') {
                                // option 태그에 selected를 주면 그 option으로 고정됨.
                                $opt.setAttribute('selected', 'selected');
                            }
                        });
                    }

                    function fixSortOption() {
                        const $select = document.getElementById('select-type');

                        const $options = [...$select.children];
                        $options.forEach($opt => {
                            if ($opt.value === '${s.type}') {
                                // option 태그에 selected를 주면 그 option으로 고정됨.
                                $opt.setAttribute('selected', 'selected');
                            }
                        });
                    }

                    fixSearchOption();
                    fixSortOption();
                </script>

        </body>

        </html>