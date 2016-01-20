//Insert bug in Withdrawal 

///*Bug : +1 for IncorrectAmountWithdrawn */

package atm.transaction;

import simulation.Simulation;
import banking.Card;
import banking.Money;
import atm.physical.*;
import atm.transaction.Withdrawal;

public aspect IncorrectAmountWithdrawn {

String Displayed =""+"Amount of cash to withdraw"; 
String[] amountOptions = {"$20.00", "$40.00", "$60.00", "$100.00", "$200.00" };
Money [] amountValues = { 
        new Money(20), new Money(40), new Money(60),
        new Money(100), new Money(200)
      };
long AmountThatShouldBeDisplayed ;
Money var ;
int cno ; 

pointcut ReadChoice () : execution(int CustomerConsole.readMenuChoice(String ,String[]));
pointcut dispense():execution(public void CashDispenser.dispenseCash(Money));

after (String Message) returning(int choice) :ReadChoice() && args (Message,*){
	
	if((Displayed.compareTo(Message)==0))
	{
		System.out.println("Choice Entered is :"+ choice);
		
		AmountThatShouldBeDisplayed = amountValues[choice].getCents();
		
	}
		
			
}

after (Money newVal) : set(private Money Withdrawal.amount ) && args ( newVal ) {
	var = newVal;
}

before():dispense(){
	if(AmountThatShouldBeDisplayed != var.getCents())
	{
		System.out.println("ALERT : "+ var + " might be dispensed instead of $" + (AmountThatShouldBeDisplayed/100));
		
		/* Might be dispensed because if Insufficient balance is available then amount would not be dispensed anyways */
		
		System.out.println("Notify Bank about it :");
		
		/* Make Entry of this error in Log */
		
		Simulation.getInstance().printLogLine("ALERT : "+ var + " might be dispensed instead of " + AmountThatShouldBeDisplayed + " on Card Number " + cno ); 
	}
	
}



pointcut GetCard(): call(public Card CardReader.readCard());

after()returning(Card c): GetCard()
{
	cno= c.getNumber();
}

}

