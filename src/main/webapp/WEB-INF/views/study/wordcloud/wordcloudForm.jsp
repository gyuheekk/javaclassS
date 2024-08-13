<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>wordcloudform.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
  	'use strict';
  	
  	function wordCheck1() {
  		let content = document.getElementById("content").value;
  		if(content.trim() == "") {
  			alert("내용을 입력하세요(구분자는 공백입니다.)");
  			document.getElementById("content").focus();
  			return false;
  		}
  		
  		$.ajax({
  			url : "${ctp}/study/wordcloud/analyzer1",
  			type : "post",
  			data : {content : content},
  			success:function(data) {
    			let no = 0;
    			let res = '<table class="table table-hover text-center">';
    			res += '<tr class="table-secondary"><th>번호</th><th>단어</th><th>개수</th></tr>';
    			Object.entries(data).forEach(([key, value]) => {
    			    console.log(key, value);
    			    no++;
    			    res += '<tr>';
    			    res += "<td>"+no+"</td><td>" + key + "</td><td>" + value + "건</td>";
    			    res += '<tr>';
    			});
    			res += '<tr><td colspan="3" class="m-0 p-0"></td></tr>';
    			res += '</table>';
    			$("#demo").html(res);
    		},
    		error : function() {
    			alert("전송오류~");
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
  <h2>WordCloud 사용 예</h2>
  <hr/>
  <div>
  	사용 단어의 빈도수 구하기 : 
  	<textarea rows="5" name="content" id="content" class="form-control mb-2" placeholder="문장을 입력하세요"></textarea>
  	<div class="row">
  		<div class="col">
  			<input type="button" value="TextArea내용 분석" onclick="wordCheck1()" class="btn btn-success"/>
  		</div>
  		<div class="col text-right">
  			<input type="button" value="다시실행" onclick="location.reload()" class="btn btn-warning" />
  		</div>
  	</div>
  </div>
  <hr/>
  <h4>결과</h4>
  <div id="demo"></div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>