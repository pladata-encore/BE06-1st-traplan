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

                    .manage_box a {
                        margin-bottom: 20px;
                        text-decoration: none;
                        color: black;
                    }

                    .info-box {
                        border: 1px solid lightgray;
                        border-radius: 5px;
                        height: 700px;
                        text-align: center;
                        margin: 0 auto;
                    }

                    .info-box input {
                        width: 70%;
                        height: 30px;
                        font-size: 20px;
                        border-radius: 10px;
                        text-align: center;
                        align-content: center;
                        margin-bottom: 25px;
                        border: 1px solid lightgray;
                    }

                    .modiBtn {
                        border: 1px solid lightgray;
                        background-color: white;
                        height: 50px;
                        width: 200px;
                    }

                    .nickNameChk {
                        width: 10%;
                    }

                    #newNickName {
                        width: 60%;
                    }
                </style>


            </head>

            <body>
                <%@ include file="../header.jsp" %>

                    <div class="container">
                        <h1 id="mypage_h1">계정관리</h1>
                        <div class="mypage_section">
                            <div class="mypage_section1">
                                <c:if test="${login.profile == null}">
                                    <img src="/assets/img/anonymous.jpg" alt="프사"
                                        style="width: 250px; border-radius: 50%; margin-bottom: 50px; margin-top: 30px"
                                        class="rounded-pill" class="rounded-pill" />
                                </c:if>
                                <c:if test="${login != null && login.profile != null}">
                                    <img src="/display/${login.profile}" alt="프사"
                                        style="width: 250px; border-radius: 50%; margin-bottom: 50px; margin-top: 30px"
                                        class="rounded-pill" />
                                </c:if>
                                <div class="manage_box">
                                    <a style="font-weight: bold" href="/my-page/pwChange">계정관리</a><a
                                        href="/my-page/mytravelboard/${login.nickName}">내 게시물</a><a
                                        href="/my-page/mytravel/${login.id}">나의 여행</a>
                                    <a href="/my-page/${login.id}">여행일정</a><a href="/my-page/favorite/${login.id}">좋아요한
                                        게시물</a>
                                </div>
                            </div>
                            <div class="mypage_section2">
                                <div class="con22">
                                    <div class="info-box">
                                        <c:if test="${login != null && login.profile != null}">
                                            <img src="/display/${login.profile}" alt="프사"
                                                style="width: 250px; border-radius: 50%; margin-bottom: 50px; margin-top: 30px"
                                                class="rounded-pill" />
                                        </c:if>
                                        <input type="email" value="${login.email}" readonly
                                            style="border: none; outline: none">
                                        <input id="newPw" placeholder="새 비밀번호" type="password">
                                        <input id="pwChk" placeholder="비밀번호 확인" type="password">
                                        <div style="text-align: center">
                                            <input id="newNickName" placeholder="새 닉네임" type="text">
                                            <button class="nickNameChk" onclick="checkNick(${login.id})">중복체크</button>
                                        </div>

                                        <div>
                                            <button class="modiBtn" onclick="modifyInfo(${login.id})">회원정보 수정</button>
                                        </div>


                                    </div>
                                </div>


                            </div>
                        </div>
                    </div>

                    <script>
                        const newPw = document.getElementById("newPw");
                        const pwChk = document.getElementById("pwChk");
                        let newNick = document.getElementById("newNickName");



                        function modifyInfo(id) {
                            url = "http://localhost:8181/my-page/changeConfirm"

                            if (newNick.value === "") {
                                newNick.value = '${login.nickName}';
                            }

                            console.log(newPw.value)
                            console.log(pwChk.value)

                            if (newPw.value !== pwChk.value) {
                                alert("비밀번호가 같지 않습니다.")
                                newPw.value = "";
                                pwChk.value = "";
                                newNick.value = "";
                                return
                            }

                            const modiInfo = {
                                id: id,
                                newPw: newPw.value,
                                newNick: newNick.value,
                            };


                            fetch(url, {
                                method: "POST",
                                headers: {
                                    "content-Type": "application/json",
                                },
                                body: JSON.stringify(modiInfo)
                            })
                                .then(res => {
                                    if (res.status === 200) {
                                        alert("회원정보 수정 완료")
                                        newNick.value = "";
                                        pwChk.value = "";
                                        newNick.value = "";
                                    } else {
                                        alert("정보 수정중 문제 발생")
                                    }
                                })

                        }

                        function checkNick(id) {

                            if (newNick.value === "") {
                                newNick.value = ${ login.nickName }
                            }


                            url = "http://localhost:8181/my-page/nickNameChk/" + newNick.value;

                            fetch(url, {
                                method: "POST",
                            })

                                .then(res => {
                                    console.log(res.body)
                                    console.log(res.status)
                                    if (res.status === 200) {
                                        alert("사용가능한 닉네임입니다.")
                                    } else {
                                        alert("중복된 닉네임 입니다.")
                                    }
                                })

                        }

                    </script>
            </body>

            </html>