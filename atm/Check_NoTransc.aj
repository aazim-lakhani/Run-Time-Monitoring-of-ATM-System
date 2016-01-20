package atm;
import banking.Card;
import atm.physical.ReceiptPrinter;
import atm.physical.CardReader;
import banking.Receipt;
import java.util.*;

public aspect Check_NoTransc extends TimerTask{

	static long start,end;
	int count1=0,count2=0,cno;
	
	pointcut setTime(): execution(public void ATM.run());
	pointcut No_transc(): execution(public void ReceiptPrinter.printReceipt(Receipt));
	pointcut getCard(): call(public Card CardReader.readCard());
	
	Timer timer = new Timer();
	before():setTime(){
		start = System.currentTimeMillis();
		timing();
	}
	after()returning(Card c):getCard(){
		cno=c.getNumber();
		
	}
	
	after():No_transc(){
		if(cno==1){
			count1++;
			
		}
		if(cno==2){
			count2++;
		}
		end = System.currentTimeMillis();
		if(count1>=2||count2>=2){
			if((end-start)<=60000){
				System.out.println("GREATER THAN OR EQUAL TO TWO TRANSACTIONS PERFORMED IN 1 MIN ");
			}
		}
	}
	public void run(){
		
		count1=0;
		count2=0;
		start=System.currentTimeMillis();
		
	}
	public void timing(){
		timer.schedule(this,60000,60000);
	}
}
