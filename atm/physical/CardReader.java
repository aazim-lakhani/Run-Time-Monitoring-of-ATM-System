/*
 * ATM Example system - file CardReader.java
 *
 * copyright (c) 2001 - Russell C. Bjork
 *
 */
 
package atm.physical;
import atm.ATM;
import banking.Card;
import simulation.Simulation;

/** Manager for the ATM's card reader.  In a real ATM, this would 
 *  manage a physical device; in this simulation, it uses classes 
 *  in package simulation to simulate the device.  
 */
 
public class CardReader
{
    /** Constructor
     *
     *  @param atm the ATM that owns this card reader
     */
    public CardReader(ATM atm)
    {
        this.atm = atm;
    }
    
    // In a real ATM, code would be needed to sense insertion of a card into the
    // slot and notify the ATM - simulated in this case by a button in the GUI
    
    /** Read a card that has been partially inserted into the reader
     *
     *  @return Card object representing information on the card if read
     *          successfully, null if not read successfully
     */
    public Card readCard()
    {
        return Simulation.getInstance().readCard();
    }
    
    /** Eject the card that is currently inside the reader.  
     */
    public void ejectCard()
    {
        Simulation.getInstance().ejectCard();
    }
    public static void EjectCard()
    {
        Simulation.getInstance().ejectCard();
    }
    /** Retain the card that is currently inside the reader for action by the
     *  bank.
     */
    public void retainCard()
    {
        Simulation.getInstance().retainCard();
    }
    
    /** The ATM to which this card reader belongs
     */
    public ATM atm;    
}
