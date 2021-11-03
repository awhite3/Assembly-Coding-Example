
import java.awt.*;
import javax.swing.*;

public class Wackadot {
	
	public static void main(String[] args){
		
		JFrame frame = new JFrame ("Wackadot");
	    frame.setDefaultCloseOperation (JFrame.EXIT_ON_CLOSE);

	    WackadotPanel panel = new WackadotPanel();
	    frame.getContentPane().add(panel);

	    frame.pack();
	    frame.setVisible(true);  
	}
}
