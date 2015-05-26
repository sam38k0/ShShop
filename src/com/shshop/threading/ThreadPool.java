package com.shshop.threading;

public class ThreadPool extends ThreadGroup {
	public static final int DEAFULT_MAX_THREAD_COUNT = 30;
	public static final int DEAFULT_MIN_THREAD_COUNT = 0;
	public static final int DEFAULT_INITIAL_THREAD_COUNT = 10;
	public static final int DEFAULT_ALLOWED_IDLE_COUNT = 5;

	private WorkQueue works = new WorkQueue();

	private int minThreadCount;
	private int maxThreadCount;
	private int createdThreadCount = 0;
	private int workThreadCount = 0;
	private int idleThreadCount = 0;
	private int allowedIdleCount = 0;
	private boolean closed = false;

	private static int groupId = 0;
	private static int threadId = 0;

	/**
	 * ThreadPool ����
	 * 
	 * @param initThreadCount
	 *            �ʱ⿡ ������ ������ ����
	 * @param maxThreadCount
	 *            ������ �� �ִ� �ִ� ������ ����
	 * @param minThreadCount
	 *            �ּ��� �����Ǿ� �־�� �� �������� ����
	 * @param allowedIdleCount
	 *            Ǯ���� ���Ǵ� Idle �������� ����
	 */
	public ThreadPool(int initThreadCount, int maxThreadCount, int minThreadCount, int allowedIdleCount) {
		super(ThreadPool.class.getName() + Integer.toString(groupId++));

		if (minThreadCount < 0)
			minThreadCount = 0; // �ּ� ������ ���� �˻�
		if (initThreadCount < minThreadCount)
			initThreadCount = minThreadCount; // �ʱ� ������ ���� �˻�
		if (maxThreadCount < minThreadCount || maxThreadCount < initThreadCount)
			maxThreadCount = Integer.MAX_VALUE; // �ִ� ������ ���� �˻�

		if (allowedIdleCount < 0)
			allowedIdleCount = DEFAULT_ALLOWED_IDLE_COUNT;

		this.minThreadCount = minThreadCount;
		this.maxThreadCount = maxThreadCount;
		this.createdThreadCount = initThreadCount;
		this.idleThreadCount = initThreadCount;
		this.allowedIdleCount = allowedIdleCount;

		for (int i = 0; i < this.createdThreadCount; i++) {
			new PooledThread().start();
		}
	}

	public ThreadPool(int initThreadCount, int maxThreadCount, int minThreadCount) {
		this(initThreadCount, maxThreadCount, minThreadCount, DEFAULT_ALLOWED_IDLE_COUNT);
	}

	/**
	 * ť�� �۾��� ��ü�� �����Ѵ�.
	 *
	 * @work �����尡 ������ �۾�
	 */
	public synchronized void execute(Runnable work) throws AleadyClosedException {
		if (closed)
			throw new AleadyClosedException();

		// ���� ���� �ľ� ��, �ʿ��ϴٸ� ������ ������ ������Ų��.
		increasePooledThread();
		works.enqueue(work);
	}

	/**
	 * ������ Ǯ�� �����Ѵ�.
	 */
	public synchronized void waitUntilFinishedWork() throws AleadyClosedException {

		try {
			Thread.sleep(1000);
			while (workThreadCount != 0) {
				Thread.sleep(100);
			}
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

		System.out.println("CompletedWorks");
		printStatus();
		close();
	}

	private synchronized void close() throws AleadyClosedException {
		if (closed)
			throw new AleadyClosedException();
		closed = true;
		works.close();
	}

	/**
	 * �ʿ��ϴٸ� PooledThread�� ������ �����Ѵ�.
	 */
	private void increasePooledThread() {
		synchronized (works) {
			// �����ؾ� �� �۾��� ������ ��� �ִ� ������ �������� ���ٸ�,
			// �� ���̸�ŭ �����带 �����Ѵ�.
			if (idleThreadCount == 0 && createdThreadCount < maxThreadCount) {
				new PooledThread().start();
				createdThreadCount++;
				idleThreadCount++;
			}
		}
	}

	private void beginRun() {
		synchronized (works) {
			workThreadCount++;
			idleThreadCount--;
		}
	}

	/**
	 * �����带 ������ ���� ���θ� ��Ÿ����.
	 * 
	 * @return �����尡 ��� �����ؾ� �ϴ� ��� false�� ����, �����带 �����ϰ��� �� ��� true�� ����.
	 */
	private boolean terminate() {
		synchronized (works) {
			workThreadCount--;
			idleThreadCount++;

			if (idleThreadCount > allowedIdleCount && createdThreadCount > minThreadCount) {
				// idle �������� ������ 10���� �ѱ��,
				// ���� �����Ǿ� �ִ� �������� ������ minThreadCount ���� ū ���
				createdThreadCount--;
				idleThreadCount--;

				return true;
			}
			return false;
		}
	}

	/**
	 * ť�κ��� �۾�(Runnable �ν��Ͻ�)�� �о�� run() �޼ҵ带 �����ϴ� ������
	 */
	private class PooledThread extends Thread {

		public PooledThread() {
			super(ThreadPool.this, "PooledThread #" + threadId++);
		}

		public void run() {
			try {
				while (!closed) {
					Runnable work = works.dequeue();

					beginRun();
					work.run();
					
					if (terminate()) {
						break; // <- idle �������� ������ ���� ��� ������ ����
					}
				}
			} catch (AleadyClosedException ex) {
			} catch (InterruptedException ex) {
			}
		}
	}

	public void printStatus() {
		synchronized (works) {
			System.out.println("Total Thread=" + createdThreadCount);
			System.out.println("Idle  Thread=" + idleThreadCount);
			System.out.println("Work  Thread=" + workThreadCount);
			System.out.println();
		}
	}
}