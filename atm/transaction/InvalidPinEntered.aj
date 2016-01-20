package atm.transaction;
import atm.physical.NetworkToBank;
import atm.physical.CardReader;
import banking.Balances;
import banking.Message;
import banking.Status;
import banking.Card ;


public aspect InvalidPinEntered {
	
	public int count1=0, count2=0,count;
	public int c ; /* Card Number */
	
	pointcut GetCard(): call(public Card CardReader.readCard());
	pointcut getStatusOfPin(): execution(public Status NetworkToBank.sendMessage(Message, Balances));
	
    
	after() returning(Card cno):GetCard()
	{
		c = cno.getNumber();
		//System.out.println(c);
		
	}
	
	after() returning(Status s):getStatusOfPin(){
		
		if(s.isInvalidPIN()==true){
			
			if(c==1) {
				count1++;
				System.out.println(" Card number : " + c +" entered wrongly "+count1+" times");
			}
			if(c==2){
				count2++;
				System.out.println(" Card number : "+ c +" entered wrongly "+count2+" times");
			}
			//count++;
			
			if(count1==4||count2==4)
			{
				System.out.println("ERROR: Invalid Pin Entered 4 times , hence retain card ");
			}
		}
	}
	
	/*before():Ejection(){
		if(count==4){
			System.out.println("ERROR: Invalid Pin Entered 4 times , hence retain card ");
			count=0;
		}
	}*/


}
