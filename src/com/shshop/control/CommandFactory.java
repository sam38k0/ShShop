package com.shshop.control;

import com.shshop.command.CheckLoginStateCommand;
import com.shshop.command.Command;
import com.shshop.command.CommentPostCommend;
import com.shshop.command.InsertProductCommand;
import com.shshop.command.InsertProductViewCommand;
import com.shshop.command.JoinCommand;
import com.shshop.command.LoginCommand;
import com.shshop.command.LogoutCommand;
import com.shshop.command.MainViewCommand;
import com.shshop.command.OrderCommand;
import com.shshop.command.OrderViewCommand;
import com.shshop.command.SearchActionCommand;
import com.shshop.command.SearchCategoryCommand;
import com.shshop.command.SearchViewCommand;
import com.shshop.command.ShowDetailViewCommand;
import com.shshop.command.SimilarItemSearchCommand;
import com.shshop.command.SingleUserCommand;
import com.shshop.command.UserDataChangeCommand;
import com.shshop.constant.Constant;

public class CommandFactory {
	public static Command createCommand(String pathInfo) {
		switch (pathInfo) {
		case Constant.login:
			return new LoginCommand();
			
		case Constant.logout:
			return new LogoutCommand();
			
		case Constant.checklogin:
			return new CheckLoginStateCommand();
			
		case Constant.join:
			return new JoinCommand();
			
		case Constant.insertProductView:
			return new InsertProductViewCommand(); 

		case Constant.insertProduct:
			return new InsertProductCommand();
			
		case Constant.viewMain:
			return new MainViewCommand();
			
		case Constant.showDetailView:
			return new ShowDetailViewCommand();
			
		case Constant.searchView:
			return new SearchViewCommand();
		
		case Constant.searchAction:
			return new SearchActionCommand();
			
		case Constant.searchCategory:
			return new SearchCategoryCommand();
			
		case Constant.mypage:
			return new OrderViewCommand();
			
		case Constant.userUpdate:
			return new UserDataChangeCommand();
			
		case Constant.similarItemAction:
			return new SimilarItemSearchCommand();
			
		case Constant.commentPostAction:
			return new CommentPostCommend();
			
		case Constant.showOrderView:
			return new OrderCommand();
			
		default:
			return null;
		}
	}
}
