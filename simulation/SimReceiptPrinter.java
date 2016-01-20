/*
 * ATM Example system - file SimReceiptPrinter.java
 *
 * copyright (c) 2001 - Russell C. Bjork
 *
 */
 
package simulation;

import java.awt.*;
import java.awt.event.*;

/** Simulate the receipt printer
 */
class SimReceiptPrinter extends Panel
{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/** Constructor
     */
    SimReceiptPrinter()
    {
        setLayout(new BorderLayout(5, 5));
        
        // The actual area where receipt prints
        
        printArea = 
            new TextArea("", ATMPanel.PRINTABLE_LINES, ATMPanel.PRINTABLE_CHARS,
                         TextArea.SCROLLBARS_VERTICAL_ONLY);
        printArea.setBackground(Color.white);
        printArea.setForeground(Color.black);
        printArea.setFont(new Font("Monospaced", Font.PLAIN, 12));
        printArea.setEditable(false);
        add(printArea, BorderLayout.SOUTH);
             
        // Give user a button to click to take receipt - only visible when a
        // receipt has been printed. We put the button in a panel with a
        // GridLayout to ensure it gets space, even when invisible
        
        Panel buttonPanel = new Panel();
        buttonPanel.setLayout(new GridLayout(1,1));
        take = new Button("Take receipt");
        buttonPanel.add(take);
        add(buttonPanel, BorderLayout.NORTH);
        take.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e)
            {
                printArea.setText("");
                take.setVisible(false);
            }
        });
        
        take.setVisible(false);
    }
    
    /** Print line to receipt
     *
     *  @param text the line to print
     */
    void println(String text)
    {
        printArea.append(text + '\n');
        try
        { 
            Thread.sleep(1 * 1000);
        }
        catch (InterruptedException e)
        { }

       take.setVisible(true);
    }        

    /** Simulated printout of receipt
     */
    private TextArea printArea;
    
    /** Button to allow the user to take the receipt
     */
    private Button take;
}                               
    
    
