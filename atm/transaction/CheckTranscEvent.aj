package atm.transaction;


import banking.Message;
import banking.Receipt;
import atm.physical.ReceiptPrinter;

public aspect CheckTranscEvent implements Runnable{

	Thread t;
	String tname[] = {"1","2","3","4","5","6","7","8","9","10"};
	static int i=0;
	pointcut getStartThread():call(protected abstract Message Transaction.getSpecificsFromCustomer());
	pointcut endTransc(): execution(public void ReceiptPrinter.printReceipt(Receipt));
	
	before():getStartThread(){
		t = new Thread(this,tname[i]);
		t.start();
		i++;
	}
	before():endTransc(){
		synchronized(CheckTranscEvent.this)
        {
            CheckTranscEvent.this.notifyAll();
        }
	}
	
	public void run(){
		long start,end;
		start = System.currentTimeMillis();
		int count=0;
		while(true){
			synchronized(this)
			{
					try
			
					{
						wait();
					}
					catch(InterruptedException e)
					{}
			}
			end = System.currentTimeMillis();
			
			count++;
			if(count>=2){
				if((end-start)<=60000){
					System.out.println("GREATER THAN/EQUAL TO 2 TRANSACTIONS PERFORMED IN LAST 1 MINUTE");
					break;
				}
			}
		}
	}
}

