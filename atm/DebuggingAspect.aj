
//An Aspect which displays all the method executions within the ATM */

package atm;

public aspect DebuggingAspect {
	
	before() : execution (* *(..)) && !within(simulation.*){
		
		try{
			
			//Thread.sleep(200);
	}catch(Exception e){}
	     
		System.out.println("Entering : " + thisJoinPoint  );

	}
}







