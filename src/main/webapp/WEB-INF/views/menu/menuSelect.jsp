<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴 상세보기</title>
<link rel="stylesheet" href="../resources/css/menu/menuSelect.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>

<body>
	<%@ include file="../templates/header.jsp"%>
	<div class="container">
		<div class="ms_menu">
			<input type="hidden" id="marekt_num" name="marketNum" value="${marketVO.num}">
			<input type="hidden" id="menu_num" name="menuNum" value="${menuVO.num}">
			<input type="hidden" id="member_num" name="memberNum" value="${memberVO.num}">
			
			<img src="${pageContext.request.contextPath}/resources/upload/menu/${menuVO.thumbImg}">
			<div class="ms_menuInfo">
				<h2>${menuVO.name}</h2>
				<p>${menuVO.detail}</p>
				<div style="display: flex; justify-content: space-between;">
					<p id="menuBasicPrice" style="margin: 0" data-price="${menuVO.price}"></p>
				</div>
				<nav></nav>
				<!-- 옵션 선택 페이지 -->
				<div class="ml_opSel">
					<dl class="ml_opSel_dl">
						
						<c:set var="num" value="0" />
						
						<c:forEach var="categoryVO" items="${cateList}" varStatus="set">
							<dt style="color: #3d3d3d;">${categoryVO.name}</dt>
								<c:forEach var="vo" items="${categoryVO.menuOptionVOs}" varStatus="status">
								<dd style="display: flex; justify-content: space-between; margin-top: 5px;">
									<label class="ml_opLabel" style="max-width: 300px;"> 
										<input class="option_num" type="checkbox" name="test1" value="${vo.name} ${vo.price}">
										<!-- name과 price간 간격이 필요 -->
										<div class="option_div" data-name="${vo.name}">
										${vo.name} ${vo.price}원
										</div>
									</label>
								</dd>
							</c:forEach>
							<nav></nav>
						</c:forEach>
						
					</dl>
				</div>
				<div class="quanClass">
					<input type="button" class="minus" value="ー"> 
					<input type="text" value="1" class="quantity ${vo.num}" readonly="readonly"> 
					<input type="button" class="plus" value="+">
				</div>
				<c:if test="${empty sessionScope.memberVO}">
					<button class="none" type="button">장바구니</button>
					<button class="none" type="submit">주문하기</button>
				</c:if>
				<c:if test="${not empty sessionScope.memberVO}">
					<button id="ml_cart" type="button">장바구니</button>
					<button id="ml_order" type="submit">주문하기</button>
				</c:if>
			</div>
		</div>
	</div>
	<%@ include file="../templates/footer.jsp"%>

	<script type="text/javascript">
	
		//========================
		// 콤마 찍기
		//========================
		// 천단위로 숫자에 콤마 찍기
		function moneyFormat(money) {
			return money.toLocaleString();
		}
		
		// 메뉴 기본 금액 에 콤마 찍기
		$(function(){
			var price = $('#menuBasicPrice').data("price");
			$('#menuBasicPrice').text(moneyFormat(price)+'원');
		});
		
		// 각 주문의 금액에 콤마 찍기
		$(function() {
			$('.option_num').each(function() {
				var nameAndPrice = $(this).val();
				nameAndPrice = nameAndPrice.split(" ");
				nameAndPrice[1] *= 1; // string to int
				nameAndPrice[1] = moneyFormat(nameAndPrice[1]);
				
				$('.option_div').each(function() {
					
					var name = $(this).data("name");
					if(name == nameAndPrice[0]) {
						$(this).text(nameAndPrice[0]+' +'+nameAndPrice[1]+'원');
					}
				});
			});
		});
	
		//수량조절 +
		var quan = 1;
		$(".plus").click(function() {

			var quantity = $(this).prev();
			quan = $(this).prev().val();
			
			quan++;
			quantity.val(quan);
		});
		
		//수량조절 -
		$('.minus').click(function() {

			var quantity = $(this).next();
			quan = $(this).next().val();
			
			quan--;
			if (quan <= 1) {
				quan=1;
			}
			quantity.val(quan);
		});

		// 주문하기 버튼
		$("#ml_order").click(function() {
			location.href="${pageContext.request.contextPath}/ordered/orderPage?memberNum=${sessionScope.memberVO.num}";
		});
	
		//로그인
		$(".none").each(function() {
			$(this).click(function() {
				alert("로그인을 해야만 사용이 가능합니다.");
				location.href="../member/memberLogin";
			});
		});
			
		//장바구니를 누르면 메뉴(옵션포함)추가
		$("#ml_cart").click(function() {
				var marketNum = $("#marekt_num").val();
				var menuNum = $("#menu_num").val();
				var memberNum = $("#member_num").val();
				
				var optionNum = [];
				
				//선택한 옵션 번호 구별 num값 추출
				$(".option_num").each(function() {
					if($(this).prop("checked") == true){
						optionNum.push($(this).val());
					}
				});
				
				optionNum.push("null");
				
				var data = {
						memberNum : memberNum,
						marketNum : marketNum,
						menuNum : menuNum,
						optionNum : optionNum,
						menuPrice : ${menuVO.price},
						menuName: `${menuVO.name}`,
						marketName: `${marketVO.marketName}`,
						menuThumbImg: `${menuVO.thumbImg}`,
						pcs: quan
				}
				
				$.ajax({
					url:"../ordered/cartAdd",
					type:"POST",
					data: data,
					success:function(result){
						if(result > 0) {
							alert("장바구니에 담겼어요!");						
						} else {
							alert("장바구니에 담을 수가 없네요ㅠㅠ");
						}
						
						// 모든 옵션 체크 풀기
						$(".option_num").each(function() {
							$(this).attr("checked", false);
						});
					}
				});			
		});

	</script>
</body>
</html>