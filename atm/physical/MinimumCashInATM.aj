
// MinimumCashInATM
// No bug to be introduced

package atm.physical;
import banking.Money;
import atm.physical.CashDispenser;
import atm.ATM;

public aspect MinimumCashInATM {
	
long cash ;
after (Money initialCash) : withincode(private void ATM.performStartup()) && (call(public void CashDispenser.setInitialCash(Money)) && args(initialCash))
{
  cash = initialCash.getCents();
 // System.out.println(" Initial Cash : " + cash);
  if(cash <= 20000)
  {
	  System.out.println("ALERT : Cash entered in ATM is to less : Inform Bank about it ");
  }
}	

after (Money amount) returning: call(public void CashDispenser.dispenseCash(Money )) && args (amount)
{
	cash -= amount.getCents();
	System.out.println("After Deduction :"+ cash);
	if(cash<=20000)
	{
		System.out.println("Time to RELOAD Money in the ATM.:Inform Bank about it  " );
	}
	
}
	
}
