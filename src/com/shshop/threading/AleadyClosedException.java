package com.shshop.threading;


public class AleadyClosedException extends Exception {

	private static final long serialVersionUID = 1L;

	public AleadyClosedException(String msg) {
		super(msg);
	}

	public AleadyClosedException() {
		super();
	}
}