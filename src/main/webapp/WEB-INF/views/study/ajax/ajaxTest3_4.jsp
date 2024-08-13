<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">  
  <title>ajaxTest3_4.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
  	'use strict';
  	
  	function userCheck() {
  		let mid = document.getElementById("mid").value;
  		if(mid.trim() == "") {
  			alert("아이디를 선택하세요");
  			return false;
  		}
  		
  		$.ajax({
  			url : "${ctp}/study/ajax/ajaxTest3_4",
  			type : "post",
  			data : {mid : mid},
  			success:function(res) {
  				let str = "선택하신 아이디 "+mid+" 의 정보는? "+res;
  		  		$("#demo").html(str);
  			},
  			error : function() {
  				alert("전송오류");
  			}
  		});
  	}
  	
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
	<h2>ajaxTest3_4.jsp(ArrayList)</h2>
	<hr/>
	<form>
    <h3>아이디를 선택하세요</h3>
    <select name="mid" id="mid" onchange="userCheck()">
      <c:forEach var="mid" items="${vos}">
      	<option>${mid}</option>      	
      </c:forEach>
    </select>
    <input type="button" value="돌아가기" onclick="location.href='ajaxForm';" class="btn btn-warning mr-3 mb-3"/>
  </form>
  <div id="demo"></div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>