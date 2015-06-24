package com.shshop.service;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.domain.Address;
import com.shshop.domain.Order;
import com.shshop.domain.OrderProc;
import com.shshop.domain.OrderState;
import com.shshop.domain.Product;
import com.shshop.domain.User;
import com.shshop.helper.Format;
import com.shshop.mapper.AddressMapper;
import com.shshop.mapper.OrderMapper;
import com.shshop.mapper.OrderStateMapper;
import com.shshop.mapper.ProductMapper;
import com.shshop.mapper.UserMapper;
import com.shshop.response.OrderInfo;
import com.shshop.response.OrderViewInfo;
import com.shshop.util.MyBatisUtil;

public class OrderService {
	private SqlSession sqlSession = null;

	public OrderService() {
	}

	public void insertOrderData(Order order) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		try {
			OrderMapper orderMapper = sqlSession.getMapper(OrderMapper.class);
			orderMapper.insertOrderProc(new OrderProc(order));
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}

	public void updateOrderData(Order order) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		try {
			OrderMapper orderMapper = sqlSession.getMapper(OrderMapper.class);
			orderMapper.updateOrder(order);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}

	public List<Order> selectBuyOrder(int orderId) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		List<Order> order;
		try {
			OrderMapper orderMapper = sqlSession.getMapper(OrderMapper.class);
			order = orderMapper.getBuyOrder(orderId);
		} finally {
			sqlSession.close();
		}
		return order;
	}


	public Address selectBuyAddress(int orderId) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		Address address;
		try {
			OrderMapper orderMapper = sqlSession.getMapper(OrderMapper.class);
			address = orderMapper.getBuyUserAdd(orderId);
		} finally {
			sqlSession.close();
		}
		return address;
	}

	public List<Order> selectSellOrder(int userId) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		List<Order> order;
		try {
			OrderMapper orderMapper = sqlSession.getMapper(OrderMapper.class);
			order = orderMapper.getSellOrder(userId);
		} finally {
			sqlSession.close();
		}
		return order;
	}

	
	public Address selectSellAddress(int addressId) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		Address address;
		try {
			AddressMapper orderMapper = sqlSession.getMapper(AddressMapper.class);
			address = orderMapper.getAddressById(addressId);
		} finally {
			sqlSession.close();
		}
		return address;
	}

	public void insertOrderState(OrderState orderState) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		try {
			OrderStateMapper osMapper = sqlSession.getMapper(OrderStateMapper.class);
			osMapper.insertOrderState(orderState);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}

	public void updateOrderState(OrderState orderState) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		try {
			OrderStateMapper osMapper = sqlSession.getMapper(OrderStateMapper.class);
			osMapper.updateOrderState(orderState);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}

	public OrderState getOrderState(int orderId) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		OrderState orderState = null;
		try {
			OrderStateMapper osMapper = sqlSession.getMapper(OrderStateMapper.class);
			List<OrderState> orderStates = osMapper.getOrderState(orderId);
			if(orderStates != null && orderStates.size() == 1) {
				orderState = orderStates.get(0);
			} else {
				System.out.println("오더 스테이트가 2개 이상있음. 문제있다..");
			}
		} finally {
			sqlSession.close();
		}
		
		return orderState;
	}

	public Product selectProduct(int productId) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		Product product;
		try {
			ProductMapper productMapper = sqlSession.getMapper(ProductMapper.class);
			product = productMapper.getProductById(productId);
		} finally {
			sqlSession.close();
		}
		return product;
	}
	
	public CommandResult changeOrderItemCount(HttpServletRequest request) {
		String orderKey = request.getParameter(Constant.attrOrderKey);
		String strOrderIndex = request.getParameter(Constant.attrOrderIndex);
		String strItemQuantity = request.getParameter(Constant.attrItemNewQuantity);
		int orderIndex = Integer.parseInt(strOrderIndex);
		int itemQuantity = Integer.parseInt(strItemQuantity);
		
		HttpSession session = request.getSession();
		OrderViewInfo orderViewInfo = (OrderViewInfo) session.getAttribute(orderKey);
		
		List<OrderInfo> orderInfos = orderViewInfo.getCurrentPageOrderInfos();
		
		OrderInfo orderInfo = orderInfos.get(orderIndex);
		orderInfo.setQuantity(itemQuantity);
		
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		 
		try {
			OrderMapper orderMapper = sqlSession.getMapper(OrderMapper.class);
			orderMapper.updateOrder(orderInfo.getOrder());
		} catch (Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
		} finally {
			sqlSession.close();
		}
		
		int currentPage = orderViewInfo.getPageDivider().getCurrentPage();
		int pageDivNum = orderViewInfo.getPageDivider().getPageDivNum();
		orderViewInfo.changeItemQuantity((currentPage-1) * pageDivNum + orderIndex, itemQuantity); 
		
		orderInfos = orderViewInfo.getCurrentPageOrderInfos();
		
		request.setAttribute(Constant.attrOrderViewInfo, orderViewInfo);
		request.setAttribute(Constant.attrDataPage, currentPage);
		request.setAttribute(Constant.attrCurrentPagesResult, orderInfos);

		return new CommandResult("/WEB-INF/view/shoppingCartView/cartListJsonData.jsp");
	}

	public CommandResult deleteOrderItemCount(HttpServletRequest request) {
		String orderKey = request.getParameter(Constant.attrOrderKey);
		String strOrderIndex = request.getParameter(Constant.attrOrderIndex);
		
		HttpSession session = request.getSession();
		OrderViewInfo orderViewInfo = (OrderViewInfo) session.getAttribute(orderKey);
		
		List<OrderInfo> orderInfos = orderViewInfo.getCurrentPageOrderInfos();
		
		int orderIndex = Integer.parseInt(strOrderIndex);

		OrderInfo orderInfo = orderInfos.get(orderIndex); 
		
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		 
		try {
			OrderMapper orderMapper = sqlSession.getMapper(OrderMapper.class);
			orderMapper.deleteOrder(orderInfo.getOrder());
		}  catch (Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
		}  finally {
			sqlSession.close();
		}
		
		int currentPage = orderViewInfo.getPageDivider().getCurrentPage();
		int pageDivNum = orderViewInfo.getPageDivider().getPageDivNum();
		orderViewInfo.removOrderData((currentPage-1) * pageDivNum + orderIndex); 
		
		orderInfos = orderViewInfo.getCurrentPageOrderInfos();
		
		request.setAttribute(Constant.attrOrderViewInfo, orderViewInfo);
		request.setAttribute(Constant.attrDataPage, currentPage);
		request.setAttribute(Constant.attrCurrentPagesResult, orderInfos);

		return new CommandResult("/WEB-INF/view/shoppingCartView/cartListJsonData.jsp");
	}
	
	public OrderInfo createNewOrderInfo(HttpServletRequest request, Integer userId, Integer productId, int quantity, int shippingPrice, String orderRequest,String strOrderState) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();

		try {
			UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
			User user = userMapper.getUserById(userId);
			
			List<Address> userAddresses = userMapper.getUserAddress(user.getUserId());
			
			ProductService psService = new ProductService();
			Product product = psService.getProductById(sqlSession, productId);
			String imagePath = psService.getProductFirstImagePaths(sqlSession, productId, request);
			
			if (user == null || product == null || userAddresses == null || userAddresses.size() <= 0)
				return null;

			if (imagePath == "") {
				return null;
			}
 
			Order order = new Order(userId, productId, userAddresses.get(0).getIdAddress(), quantity, product.getPrice()*quantity, shippingPrice, orderRequest);
			
			OrderMapper orderMapper = sqlSession.getMapper(OrderMapper.class);
			OrderProc orderProc = new OrderProc(order);
			orderMapper.insertOrderProc(orderProc);
			
			int orderId = orderProc.getInsertedOrderId();
			order.setOrderId(orderId);
			OrderState orderState = new OrderState(orderId,strOrderState);
			
			OrderStateMapper orderStateMapper =sqlSession.getMapper(OrderStateMapper.class);
			orderStateMapper.insertOrderState(orderState);
			
			return new OrderInfo(order, orderState, product, imagePath, quantity, shippingPrice);

		} catch (Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			return null;
		}  finally {
			sqlSession.commit();
			sqlSession.close();
		}
	}
	
	public int getVirtualOrderCount(int userId) {
		sqlSession = MyBatisUtil.getSqlSessionFactory().openSession();
		
		int virtualOrderCount = 0;
		
		try {
			OrderMapper orderMapper = sqlSession.getMapper(OrderMapper.class);
			OrderStateMapper orderStateMapper = sqlSession.getMapper(OrderStateMapper.class);
			
			List<Order>  orders = orderMapper.getBuyOrder(userId);
			
			for(Order order: orders) {
				List<OrderState> orderStates = orderStateMapper.getOrderState(order.getOrderId());
				if(orderStates != null && orderStates.size() > 1) {
					System.out.println("오더 스테이트가 2개 이상이다.. 문제있음.");
				}
				
				if(orderStates.get(0).getOrderState() == OrderState.VirtualOrder) {
					virtualOrderCount++;
				}
			}
			
			return virtualOrderCount;

		} catch (Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
		} finally {
			sqlSession.close();
		}
		
		return virtualOrderCount;
	}

	
	public CommandResult createVirtualOrder(HttpServletRequest request) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute(Constant.attrUser);
		if (user == null) {
			return new CommandResult(Constant.textPlain, Constant.noUser);
		}
		
		String strProductId = request.getParameter(Constant.attrProductId);
		String strOrderCount = request.getParameter(Constant.attrOrderCount);
		
		if(strProductId == null || strProductId == "")
			return null;
		
		if(strOrderCount == null || strOrderCount == "")
			return null;
		
		AuthenticatorService authenticatorService = new AuthenticatorService();
		List<Address> addresses = authenticatorService.getUserAddress(user.getUserId());
		if (addresses == null) {
			return new CommandResult(Constant.textPlain, Constant.noAddress);
		}

		OrderViewInfo orderViewInfo = new OrderViewInfo(user, addresses, 1, 5); 
		int productId = Integer.parseInt(strProductId);
		int orderCount = Integer.parseInt(strOrderCount);
		OrderInfo orderInfo = createNewOrderInfo(request, user.getUserId(), productId, orderCount, Format.randBetween(2500, 5000), "주의", OrderState.VirtualOrder);
		if(orderInfo != null) {
			orderViewInfo.addOrderInfo(orderInfo); 
			
			synchronized (session) {
				String orderKey = UUID.randomUUID().toString();
				session.setAttribute(orderKey, orderViewInfo);
			}
		}
 
		int virtualOrderCount = getVirtualOrderCount(user.getUserId());
		
		request.setAttribute(Constant.attrVirtualOrderCount, virtualOrderCount);

		return new CommandResult("/WEB-INF/view/detailView/virtualOrderJsonData.jsp"); 
	}
}
