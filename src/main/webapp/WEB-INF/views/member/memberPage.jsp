<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" href="../resources/css/member/memberPage.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<script type="text/javascript">
	  $(function() {
		//탭 메뉴
		$('#default').click(function() {
			$.get("./orderAndPay",function(result){
				$('.mp_box').empty();
				$('.mp_box').append(result);
			});
		});
		$('#myReview').click(function() {
			$.get("./myReview",function(result){
				$('.mp_box').empty();
				$('.mp_box').append(result);
			});
		});
		$('#myInfoMod').click(function() {
			$.get("./myInfoMod",function(result){
				$('.mp_box').empty();
				$('.mp_box').append(result);
			});
		});
		$('#sellerApply').click(function() {
			$.get("./sellerApply",function(result){
				$('.mp_box').empty();
				$('.mp_box').append(result);
			});
		});
		$('#default').click();
	});
</script>
</head>
<body>
<%@ include file="../templates/header.jsp"%>
	<div class="mp_div">
		<div class="mp_myRecord">
			<div class="mp_myPic">
				<img alt="" src="">
			</div>
			<div class="mp_myProfile">
				<strong>이름</strong><br> <span>이메일</span>
			</div>
			<div class="mp_myRecords">
				<span>수령 예정</span><br> <em>0</em>
			</div>
			<div class="mp_myRecords">
				<span>총 주문 횟수</span><br> <em>0</em>
			</div>
		</div>
		<div class="mp_myContainer">
			<aside class="mp_aside">
				<h2>마이페이지</h2>
				<ul>
					<li class="mp_tabmenu" id="default"><a href="#">주문/결제 내역</a></li>
					<li class="mp_tabmenu" id="myReview"><a href="#">나의 후기</a></li>
					<li class="mp_tabmenu" id="myInfoMod"><a href="#">회원 정보 수정</a></li>
					<li class="mp_tabmenu" id="sellerApply"><a href="#">판매자 신청</a></li>
					<li class="mp_tabmenu"><a href="#">탈퇴하기</a></li>
					<li class="mp_tabmenu"><a href="#">로그아웃</a></li>
				</ul>
			</aside>
			<div class="mp_myContainer2">
				<article class="mp_article">
					<div class="mp_box"></div>
				</article>
			</div>
		</div>
	</div>
<%@ include file="../templates/footer.jsp"%>
</body>
</html>