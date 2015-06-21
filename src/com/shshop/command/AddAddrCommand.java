package com.shshop.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shshop.constant.Constant;
import com.shshop.control.CommandResult;
import com.shshop.domain.Address;
import com.shshop.domain.User;
import com.shshop.response.AddressPair;
import com.shshop.response.OrderViewInfo;
import com.shshop.service.AuthenticatorService;

public class AddAddrCommand implements Command {
	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute(Constant.attrUser);
		if (user == null) {
			return new CommandResult(Constant.textPlain, Constant.noUser);
		}

		String orderKey = request.getParameter(Constant.attrOrderKey);
		OrderViewInfo orderViewInfo = (OrderViewInfo) session.getAttribute(orderKey);
		if (orderViewInfo.getAddressesPairSize() >= 5) {
			return new CommandResult(Constant.textPlain, Constant.overAddrlimitInput);
		}

		String addrName = request.getParameter(Constant.attrAddrName);
		String postNumHeader = request.getParameter(Constant.attrAddrZipCodeHead);
		String postNumTail = request.getParameter(Constant.attrAddrZipCodeTail);
		String basicAddNew = request.getParameter(Constant.attrAddrBasicNew);
		String basicAdd = request.getParameter(Constant.attrAddrBasicOld);
		String detailAdd = request.getParameter(Constant.attrAddrDetail);
		String phoneNumber = request.getParameter(Constant.attrAddrPhoneNumber);

		AuthenticatorService authenticatorService = new AuthenticatorService();
		Address address = new Address(user.getUserId(), null, basicAdd, detailAdd, postNumHeader, postNumTail, addrName, phoneNumber);
		int addressId = authenticatorService.insertUserAddress(address);

		Address addressNew = new Address(user.getUserId(), addressId, basicAddNew, detailAdd, postNumHeader, postNumTail, addrName, phoneNumber);
		int addressNewId = authenticatorService.insertUserAddress(addressNew);

		address.setIdAddress(addressId);
		addressNew.setIdAddress(addressNewId);

		AddressPair addedAddressPair = new AddressPair(address, addressNew);
		orderViewInfo.addAddressPair(addedAddressPair);
		
		request.setAttribute(Constant.attrUserName, user.getName());
		request.setAttribute(Constant.attrAddressIndex, orderViewInfo.getAddressesPairSize());
		request.setAttribute(Constant.attrSelectedAddressResult, addedAddressPair);

		return new CommandResult("/WEB-INF/view/orderView/addressEditJsonData.jsp");
	}
}
