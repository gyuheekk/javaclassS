<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>qrLogin.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
    'use strict';
    
    function fCheck() {
    	window.opener.document.location.href = "${ctp}/member/qrLoginCheck/${mid}/${qrCodeToken}";
    	window.close();
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container text-center">
  <h3>QR Code 로그인</h3>
  <div>아래 QR코드확인후 '로그인 확인'버튼을 5분안에 눌러 주세요.</div>
  <div>
    <img src="${ctp}/qrCode/${qrCodeName}.png"/>
  </div>
  <p>
    <input type="button" value="로그인 확인" onclick="fCheck()"/>
  </p>
</div>
</body>
</html>