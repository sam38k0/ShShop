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
	 * ThreadPool 생성
	 * 
	 * @param initThreadCount
	 *            초기에 생성할 쓰레드 개수
	 * @param maxThreadCount
	 *            생성할 수 있는 최대 쓰레드 개수
	 * @param minThreadCount
	 *            최소한 생성되어 있어야 할 쓰레드의 개수
	 * @param allowedIdleCount
	 *            풀에서 허용되는 Idle 쓰레드의 개수
	 */
	public ThreadPool(int initThreadCount, int maxThreadCount, int minThreadCount, int allowedIdleCount) {
		super(ThreadPool.class.getName() + Integer.toString(groupId++));

		if (minThreadCount < 0)
			minThreadCount = 0; // 최소 쓰레드 개수 검사
		if (initThreadCount < minThreadCount)
			initThreadCount = minThreadCount; // 초기 쓰레드 개수 검사
		if (maxThreadCount < minThreadCount || maxThreadCount < initThreadCount)
			maxThreadCount = Integer.MAX_VALUE; // 최대 쓰레드 개수 검사

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
	 * 큐에 작업할 객체를 삽입한다.
	 *
	 * @work 쓰레드가 수행할 작업
	 */
	public synchronized void execute(Runnable work) throws AleadyClosedException {
		if (closed)
			throw new AleadyClosedException();

		// 현재 상태 파악 후, 필요하다면 쓰레드 개수를 증가시킨다.
		increasePooledThread();
		works.enqueue(work);
	}

	/**
	 * 쓰레드 풀을 종료한다.
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
	 * 필요하다면 PooledThread의 개수를 증가한다.
	 */
	private void increasePooledThread() {
		synchronized (works) {
			// 수행해야 할 작업의 개수가 놀고 있는 쓰레드 개수보다 많다면,
			// 그 차이만큼 쓰레드를 생성한다.
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
	 * 쓰레드를 종료할 지의 여부를 나타낸다.
	 * 
	 * @return 쓰레드가 계속 수행해야 하는 경우 false를 리턴, 쓰레드를 종료하고자 할 경우 true를 리턴.
	 */
	private boolean terminate() {
		synchronized (works) {
			workThreadCount--;
			idleThreadCount++;

			if (idleThreadCount > allowedIdleCount && createdThreadCount > minThreadCount) {
				// idle 쓰레드의 개수가 10개를 넘기고,
				// 현재 생성되어 있는 쓰레드의 개수가 minThreadCount 보다 큰 경우
				createdThreadCount--;
				idleThreadCount--;

				return true;
			}
			return false;
		}
	}

	/**
	 * 큐로부터 작업(Runnable 인스턴스)을 읽어와 run() 메소드를 수행하는 쓰레드
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
						break; // <- idle 쓰레드의 개수가 많을 경우 쓰레드 종료
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