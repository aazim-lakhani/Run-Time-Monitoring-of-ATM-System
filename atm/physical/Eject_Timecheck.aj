package atm.physical;

public aspect Eject_Timecheck {
	
		public long sTime,eTime,lapseTime;
		pointcut Ejection(): execution(public void CardReader.ejectCard());
		before():Ejection(){
			sTime=System.currentTimeMillis();
		}
		after():Ejection(){
			eTime=System.currentTimeMillis();
			lapseTime=eTime-sTime;
			if(lapseTime>3000){
				System.out.println("CARD READER WORKING INEFFICIENTLY BY "+(lapseTime-3000)+" MilliSeconds");
			}
			
		}
		
}
