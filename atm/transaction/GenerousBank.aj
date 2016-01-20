/* Bug inserted by adding the following lines of code in Complete Transaction part of Inquiry  
 * Money amount = new Money(200);
 *   	Simulation.getInstance().dispenseCash(amount); */
 
package atm.transaction;
import atm.transaction.Inquiry;
import simulation.Simulation;
import banking.Card;
import banking.Money;
import atm.physical.CardReader;

public aspect GenerousBank {
	
int cno ; 

pointcut GetCard(): call(public Card CardReader.readCard());

after()returning(Card c): GetCard()
{
		cno= c.getNumber();
}
	
pointcut GBank(Money amount) : within(Inquiry) && call(public void Simulation.dispenseCash(Money)) && args(amount);
	
after(Money amount) : GBank(amount) 
{
	System.out.println("ALERT : Bank is dispensing cash to CARD NUMBER: "+ cno + " on Inquiry transaction: " + (amount.getCents()/100) + "$");
	Simulation.getInstance().printLogLine("ALERT : Bank is dispensing cash to CARD NUMBER: "+ cno + " on Inquiry transaction: " + (amount.getCents()/100) + "$"); 
}


}
