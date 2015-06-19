package com.shshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.response.AddressPair;
import com.shshop.response.OrderViewInfo;
import com.shshop.service.AuthenticatorService;

public class ChangeOrderAddrCommand implements Command {

	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {
		String orderKey = request.getParameter(Constant.attrOrderKey);
		String strAddressIndex = request.getParameter(Constant.attrAddressIndex);

		String addrName = request.getParameter(Constant.attrAddrName);
		String postNumHeader = request.getParameter(Constant.attrAddrZipCodeHead);
		String postNumTail = request.getParameter(Constant.attrAddrZipCodeTail);
		String basicAddNew = request.getParameter(Constant.attrAddrBasicNew);
		String basicAdd = request.getParameter(Constant.attrAddrBasicOld);
		String detailAdd = request.getParameter(Constant.attrAddrDetail);
		String phoneNumber = request.getParameter(Constant.attrAddrPhoneNumber);

		HttpSession session = request.getSession();
		OrderViewInfo orderViewInfo = (OrderViewInfo) session.getAttribute(orderKey);

		AddressPair selectedAddress = orderViewInfo.getAddressesPair().get(Integer.parseInt(strAddressIndex));

		selectedAddress.setAddressIndx(Integer.parseInt(strAddressIndex));
		selectedAddress.setName(addrName);
		selectedAddress.setPostNumHeader(postNumHeader);
		selectedAddress.setPostNumTail(postNumTail);
		selectedAddress.setBasicAdd(basicAdd, basicAddNew);
		selectedAddress.setDetailAdd(detailAdd);
		selectedAddress.setPhoneNumber(phoneNumber);

		AuthenticatorService authenticatorService = new AuthenticatorService();
		authenticatorService.updateUserAddress(selectedAddress.getAddressNew());
		authenticatorService.updateUserAddress(selectedAddress.getAddressOrigin());

		request.setAttribute(Constant.attrSelectedAddressResult, selectedAddress);

		return new CommandResult("/WEB-INF/view/orderView/selectAddrActionJsonData.jsp");
	}

}
