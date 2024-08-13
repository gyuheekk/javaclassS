<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>ajaxForm.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
    'use strict';
    
    function ajaxTest1(idx) {
    	//location.href = "${ctp}/study/ajax/ajaxTest1?idx="+idx;
    	$.ajax({
    		url  : "${ctp}/study/ajax/ajaxTest1",
    		type : "post",
    		data : {idx : idx},
    		success:function(res) {
    			$("#demo1").html(res);
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    function ajaxTest2(str) {
    	//location.href = "${ctp}/study/ajax/ajaxTest1?idx="+idx;
    	$.ajax({
    		url  : "${ctp}/study/ajax/ajaxTest2",
    		type : "post",
    		// contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    		// headers : {Content-Type: "application/json"},
    		data : {str : str},
    		success:function(res) {
    			$("#demo2").html(res);
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    function fCheckd1() {
			let mid = document.getElementById("mid").value;
			if(mid.trim() == "") {
				alert("아이디를 입력하세요");
				document.getElementById("mid").focus();
				return false;
			}
			$.ajax({
				url : "${ctp}/study/ajax/ajaxTest4-1",
				type : "post",
				data : {mid : mid},
				success:function(vo) {
					console.log(vo);
					let str = '<h5>vo로 전송된 자료 출력</h5>';
					if(vo != '') {
						str += '아이디 : ' + vo.mid + '<br/>';
						str += '성명 : ' + vo.name + '<br/>';
						str += '나이 : ' + vo.age + '<br/>';
						str += '주소 : ' + vo.address + '<br/>';
					}
					else {
						str += "<b>찾고자 하는 자료가 없습니다.</b>";
					}
					$("#demo3").html(str);
				},
				error : function() {
					alert("전송오류");
				}
			});
    }
    
    function fCheckd2() {
    	let mid = document.getElementById("mid").value;
			if(mid.trim() == "") {
				alert("아이디를 입력하세요");
				document.getElementById("mid").focus();
				return false;
			}
			$.ajax({
				url : "${ctp}/study/ajax/ajaxTest4-2",
				type : "post",
				data : {mid : mid},
				success:function(vos) {
					console.log(vos);
					let str = '<h5>vos로 전송된 자료 출력</h5>';
					
					if(vos != '') {
						str += '<table class="table table-bordered table-hover text-center">';
						str += '<tr class="table-secondary">';
						str += '<th>아이디</th><th>성명</th><th>나이</th><th>주소</th>';
						str += '</tr>';
						for(let i=0; i<vos.length; i++) {
							str += '<tr>';
							str += '<td>' + vos[i].mid + '</td>';
							str += '<td>' + vos[i].name + '</td>';
							str += '<td>' + vos[i].age + '</td>';
							str += '<td>' + vos[i].address + '</td>';
							str += '</tr>';
						}
						/* str += '<tr><td colsoan="4" class="m-0 p-0"></td></tr>'; */
						str += '</table>';
					}
					else {
						str += "<b>찾고자 하는 자료가 없습니다.</b>";
					}
					
					$("#demo3").html(str);
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
  <h2>AJAX 연습</h2>
  <hr/>
  <div>기본(int -> String -> int -> String) :<br/>
    <a href="javascript:ajaxTest1(10)" class="btn btn-success mr-2 mb-2">값전달1</a>
    : <span id="demo1"></span>
  </div>
  <div>기본(String) :<br/><br/>
    <a href="javascript:ajaxTest2('안녕')" class="btn btn-primary mr-2 mb-2">값전달2</a>
    : <span id="demo2"></span>
  </div>
  <hr/>
  <div class="mb-2">응용(배열) - 시(도)/구(시,군,동) 출력<br/>
    <a href="${ctp}/study/ajax/ajaxTest3_1" class="btn btn-primary mr-2">String배열</a>
    <a href="${ctp}/study/ajax/ajaxTest3_2" class="btn btn-secondary mr-2">ArrayList</a>
    <a href="${ctp}/study/ajax/ajaxTest3_3" class="btn btn-warning mr-2">Map형식</a>
    <a href="${ctp}/study/ajax/ajaxTest3_4" class="btn btn-info mr-2">DB성명으로 자료검색</a>
  </div>
  <hr/>
  <div>아이디 : 
  	<input type="text" name="mid" id="mid" class="form-control mb-3" autofocus />
  	<input type="button" value="아이디완전일치(vo)" onclick="fCheckd1()" class="btn btn-info mr-2" />
  	<input type="button" value="아이디부분일치(vos)" onclick="fCheckd2()" class="btn btn-secondary mr-2" />
  </div>
  <div id="demo3"></div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>