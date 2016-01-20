/* Bug : Same as that for transfer : + 5000 in add() of Money */

package atm.transaction;

import banking.Balances;
import banking.Message;
import banking.Money;
import banking.Status;
import simulation.SimulatedBank; 

public aspect IncorrectAmountDeposited {
	
	long AmountBeforeDepositing ;
	long AmountAfterDepositing ;
	
	
	pointcut AmountBeforeDeposit() : withincode(private Status SimulatedBank.completeDeposit(Message, Balances)) && call(public void Money.add(Money)) ;
	
	before(Money InitAmt, Money AmtAdded) : AmountBeforeDeposit() && target(InitAmt) && args(AmtAdded)
	{
		System.out.println("Amount in the Account before deposit :"+ InitAmt.getCents());
		System.out.println("Amount deposited is :" + AmtAdded.getCents());
		AmountBeforeDepositing = InitAmt.getCents() + AmtAdded.getCents();
	}
	
	after(Money AfterDeposit) : AmountBeforeDeposit() && target(AfterDeposit) {
		System.out.println(" Amount after depositing : "+ AfterDeposit.getCents() );
		AmountAfterDepositing = AfterDeposit.getCents() ;
		if(AmountBeforeDepositing != AmountAfterDepositing) {
			System.out.println("Incorrect Amount Deposited :");
		}
		
		
	}
	
	

}
