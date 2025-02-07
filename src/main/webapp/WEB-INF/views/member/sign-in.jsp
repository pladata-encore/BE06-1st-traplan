<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <title>Sign-in</title>
    <style>
        body {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .logo {
            width: 25%;
        }

        form {
            display: flex;
            align-items: center;
        }

        .form-text {
            height: 40%;
            display: flex;
            flex-direction: column;
        }

        .sns-logo a {
            display: block;
        }

        .login-btn {
            width: 60px;
        }

        .sns-logo {
            width: 140px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .form-text input {
            width: 340px;
            height: 35px;
            margin-bottom: 5px;
            margin-right: 15px;
            border: solid 1px #e8e8e8;
            border-radius: 5px;

        }

        #login-btn {
            height: 60px;
            width: 70px;
            background-color: white;
            border: solid 2px #e8e8e8;
            border-radius: 10px;
            box-shadow: none;
            cursor: pointer;
            ;
        }

        .sign-up-btn {
            display: flex;
            width: 225px;
            justify-content: space-between;
            margin-top: 20px;
            margin-bottom: 20px;
        }

        .sign-up-btn a {
            display: block;
            text-decoration: none;
            background-color: #e8e8e8;
            color: black;

            border: solid 1px gray;
            border-radius: 10px;
            padding: 10px;

        }
    </style>

    <head>

    <body>

        <img id="logo" src="/assets/img/sign-in-logo.png" alt="업다">
        <h1>
            즐거운 여행의 시작,<br> 트래플랜
        </h1>
        <form action="/members/sign-in" method="post" name="sign-in">
            <div class="form-text">
                <input type="email" placeholder="이메일을 입력하세요" name="email">
                <input type="password" placeholder="비밀번호를 입력하세요" name="password">
            </div>
            <button id="login-btn">로그인</button>
        </form>
        <div class="sign-up-btn">
            <a href="/members/sign-up">회원 가입</a>
            <a href="/members/pw-change">비밀번호 변경</a>
        </div>
        <div class="sns-logo">
            <a href="../kakao/login">
                <img src="/assets/img/kakao_login_small.png" class="login-btn" alt="kakaoBtn">
            </a>
            <a href="../naver/login">
                <img src="/assets/img/naver_login_small.png" class="login-btn" alt="naverBtn">

            </a>
        </div>
        <script>
            const serverResult = '${result}';
            if (serverResult === 'NO_ACC') {
                alert("회원가입을 먼저 진행해 주세요!")
            } else if (serverResult === 'NO_PW') {
                alert('비밀번호가 틀렸어요!')
            }
        </script>
    </body>
    </head>