<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <%@ include file = "/include/certification.jsp" %> --%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>memberMain.jsp</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <script>
    'use strict';
    
		//채팅내용을 DB에 저장하기    
    function chatInput() {
    	let chat = $("#chat").val();
    	if(chat.trim() != "") {
    		$.ajax({
    			url  : "MemberChatInput.mem",
    			type : "post",
    			data : {chat : chat},
    			error: function() {
    				alert("전송오류!!");
    			}
    		});
    	}
    }
    
    // 채팅 대화 입력 후 엔터키를 누르면 자동으로 메세지 DB에 저장시키기_chatInput()함수 호출하기
    $(function(){
			$("#chat").on("keydown",function(e){
				if(e.keyCode == 13) chatInput();
			});
		});
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2>회원 전용방</h2>
  <hr/>
  <!-- 실시간 채팅방(DB) -->
  <div style="width:420px">
    <%--
    <form name="chatForm">
      <label for="chat"><b>실시간 대화방</b></label>
      <iframe src="${ctp}/include/memberMessage.jsp" width="100%" height="200px" class="border"></iframe>
      <div class="input-group mt-1">
        <input type="text" name="chat" id="chat" class="form-control" placeholder="대화내용을 입력하세요" autofocus />
        <div class="input-group-append">
          <input type="button" value="글등록" onclick="chatInput()" class="btn btn-success"/>
        </div>
      </div>
    </form>
    --%>
    
	  <c:if test="${!empty sLogin}">
  		현재 임시비밀번호를 발급하여 메일로 전송처리 되어 있습니다.<br/>
  		개인정보를 확인하시고, 비밀번호를 새로 변경해 주세요.<br/>
  	</c:if>
  </div>
  <hr/>
  <div class="row">
    <div class="col">
	  	<p>현재 <b><font color="blue">${sNickName}</font>(<font color="red">${strLevel}</font>)</b> 님이 로그인 중이십니다.</p>
	  	<p>총 방문횟수 : <b>${mVo.visitCnt}</b> 회</p>
	  	<p>오늘 방문횟수 : <b>${mVo.todayCnt}</b> 회</p>
	  	<p>총 보유 포인트 : <b>${mVo.point}</b> 점</p>
  	</div>
    <div class="col">
      <p><img src="${ctp}/member/${mVo.photo}" width="200px"/></p>
  	</div>
  </div>
  <hr/>
  <div>
    <h5>활동내역</h5>
    <p>방명록에 올린글수 : <b>${guestCnt}</b> 건</p>  <!-- 방명록에 올린이가 '성명/아이디/닉네임'과 같은면 모두 같은 사람이 올린글로 간주한다. -->
    <p>게사판에 올린글수 : ___건</p>
    <p>자료실에 올린글수 : ___건</p>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>