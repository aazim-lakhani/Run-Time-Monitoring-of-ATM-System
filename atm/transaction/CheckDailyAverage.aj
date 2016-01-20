package atm.transaction;
import java.util.*;
import banking.Card;
import banking.Message;
import atm.physical.CardReader;
import atm.physical.CashDispenser;
import atm.physical.CustomerConsole;
import banking.Money;
import atm.ATM;

public aspect CheckDailyAverage extends TimerTask{

	public static long withd1[] = new long[20];
	public static long withd2[] = new long[20];
	public static long Avg1=0,Avg2=0;
	public static int i=0,j=0,count1=0,count2=0,cno;
	public static long g=0;
	Timer timer1 = new Timer();
	
	pointcut GetAmount(): execution(protected Message Withdrawal.getSpecificsFromCustomer());
	pointcut GetCard(): call(public Card CardReader.readCard());
	pointcut SetTime(): execution(public void ATM.run());
	pointcut storeAmount(): execution(public void CashDispenser.dispenseCash(Money));
	
	before():SetTime(){
		Timing();
	}
	after()returning(Card c): GetCard(){
		cno= c.getNumber();
	}
	
	after()returning(Message m):GetAmount(){
		g = m.getAmount().getCents();
		g = g/100;
		
	}
	after():storeAmount(){
		if(cno==1){
			withd1[i]=g;
			i++;
		}
		if(cno==2){
			withd2[j]=g;
			j++;
		}
	}
	
	public void run(){
		if(cno==1){
			long sum = 0;
			long avg = 0;
			for(int k=0;k<i;k++){
				sum = sum + withd1[k];
			}
			try{avg = sum/i;}catch(ArithmeticException a){System.out.println("NO WITHDRAWAL FROM ANY CUSTOMER IN THE LAST 1MIN");}
			count1++;
			if(count1==1){
				Avg1 = avg;
				i=0;
			}
			else{
				if(avg>Avg1){
					System.out.println("WITHDRAWAL OF CARD1 MORE THAN THE AVERAGE DAILY");
					Avg1 = (Avg1+avg)/2;
					i=0;
				}
			}
			
		}
		if(cno==2){
			long sum = 0;
			long avg = 0;
			for(int k=0;k<j;k++){
				sum = sum + withd2[k];
			}
			try{avg = sum/j;}catch(ArithmeticException a){System.out.println("NO WITHDRAWAL FROM ANY CUSTOMER IN THE LAST 1 MIN");}
			count2++;
			if(count2==1){
				Avg2 = avg;
				j=0;
			}
			else{
				if(avg>Avg2){
					System.out.println("WITHDRAWAL OF CARD2 MORE THAN THE AVERAGE DAILY");
					Avg2 = (Avg2+avg)/2;
					j=0;
				}
			}
			
		}
		
	}
	public void Timing(){
	timer1.schedule(this,60000,60000);
	}
	
	
	

}
