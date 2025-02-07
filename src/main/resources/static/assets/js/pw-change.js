import {checkAvailability, validateInput} from "./validation.js";

const form = document.getElementById("change-pw");
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
        id: 'user_email',
        validator: validateInput.email,
        errorElement: 'emailChk',
        valid: false,
    },
];

let code = ''; // 이메일 전송 인증번호를 전역변수로 선언.

// 이메일 인증버튼 클릭 이벤트
document.getElementById('email').onclick = () => {
    const email = document.getElementById('email-value').value.trim();
    console.log('완성된 email: ', email);
    if(!checkAvailability("email",email)){
        alert("가입 되지않은 이메일 입니다.")
        return;
    }
    fetch('/members/email', {
        method: 'post',
        headers: {
            'Content-type': 'text/plain',
        },
        body: email,
    })
        .then((res) => {
            if (res.status === 200) {
                return res.text();
            } else {
                alert('존재하지 않는 이메일 주소인거 같아요!');
                return;
            }
        })
        .then((data) => {
            console.log('인증번호: ', data);
            alert('인증번호가 전송되었습니다. 입력란에 정확히 입력해 주세요!');
            // document.getElementById('mail-check-input').disabled = false;
            code = data; // 서버가 전달한 인증번호를 전역변수에 저장.
        });
};

// 인증번호 검증
// blur -> focus가 빠지는 경우 발생.
document.getElementById('check-num').onclick = (e) => {
    const inputCode = document.getElementById("check-num-value").value;
    console.log(inputCode)
    if (inputCode === code) {
        // document.getElementById('mailCheckMsg').textContent =
        //     '인증번호가 일치합니다!';
        // document.getElementById('mailCheckMsg').style.color = 'skyblue';
        // e.target.style.display = 'none';
        fields[2].valid = true;
        alert('인증번호가 일치합니다')
    } else {
        // document.getElementById('mailCheckMsg').textContent =
        //     '인증번호를 다시 확인하세요!';
        // document.getElementById('mailCheckMsg').style.color = 'red';
        // e.target.focus();
        fields[1].valid = false;
        alert('인증번호를 다시 확인하세요')
    }
};

document.getElementById('joinbtn').addEventListener('click', async (e) => {
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


