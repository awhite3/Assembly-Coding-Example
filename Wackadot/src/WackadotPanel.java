//********************************************************************
//  WackadotPanel.java       
//********************************************************************

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.*;

public class WackadotPanel extends JPanel {
   
	private int timer;
	private int score;
	private boolean playing;
	private JButton start;
	private JLabel label1;
	private JLabel label2;
	private JPanel buttonPanel;
	private Timer t;
	
	//-----------------------------------------------------------------
	//  
	//-----------------------------------------------------------------
	public WackadotPanel () {
		playing = false;
		timer = 30;
		score = 0;
				
		start = new JButton ("Play");
		t = new Timer(1000, null);
				
		ButtonListener buttonlisten = new ButtonListener();
		start.addActionListener (buttonlisten);
		
		ClockListener clocklisten = new ClockListener();
		t.addActionListener (clocklisten);
		
		label1 = new JLabel ();
      	label2 = new JLabel ();
      	writeLabel(label1, "Time Left: " + timer);
      	writeLabel(label2, "Score: " + score);
      	
      	buttonPanel = new JPanel();
      	buttonPanel.setPreferredSize(new Dimension(500, 40));
      	buttonPanel.setBackground(Color.lightGray);
      	buttonPanel.add (label1);
      	buttonPanel.add (start);
      	buttonPanel.add (label2);
      	
      	setPreferredSize (new Dimension(500, 500));
      	setBackground (Color.black);
      	add (buttonPanel);
	}
	
	public void writeLabel(JLabel label, String text){
		label.setText(text);
	}
	
	public void Start(){
		playing = true;
		t.start();
		start.setSelected(true);
		start.setText();
	}
	
	public void Stop(){
		playing = false;
		t.stop();
		start.setSelected(false);
	}
	 
	class ClockListener implements ActionListener {
		//--------------------------------------------------------------
		//  
		//--------------------------------------------------------------
		public void actionPerformed (ActionEvent event) {
			timer--;
			writeLabel(label1, "Time Left: " + timer);
			
			if(timer <= 0){
				Stop();
			}
		}	
	}	
	class ButtonListener implements ActionListener {
		//--------------------------------------------------------------
		// 
		//--------------------------------------------------------------
		public void actionPerformed (ActionEvent event) {
			if(timer == 30){
				Start();
			}else if (timer == 0){
				timer = 30;
				Start();
			}
		}
	}
	
	class MouseListener {

	}
	class WackadotLoop {
		
		public void loop(){
			while(playing) {
				score = 0;	
	  		} while(!playing) {
	  			timer = 30;
	  		}
		}	
	}
}
