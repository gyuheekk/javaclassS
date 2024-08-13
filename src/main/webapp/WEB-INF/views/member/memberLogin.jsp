<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<%
/*
	// 로그인창에 아이디 체크 유무에 대한 처리
	// 쿠키를 검색해서 cMid가 있을때 가져와서 아이디입력창에 뿌릴수 있게 한다.
	Cookie[] cookies = request.getCookies();

	if(cookies != null) {
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("cMid")) {
				pageContext.setAttribute("mid", cookies[i].getValue());
				break;
			}
		}
	}
*/
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>memberLogin.jsp</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <style>
	  .spinner-container {
	  position: fixed;
	  top: 50%;
	  left: 50%;
	  transform: translate(-50%, -50%);
	  display: none;
	  z-index: 9999; /* 다른 요소들보다 위에 표시되도록 합니다 */
	}
  </style>
  <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
  <script>
    'use strict';
 		// 처음 로딩시는 아이디찾기/비밀번호 찾기(가려진상태)
    $(function(){
    	$("#searchMid").hide();
    	$("#searchPassword").hide();
    });
    
    // 비밀번호 찾기버튼 누르면(보이기)
    function pwdSearch() {
    	$("#searchPassword").show();
    	$("#searchMid").hide();
    }
    
    //아이디 찾기버튼 누르면(보이기)
    function midSearch() {
    	$("#searchMid").show();
    	$("#searchPassword").hide();
    }
    
 	// 임시비밀번호 등록시켜주기
  function newPassword() {
  	let mid = $("#midSearch").val().trim();
  	let email = $("#emailSearch2").val().trim();
  	if(mid == "" || email == "") {
  		alert("가입시 등록한 아이디와 메일주소를 입력하세요");
  		$("#midSearch").focus();
  		return false;
  	}
  	
  	$.ajax({
  		url  : "${ctp}/member/memberNewPassword",
  		type : "post",
  		data : {
  			mid   : mid,
  			email : email
  		},
  		beforeSend: function() {
  			// AJAX 요청이 시작되기 전에 스핀 태그 표시
  			$("#spinner-password").css("display", "inline-block");
  		},
  		success:function(res) {
  			// AJAX 요청이 성공하면 스핀 태그 숨김
  			$("#spinner-password").css("display", "none");
  			
  			if(res != "0") alert("새로운 비밀번호가 회원님 메일로 발송 되었습니다.\n메일주소를 확인하세요.");
  			else alert("등록하신 정보가 일치하지 않습니다.\n확인후 다시 처리하세요.");
				location.reload();
  		},
  		error : function() {
  			// AJAX 요청이 실패해도 스핀 태그를 숨김
  			$("#spinner-password").css("display", "none");
  			alert("전송오류!!")
  		}
  	});
  }
 	
	//이메일로 아이디 보내주기
  function findMid() {
  	let name = $("#nameSearch").val().trim();
  	let email = $("#emailSearch1").val().trim();
  	if(name == "" || email == "") {
  		alert("가입시 등록한 이름과 메일주소를 입력하세요");
  		$("#nameSearch").focus();
  		return false;
  	}
  	
  	$.ajax({
  		url  : "${ctp}/member/memberFindMid",
  		type : "post",
  		data : {
  			name   : name,
  			email : email
  		},
  		beforeSend: function() {
  			$("#spinner-mid").css("display", "inline-block");
  		},
  		success:function(res) {
  			$("#spinner-mid").css("display", "none");
  			
  			if(res != "0") alert("회원님의 아이디를 메일로 발송 했습니다.\n메일주소를 확인하세요.");
  			else alert("등록하신 정보가 일치하지 않습니다.\n확인후 다시 처리하세요.");
  		},
  		error : function() {
  			$("#spinner-mid").css("display", "none");
  			alert("전송오류!!")
  		}
  	});
  }
	
	// 카카오 로그인(자바스크립트 앱키 등록)
	window.Kakao.init("9f1100921cedf0acc87d10b394a10590");
	
	function kakaoLogin() {
		window.Kakao.Auth.login({
			scope: 'profile_nickname, account_email',
			success:function(autoObj) {
				console.log(Kakao.Auth.getAccessToken(), "정상 토큰 발급 됨");
				window.Kakao.API.request({
					url : '/v2/user/me',
					success:function(res) {
						const kakao_account = res.kakao_account;
						console.log(kakao_account);
						location.href = "${ctp}/member/kakaoLogin?nickName="+kakao_account.profile.nickname+"&email="+kakao_account.email+"&accessToken="+Kakao.Auth.getAccessToken();
					}
				});
			}
		});
	}
	
	 // QR 로그인
    function qrLogin() {
    	let mid = myform.mid.value;
    	if(mid == "") {
    		alert("아이디를 입력하세요\n아이디 분실시는 QR로그인할수 없습니다.");
    		return false;
    	}
    	let url = "${ctp}/member/qrLogin?mid="+mid;
      let windowName = "childWindow";
      let windowWidth = 250;
      let windowHeight = 400;
      let x = (window.screen.width / 2) - (windowWidth / 2);
      let y = (window.screen.height / 2) - (windowHeight / 2);
      let opt = "width="+windowWidth+"px, height="+windowHeight+"px, left="+x+", top="+y;

      newWin = window.open(url, windowName, opt);
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <form name="myform" method="post">
    <table class="table table-bordered text-center">
      <tr>
        <td colspan="2"><font size="5">로 그 인</font></td>
      </tr>
      <tr>
        <th>아이디</th>
        <td><input type="text" name="mid" value="${mid}" autofocus required class="form-control"/></td>
      </tr>
      <tr>
        <th>비밀번호</th>
        <td><input type="password" name="pwd" value="1234" required class="form-control"/></td>
      </tr>
      <tr>
        <td colspan="2">
          <input type="submit" value="로그인" class="btn btn-success mr-2"/>
          <input type="reset" value="다시입력 " class="btn btn-warning mr-2"/>
          <input type="button" value="회원가입" onclick="location.href='${ctp}/member/memberJoin';" class="btn btn-primary mr-4"/>
          <input type="button" value="QR 로그인" onclick="qrLogin()" class="btn btn-secondary mr-4"/>
        	<a href="javascript:kakaoLogin()"><img src="${ctp}/images/kakao_login_medium_narrow.png" width="150px"/></a>
        </td>
      </tr>
    </table>
    <table class="table p-0">
    	<tr>
    		<td class="text-center">
	    		<input type="checkbox" name="idSave" checked /> 아이디 저장 &nbsp;&nbsp;&nbsp;
					[<a href="javascript:midSearch()">아이디 찾기</a>] /	
					[<a href="javascript:pwdSearch()">비밀번호 찾기</a>]    		
    		</td>
    	</tr>
    </table>
  </form>
  <div id="searchPassword">
    <hr/>
  	<table class="table table-bordered p-0 text-center">
  	  <tr>
  	    <td colspan="2" class="text-center">
  	      <font size="4"><b>비밀번호 찾기</b></font>
  	      (가입시 입력한 아이디와 메일주소를 입력하세요)
  	    </td>
  	  </tr>
  	  <tr>
  	    <th>아이디</th>
  	    <td><input type="text" name="midSearch" id="midSearch" class="form-control" placeholder="아이디를 입력하세요"/></td>
  	  </tr>
  	  <tr>
  	    <th>메일주소</th>
  	    <td><input type="text" name="emailSearch2" id="emailSearch2" class="form-control" placeholder="메일주소를 입력하세요"/></td>
  	  </tr>
  	  <tr>
  	    <td colspan="2" class="text-center">
  	      <input type="button" value="새비밀번호발급" onclick="newPassword()" class="form-control btn btn-outline-secondary" placeholder="메일주소를 입력하세요"/>
  	   		<div id="spinner-password" class="spinner-container">
					  <div id="spinner" class="spinner-border text-muted"></div>
					</div>
  	    </td>
  	  </tr>
  	</table>
  </div>
  <div id="searchMid">
    <hr/>
  	<table class="table table-bordered p-0 text-center">
  	  <tr>
  	    <td colspan="2" class="text-center">
  	      <font size="4"><b>아이디 찾기</b></font>
  	      (가입시 입력한 이름과 메일주소를 입력하세요)
  	    </td>
  	  </tr>
  	  <tr>
  	    <th>이름</th>
  	    <td><input type="text" name="nameSearch" id="nameSearch" class="form-control" placeholder="이름을 입력하세요"/></td>
  	  </tr>
  	  <tr>
  	    <th>메일주소</th>
  	    <td><input type="text" name="emailSearch1" id="emailSearch1" class="form-control" placeholder="메일주소를 입력하세요"/></td>
  	  </tr>
  	  <tr>
  	    <td colspan="2" class="text-center">
  	      <input type="button" value="아이디 찾기" onclick="findMid()" class="form-control btn btn-outline-secondary" placeholder="메일주소를 입력하세요"/>
  	    	<div id="spinner-mid" class="spinner-container">
					  <div id="spinner" class="spinner-border text-muted"></div>
					</div>
  	    </td>
  	  </tr>
  	</table>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>