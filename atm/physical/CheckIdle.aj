package atm.physical;

import banking.Money;

public aspect CheckIdle {
	
	public long s,e;
	
	pointcut read_values(): execution(public int CustomerConsole.readPIN(String))||
	 execution(public synchronized int CustomerConsole.readMenuChoice(String, String[]))||
	 execution(public synchronized Money CustomerConsole.readAmount(String));

	before():read_values(){
		s = System.currentTimeMillis();
	}
	after():read_values(){
		e = System.currentTimeMillis();
		 if((e-s)>30000){
			 System.out.println("RESPONSE TOO SLOW,MAY LEAD TO EJECTION OF CARD");
		 }
	}
	 
	
}

