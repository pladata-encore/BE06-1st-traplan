<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Document</title>

      <style>
        /* 기본 스타일 */
        * {
          margin: 0;
          padding: 0;
          box-sizing: border-box;
        }

        /* 네비게이션바 스타일 */
        #navbar {
          width: 100%;
          background-color: #f8f9fa;
          position: fixed;
          top: 0;
          display: flex;
          align-items: center;
          justify-content: space-between;
          padding: 0.5em 1em;
          border-bottom: 1px solid #ddd;
        }

        /* 로고 및 브랜드 스타일 */
        #navbar .brand {
          font-size: 1.5em;
          font-weight: bold;
          color: #333;
          text-decoration: none;
        }

        /* 프로필 이미지 스타일 */
        #navbar .profile-img {
          width: 30px;
          height: 30px;
          border-radius: 50%;
        }

        /* 네비게이션 텍스트 스타일 */
        #navbar .navbar-text {
          margin-left: 0.5em;
          font-size: 1em;
          color: #666;
        }

        /* 네비게이션 메뉴 스타일 */
        #navbar-menu {
          display: flex;
          gap: 1em;
          list-style: none;
        }

        #navbar-menu .nav-item {
          position: relative;
        }

        #navbar-menu .nav-link {
          text-decoration: none;
          color: #333;
          font-size: 1em;
          transition: color 0.3s ease;
        }

        #navbar-menu .nav-link:hover {
          color: #007bff;
        }

        /* 모바일 메뉴 토글 버튼 */
        #navbar-toggle {
          display: none;
          font-size: 1.2em;
          background: none;
          border: none;
          cursor: pointer;
        }

        /* 모바일에서의 반응형 */
        @media (max-width: 768px) {
          #navbar-menu {
            display: none;
            flex-direction: column;
            position: absolute;
            top: 100%;
            right: 1em;
            background: #f8f9fa;
            width: 200px;
            padding: 1em;
            border-radius: 4px;
            border: 1px solid #ddd;
          }

          #navbar-menu.show {
            display: flex;
          }

          #navbar-toggle {
            display: block;
          }
        }
      </style>

      <script>
        function toggleMenu() {
          const menu = document.getElementById("navbar-menu");
          menu.classList.toggle("show");
        }
      </script>

    </head>

    <body>
      <!-- 네비게이션바 -->
      <nav id="navbar">
        <a href="/" class="brand">TRAPLAN</a>

        <!-- 프로필 이미지 -->
        <c:choose>
          <c:when test="${login.profile == null}">
            <img src="/assets/img/anonymous.jpg" alt="프사" class="profile-img" />
          </c:when>
          <c:when test="${login.profile != null && login.loginMethod == 'KAKAO'}">
             <img src="${login.profile}" alt="프사" class="profile-img" />
          </c:when>
          <c:otherwise>
            <img src="/display/${login.profile}" alt="프사" class="profile-img" />
          </c:otherwise>
        </c:choose>
        <span class="navbar-text">
          &nbsp;&nbsp;Welcome ${sessionScope.login == null ? '' : login.nickName}
        </span>

        <!-- 모바일 토글 버튼 -->
        <button id="navbar-toggle" onclick="toggleMenu()">☰</button>

        <!-- 네비게이션 메뉴 -->
        <ul id="navbar-menu">
          <li class="nav-item">
            <a href="/travelboard/list" class="nav-link">게시판</a>
          </li>
          <c:choose>
            <c:when test="${login.id != null}">
              <li class="nav-item">
                <a href="/my-page/${login.id}" class="nav-link">마이페이지</a>
              </li>
              <li class="nav-item">
                <a href="/members/sign-out" class="nav-link">로그아웃</a>
              </li>
            </c:when>
            <c:otherwise>
              <li class="nav-item">
                <a href="/members/sign-in" class="nav-link">로그인</a>
              </li>
              <li class="nav-item">
                <a href="/members/sign-up" class="nav-link">회원가입</a>
              </li>
            </c:otherwise>
          </c:choose>
        </ul>
      </nav>
    </body>

    </html>