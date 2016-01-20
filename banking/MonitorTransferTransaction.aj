// Insert bug : -5000 in subtract method of Money 

package banking;

import banking.Money;
import simulation.SimulatedBank;;

public aspect MonitorTransferTransaction  {

long FromAccountInitialBalance;
long FromAccountBalance ;
long ToAccountInitialBalance ;
long ToAccountBalance ;
long BeforeTransfer;
long AfterTransfer;

pointcut WithinSimulatedBank() : withincode(private Status SimulatedBank.transfer(Message,Balances));

before(Money BeforeSubtraction): WithinSimulatedBank() && (call(public boolean Money.lessEqual(Money)) && args(BeforeSubtraction)) 
{
	FromAccountInitialBalance = BeforeSubtraction.getCents();
	System.out.println(" From account balance before transfer is : "+  FromAccountInitialBalance/100 + "$");
}
	 
before(Money BeforeAddition) : WithinSimulatedBank() && (call(void Money.add(Money)) && target(BeforeAddition))
{
  	
    ToAccountInitialBalance = BeforeAddition.getCents() ;
    BeforeTransfer = FromAccountInitialBalance + ToAccountInitialBalance ;
    System.out.println("Sum of accounts Before Transfer :" + BeforeTransfer/100 + "$" );
}


after (Money AfterSubtraction) : WithinSimulatedBank() && (call(public void Money.subtract(Money)) && target(AfterSubtraction))
{
    FromAccountBalance = AfterSubtraction.getCents() ;
    System.out.println(" From account balance after transfer is ::" + FromAccountBalance/100 + "$");
    if(FromAccountBalance < 0)
    {
    	System.out.println("Bank transfering amount even if balance is zero");
    }
}

after(Money AfterAddition ): WithinSimulatedBank() && (call(public void Money.add(Money)) && target(AfterAddition))
{
	ToAccountBalance = AfterAddition.getCents();
	AfterTransfer = FromAccountBalance + ToAccountBalance ;
      System.out.println("Sum of accounts After Transfer :" + AfterTransfer/100 + "$");
	if((BeforeTransfer - AfterTransfer)!=0)
	{
		System.out.println("Invalid amount is transferred from one account to another");
	} 
	
}



}
