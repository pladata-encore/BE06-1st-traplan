<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <style>
        .container {
            margin-top: 150px;
            margin-bottom: 100px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        #join_h1 {
            margin-top: 100px;
            font-size: 50px;
            display: flex;
            flex-flow: row nowrap;
            margin-bottom: 20px;
        }

        #join_exp {
            font-weight: 300;
            margin-left: 220px;
            font-size: 20px;
            color: rgb(37, 49, 109);
        }

        #space_icon {
            width: 30px;
        }

        .contents {
            border: 1px solid rgb(238, 238, 238);
            width: 40%;
            margin: 40px 20% 40px 20%;
            padding: 40px 0 40px 0;
            border-radius: 5px;
        }

        #insert input[type="text"],
        input[type="number"],
        input[type="text"],
        input[type="email"],
        input[type="password"] {
            border: 1px solid rgb(238, 238, 238);
            padding: 10px;
            border-radius: 5px;
            width: 60%;
            margin-bottom: 15px;
            margin-left: 20%;
        }

        #joinbtn {
            padding: 10px;
            border: 1px solid rgb(238, 238, 238);
            border-radius: 5px;
            width: 60%;
            background-color: white;
            color: gray;
            margin-left: 20%;
            cursor: pointer;
        }


        .id_check {
            padding: 5px;
            border: 1px solid rgb(238, 238, 238);
            border-radius: 5px;
            font-size: 10px;
            margin-left: 5px;
            background-color: white;
            color: gray;
            cursor: pointer;
        }

        #profile_img {
            width: 300px;
        }
    </style>
    <html>

    <body>
        <div class="container">
            <h1 id="join_h1">비밀번호 변경</h1>
            <h2 id="join_exp"></h2>
            <img id="profile_img" src="/assets/img/basicProfile.png" alt="업따" />
            <div class="contents">
                <form id="change-pw" name="join" method="post" action="/members/pw-change">
                    <div id="insert">
                        <div>
                            <input type="email" placeholder="이메일" name="email" class="email_input" id="email-value" />
                            <input id="email" class="id_check" type="button" value="이메일인증" formaction="" />
                        </div>
                        <div>
                            <input type="number" placeholder="인증 번호를 입력해주세요" name="check-num" class="email_input"
                                id="check-num-value" />
                            <input id="check-num" class="id_check" type="button" value="확인" formaction="" />
                        </div>
                        <div>
                            <input type="password" placeholder="새 비밀번호" name="password" id="userPs" />
                        </div>
                        <div>
                            <input type="password" placeholder="비밀번호 확인" name="password_check" id="userPc" />
                        </div>

                        <br />
                        <input type="submit" value="비밀번호 변경" id="joinbtn" formaction="/members/pw-change" />
                    </div>
                    <br />
                </form>
            </div>
        </div>
        <script type="module" src="/assets/js/pw-change.js"></script>
    </body>

    </html>