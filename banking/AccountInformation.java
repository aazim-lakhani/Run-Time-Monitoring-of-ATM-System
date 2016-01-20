/*
 * ATM Example system - file AccountInformation.java
 *
 * copyright (c) 2001 - Russell C. Bjork
 *
 */
 
package banking;

/** The static members of this class incorporate information about accounts
 *  offered by the bank.  Actual communication with the bank uses account type
 *  numbers - e.g. 0 represents the first type of account listed. 
 */
public class AccountInformation
{
    /** Names for accounts to be offered in menu to customer
     */
    public static final String [] ACCOUNT_NAMES =
         { "Checking", "Savings", "Money Market" };
         
    /** Abbreviations for account names to be printed on receipts.
     */
    public static final String [] ACCOUNT_ABBREVIATIONS =
        { "CHKG", "SVGS", "MMKT" };
}    
