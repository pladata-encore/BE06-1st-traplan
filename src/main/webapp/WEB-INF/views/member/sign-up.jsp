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

    #id_check {
      padding: 5px;
      border: 1px solid rgb(238, 238, 238);
      border-radius: 5px;
      font-size: 10px;
      margin-left: 5px;
      background-color: white;
      color: gray;
      cursor: pointer;
    }


    #nickName_check {
      padding: 5px;
      border: 1px solid rgb(238, 238, 238);
      border-radius: 5px;
      font-size: 10px;
      margin-left: 5px;
      background-color: white;
      color: gray;
      cursor: pointer;
    }

    img {
      width: 100px;
    }

    .container.wrap {
      margin-top: 200px;
      margin-bottom: 200px;
    }

    .profile {
      margin-bottom: 70px;
      text-align: center;
    }

    .profile label {
      font-weight: 700;
      font-size: 1.2em;
      cursor: pointer;
      color: rgb(140, 217, 248);
    }

    .profile .thumbnail-box {
      width: 200px;
      height: 200px;
      border-radius: 50%;
      overflow: hidden;
      margin: 30px auto 10px;
      cursor: pointer;
    }

    .profile .thumbnail-box img {
      width: 200px;
      height: 200px;
    }
  </style>
  <html>

  <body>

    <div class="container">
      <h1 id="join_h1">회원가입</h1>
      <h2 id="join_exp"></h2>
      <div class="contents">

        <form name="join" id="signUpForm" method="post" action="/members/sign-up" enctype="multipart/form-data">

          <!-- 프로필 이미지 -->

          <div class="profile">
            <div class="thumbnail-box">
              <img src="/assets/img/image-add.png" alt="프로필 썸네일" />
            </div>

            <label>프로필 이미지 추가</label>

            <input type="file" id="profile-img" accept="image/*" style="display: none" name="profileImage" />
          </div>
          <!------------------->



          <div id="insert">
            <div>

              <input type="email" placeholder="이메일" id="emailValue" name="email" class="email_input" />
              <input id="id_check" type="button" value="이메일 중복 확인" />
            </div>
            <div>
              <input type="password" placeholder="비밀번호" name="password" id="userPs" />
            </div>

            <div>
              <input type="password" placeholder="비밀번호 확인" name="password_check" id="userPc" />
            </div>
            <div>
              <input type="text" placeholder="닉네임" name="nickName" id="usern" />
              <input id="nickName_check" type="button" value="닉네임 중복 확인" />
            </div>
            <br />
            <input type="submit" value="회원가입" id="joinbtn" formaction="/members/join" />
          </div>
          <br />
        </form>
      </div>
    </div>
    <script type="module" src="/assets/js/signUp.js"></script>
    <script>
      // 프로필 사진 업로드 관련 스크립트  --->
      const $profile = document.querySelector(".profile");
      const $fileInput = document.getElementById("profile-img");

      $profile.onclick = (e) => {
        $fileInput.click();
      };

      // 단순히 화면단에 썸네일 띄우는 것.
      $fileInput.onchange = (e) => {
        const fileData = $fileInput.files[0];
        console.log(fileData);
        const reader = new FileReader();
        reader.readAsDataURL(fileData);
        reader.onloadend = (e) => {
          const $img = document.querySelector(".thumbnail-box img");
          $img.setAttribute("src", reader.result);
        };
      };

    </script>
  </body>

  </html>