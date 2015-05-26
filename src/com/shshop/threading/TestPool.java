package com.shshop.threading;

public class TestPool {
	   static int count = 0;
	   static long sleepTime = 0;
	   static ThreadPool pool = null;
	   
	   public static void main(String[] args) {
	      pool = new ThreadPool(5,10,5,2); // 허용되는 idle 개수
	      sleepTime = 1000;
	      
	      try {
	         for (int i = 0 ; i < 15 ; i ++ ) {
	            pool.execute(new Runnable() {
	               public void run() {
	                  pool.printStatus();
	                  int local = count++;
	                  
	                  try {
	                     Thread.currentThread().sleep( sleepTime );
	                     System.out.println("Test "+local);
	                  } catch(Exception ex) {
	                     ex.printStackTrace();
	                  }
	                  
	               }
	            } );
	         } 
	         
	         pool.waitUntilFinishedWork(); 
	         
	      } catch(AleadyClosedException ex) {
	         ex.printStackTrace();
	      }
	   }
	}