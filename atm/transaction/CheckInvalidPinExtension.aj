package atm.transaction;
import atm.physical.NetworkToBank;
import atm.physical.CardReader;
import banking.Balances;
import banking.Message;
import banking.Status;

public aspect CheckInvalidPinExtension {
	
	public int count=0;

	pointcut getStatusOfPin(): execution(public Status NetworkToBank.sendMessage(Message, Balances));
	pointcut Ejection(): execution(public void CardReader.ejectCard());

	after()returning(Status s):getStatusOfPin(){
		if(s.isInvalidPIN()==true){
			count++;
		}
	}
	
	before():Ejection(){
		if(count==4){
			System.out.println("ERROR: EJECTION INSTEAD OF RETENTION");
			count=0;
		}
	}


}
