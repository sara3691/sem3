import javax.swing.*;  
import java.awt.*;  
import java.awt.event.ActionEvent;  
import java.awt.event.ActionListener;  
  
public class calc extends JFrame implements ActionListener {    
   private JTextField textField;  
   private JButton[] buttons;    
   private String input = "";  
   private double num1, num2, result;  
   private char operator;   public calc() {  
   setTitle("Simple Calculator");   setSize(300, 400);  
   setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);    
   setLayout(new BorderLayout());  
  
   textField = new JTextField(10);  
   textField.setFont(new Font("Arial", Font.PLAIN, 24));          
   textField.setHorizontalAlignment(JTextField.RIGHT);   
   textField.setEditable(false);  
    JPanel panel = new JPanel(new GridLayout(4, 4));  
    String[] buttonLabels = {"7", "8", "9", "+", "4", "5", "6", "-", "1", "2", "3", "*", "C", "0", "=", "/"};          
    buttons = new JButton[buttonLabels.length]; 
  
  for (int i = 0; i < buttonLabels.length; i++) {    
      buttons[i] = new JButton(buttonLabels[i]);   
      buttons[i].addActionListener(this);   
      panel.add(buttons[i]);  
   }    
 
 
 
      add(textField, BorderLayout.NORTH);       
      add(panel);    
      setVisible(true);  
  }  
  
  public void actionPerformed(ActionEvent e) {  
  String command = ((JButton) e.getSource()).getText();  
  
  if (command.matches("[0-9]")) {      
        input += command;      
        textField.setText(input);  
  } 
 else if (command.matches("[+\\-*/]")) { 
         num1 = Double.parseDouble(input);              
        operator = command.charAt(0);             
        input = "";  
  } 
 else if (command.equals("=")) {              
         num2 = Double.parseDouble(input);              
         switch (operator) {                
              case '+':  
              result = num1 + num2;                
  break;               
 case '-':  
              result = num1 - num2;  
              break;  
              case '*':  
              result = num1 * num2;                
  break;               
 case '/':  
              result = num1 / num2;               
 
 
 
  break;  
            }  
            textField.setText(String.valueOf(result));              
            input = String.valueOf(result);           
           } 
           else if (command.equals("C")) {              
                input = "";             
                textField.setText("");  
           }  
        }  
        public static void main(String[] args) {  
          SwingUtilities.invokeLater(() -> new calc());  
        }  
      } 