package com.shshop.threading;

/**
 *  WorkQueue Ŭ������ enqueue(Runnable work) �޼ҵ�� dequeue() �޼ҵ带 ȣ���� ��,
 *  �̹� WorkQueue�� ���� ������ ��� �߻�����
 */
public class AleadyClosedException extends Exception {

	private static final long serialVersionUID = 1L;

	public AleadyClosedException(String msg) {
		super(msg);
	}

	public AleadyClosedException() {
		super();
	}
}