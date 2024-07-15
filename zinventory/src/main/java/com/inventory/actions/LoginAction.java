package com.inventory.actions;

import com.inventory.database.Datalayer;
import com.opensymphony.xwork2.ActionSupport;

public class LoginAction extends ActionSupport {

	private int id;
	private String password;
	private String usertype;
//	private String errorMessage;

//	public String getErrorMessage() {
//
//		return errorMessage;
//	}
//
//	public void setErrorMessage(String errorMessage) {
//		this.errorMessage = errorMessage;
//	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUsertype() {
		return usertype;
	}

	public void setUsertype(String usertype) {
		this.usertype = usertype;
	}

	public String execute() {
		System.out.println("Execute Method");
		boolean success = Datalayer.getInstance().validateUser(id, usertype, password);
		System.out.println(success);
		if (success) {
			if (usertype.equals("admin")) {
				return "AdminPage";
			} else {
				return "EmployeePage";
			}
		} else {
			System.out.println("Login Invalid");
			return ERROR;
		}
	}
}