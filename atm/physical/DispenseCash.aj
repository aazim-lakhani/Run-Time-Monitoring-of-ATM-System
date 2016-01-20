package atm.physical;

import banking.Status;
import banking.Message;
import banking.Balances;
import banking.Money;
public aspect DispenseCash {
	boolean flag;
pointcut status():execution(public Status NetworkToBank.sendMessage(Message,Balances));
pointcut dispense():execution(public void CashDispenser.dispenseCash(Money));
after() returning(Status s):status(){
	 flag=s.isSuccess();
}
before():dispense(){
	if(flag!=true)
	{
		System.out.println("NO APPROVAL OBTAINED FROM THE BANK");
	    
	}
}
}