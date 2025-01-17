package com.food.project.ordered;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class OrderedService {

	@Autowired
	private OrderedDAO orderedDAO;
	
	// 마켓에서 받은 주문 조회
	public List<OrderedVO> marketOrder(OrderedVO orderedVO) throws Exception {
	
		return orderedDAO.marketOrder(orderedVO);
	}
	
	//주문 전체 조회 - SelectList (판매자ID)
	public List<OrderedVO> orderedList(OrderedVO orderedVO) throws Exception{
		return orderedDAO.orderedList(orderedVO);
	}
	
	// 주문 전체 조회 2 
	public List<OrderedVO> orderedListNot(OrderedVO orderedVO) throws Exception {
		return orderedDAO.orderedListNot(orderedVO);
	}
	
	// 주문 마켓 기준 전체 조회 
	public List<OrderedVO> orderedMarketList(OrderedVO orderedVO) throws Exception {
		return orderedDAO.orderedMarketList(orderedVO);
	}
		
	//주문 조회 - SelectOne (유저ID or 판매자ID)
	public OrderedVO orderedSelect(OrderedVO orderedVO) throws Exception{
		return orderedDAO.orderedSelect(orderedVO);
	}
	
	// 주문 조회 - 몇번 주문했는지
	public Long orderedQuantity(OrderedVO orderedVO) throws Exception {
		return orderedDAO.orderedQuantity(orderedVO);
	}
	
	//주문 등록 - 유저ID(장바구니에 등록)
	public int orderedInsert(OrderedVO orderedVO) throws Exception{
		//주문번호 sequence 증가
		long orderNum = orderedDAO.orderedCount();
		
		//장바구니 기본값 설정
		orderedVO.setNum(orderNum);
		orderedVO.setImp_uid(null);
		orderedVO.setMerchant_uid(null);
		orderedVO.setPg(null);
		orderedVO.setPay_method(null);
		orderedVO.setCancleDetail(null);
		orderedVO.setTimeLag(30);
		orderedVO.setIsOrderChecked(0);
		orderedVO.setIsReview(0);
		
		// 값 찍어보기
		//System.out.println(orderedVO);
		
		//주문등록
		int result = orderedDAO.orderedInsert(orderedVO);
		
		return result;
	}
	
	// 주문 종료
	public int orderedFinish(OrderedVO orderedVO) throws Exception {
		return orderedDAO.orderedFinish(orderedVO);
	}
	
	//장바구니 목록 전체 삭제(memberNum)
	public int cartDeleteAll(OrderedVO orderedVO) throws Exception{
		return orderedDAO.cartDeleteAll(orderedVO);
	}
	
	//장바구니 낱개 목록 취소(ordered Num)
	public int orderDelete(OrderedVO orderedVO) throws Exception{
		return orderedDAO.orderDelete(orderedVO);
	}
	
	// 마켓에서 주문 확인
	public int orderedConfirm(OrderedVO orderedVO) throws Exception {
		return orderedDAO.orderedConfirm(orderedVO);
	}
	
	// 결제 완료
	public int orderedDone(OrderedVO orderedVO) throws Exception {
		return orderedDAO.orderedDone(orderedVO);
	}
	
	// isReview 업데이트(isReview : 0. 리뷰등록 X / 1. 리뷰 등록)
	public int orderedIsReviewUpdate(OrderedVO orderedVO) throws Exception {
		return orderedDAO.orderedIsReviewUpdate(orderedVO);
	}
	
	//주문 취소 - Update(cancleType : 0.개인변심/ 1.상품문제)
	public int orderedCancle(OrderedVO orderedVO) throws Exception{
		
		return orderedDAO.orderedCancle(orderedVO);
	}
	
}
