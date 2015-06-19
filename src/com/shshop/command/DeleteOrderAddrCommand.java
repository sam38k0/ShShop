package com.shshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.response.AddressPair;
import com.shshop.response.OrderViewInfo;
import com.shshop.service.AuthenticatorService;

public class DeleteOrderAddrCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {
		String orderKey = request.getParameter(Constant.attrOrderKey);
		String strAddressIndex = request.getParameter(Constant.attrAddressIndex);
		
		HttpSession session = request.getSession();
		OrderViewInfo orderViewInfo = (OrderViewInfo) session.getAttribute(orderKey);

		AddressPair selectedAddress = orderViewInfo.getAddressesPair().get(Integer.parseInt(strAddressIndex));
		
		AuthenticatorService authenticatorService = new AuthenticatorService();
		authenticatorService.deleteUserAddress(selectedAddress.getAddressNew());
		authenticatorService.deleteUserAddress(selectedAddress.getAddressOrigin());
		
		request.setAttribute(Constant.attrAddressIndex, strAddressIndex);
		
		return new CommandResult("/WEB-INF/view/orderView/addressDeleteJsonData.jsp");
	}

}
