// 유효성 검증 관련 함수들 임포트
import { validateInput } from './validation.js';
import { debounce } from './util.js';

// 폼과 회원가입 버튼 요소를 가져옴
const form = document.getElementById('signUpForm'); // 회원가입 폼
const signupButton = document.getElementById('joinbtn'); // 회원가입 버튼
const EmailCheckButton = document.getElementById('id_check');
const NicknameCheckButton = document.getElementById('nickName_check');

// 각 필드에 대한 정보 배열 (id, 유효성 검증 함수, 에러 메시지 표시 요소, 초기 유효 상태)
const fields = [
  {
    id: 'password',
    validator: validateInput.password,
    errorElement: 'pwChk',
    valid: false,
  },
  {
    id: 'password_check',
    validator: (value) =>
      validateInput.passwordCheck(
        value,
        document.getElementById('password').value
      ),
    errorElement: 'pwChk2',
    valid: false,
  },
  {
    id: 'user_name',
    validator: validateInput.name,
    errorElement: 'nameChk',
    valid: false,
  },
  {
    id: 'user_email',
    validator: validateInput.email,
    errorElement: 'emailChk',
    valid: false,
  },
];


// 이메일 유효성검사 버튼 이벤트 리스터 추가
EmailCheckButton.addEventListener('click', async (e) =>  {

  const emailValue = document.getElementById('emailValue').value;

  const validateResult = await validateInput.email(emailValue);

 if(validateResult.valid) {
   fields[3].valid = true;
   alert("사용 가능한 이메일입니다.")
 }

 else{
   fields[3].valid = false;
   console.log(validateResult.message);
   alert(validateResult.message);
 }
})
//닉네임 유효성 검사 버튼 이벤트 리스너 추가
NicknameCheckButton.addEventListener('click', async (e) => {
  const nicknameValue = document.getElementById('usern').value;
  const validateResult = await validateInput.nickname(nicknameValue);
  if(validateResult.valid) {
    fields[2].valid = true;
    alert("사용 가능한 닉네임입니다.")
  }
  else{
    fields[2].valid = false;
    alert(validateResult.message);
  }
})
// 회원가입 버튼 클릭 이벤트 리스너 추가
signupButton.addEventListener('click', async (e) => {
  e.preventDefault();
  //비밀 번호 유효성 확인 로직
  let passwordValue = document.getElementById('userPs').value;
  const validateResult = await validateInput.password(passwordValue);
  if(validateResult.valid){
    fields[0].valid = true;
  }else{
    fields[0].valid = false;
    alert(validateResult.message);
  }
  //비밀 번호 확인 부분과 동일한지
  passwordValue = document.getElementById('userPs').value;
  const passwordConfirm = document.getElementById('userPc').value;
  const validateResult2 = await validateInput.passwordCheck(passwordValue,passwordConfirm);
  if(validateResult2.valid) {
    fields[1].valid = true;

  }else{
    fields[1].valid = false;
    alert(validateResult2.message);
  }
  // 모든 필드가 유효한지 확인
  const isFormValid = fields.every((result) => result.valid);
  if (isFormValid) {
    // 모든 필드가 유효한 경우
    form.submit(); // 폼 제출
  } else {
    // 유효하지 않은 필드가 있는 경우
    alert('입력란을 다시 확인하세요!'); // 경고 메시지 표시
  }
});
