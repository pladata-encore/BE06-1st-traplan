<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html lang="ko">

  <head>
    <meta charset="UTF-8" />
    <title>네이버 로그인 테스트</title>
  </head>

  <body>
    <div>
      <table style="cellpadding: 0; cellspacing: 0; margin: 0 auto; width: 100%">
        <tr>
          <td style="
              width: 100%;
              text-align: center;
              colspan: 2;
              margin-top: 24px;
              padding-top: 12px;
              border-top: 1px solid #ececec;
            ">
            <a href="/kakao/login">
              <img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" alt="kakaoBtn" />
            </a>
          </td>
        </tr>
        <tr>
          <td style="
              width: 100%;
              text-align: center;
              colspan: 2;
              margin-top: 24px;
              padding-top: 12px;
              border-top: 1px solid #ececec;
            ">
            <a href="/naver/login">
              <img src="/assets/img/btnG_완성형.png" alt="naverBtn" />
            </a>
          </td>
        </tr>
      </table>
    </div>
    <script>
      const serverResult = "${result}";
      console.log(serverResult);
      if (serverResult === "NO_ACC") {
        alert("회원가입부터 하고 오세요!");
      } else if (serverResult == "NO_PW") {
        alert("비밀번호가 틀렸습니다!");
      }
    </script>
  </body>

  </html>